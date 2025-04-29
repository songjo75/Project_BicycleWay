<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  <button id="chat-toggle-btn" >
  <!--  <svg id="toggle-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
      <path d="M12 2C6.48 2 2 5.94 2 10.5c0 2.18 1.14 4.14 3 5.53V22l4.03-2.36c.94.23 1.94.36 2.97.36 5.52 0 10-3.94 10-8.5S17.52 2 12 2z" fill="yellow"/>
      <path d="M9 15c.8.9 2 1.4 3 1.4s2.2-.5 3-1.4" fill="none" stroke="#007bff" stroke-width="2" stroke-linecap="round"/>
   </svg>    -->
     
  	<img id="toggle-icon" class="rounded" style="width:70px;" src="<c:url value = '/imgs/chatbot01.jpg' />" />
  </button>

  <div id="chat-widget">
    <div id="chat-header">문의사항 챗봇</div>
    <div id="chat-container"></div>
    <div id="input-area">
      <div class="input-wrapper">
        <input type="text" id="userInput" placeholder="궁금한 내용을 알려주세요." autocomplete="off" />
        <button id="sendBtn" onclick="sendToChatbot()" >
         <!--  <img src="https://cdn-icons-png.flaticon.com/512/3682/3682321.png" alt="Send" />   -->
          <img src="<c:url value='/imgs/send.png' />" alt="Send" />
        </button>
      </div>
    </div>
  </div>
  
  
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script>
	const BASE_URL = "<c:url value='/json/' />";
	const IMG_BASE_URL = "<c:url value='/imgs/' />";
</script>

 <script>
 
    // 챗봇 API 인증키
    const apiKey = "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";
                    
    let isFirstOpen = true;
    let isChatOpen = false;
    let contentData = [];
    
   // const URL_JSON = "<c:url value="/json/bicycle_seoul.json" />";
    const systemPrompt = `당신은 자전거 관련 문의를 안내하는 챗봇입니다.`;

    
  // ### RAG (Retrieval Argumented Generation) 기법 적용을 위해,  적정한 학습 데이터를 미리 준비!!  ########################
    // 1) 파이썬 .py 프로그램으로 crawling 해서 미리 정보 수집하고,
    // 2) openAI가 제공하는 embedding API 사용해서, 자연어를 기계가 이해가능한 vector로 변환한  ==> [.json 파일] 준비.  
    // 3) [.json 파일]을 fetch함수로 요청해서 가져오기.
    
   // # 파일이 한 개인 경우 
/*     fetch(BASE_URL+"seoulbike_faq.json")
      .then(res => res.json())
      .then(data => {
        contentData = data;
        console.log("📁 콘텐츠 로드 완료:", data.length);
      }); */
    
   // # 파일이 여러 개인 경우
   // 불러올 JSON 파일 목록 (FAQ + 7개 카테고리별 QnA)
    const files = [
    	BASE_URL+"seoulbike_faq_vector.json",
    	BASE_URL+"bike_qna_1_대여 및 반납_vector.json",
    	BASE_URL+"bike_qna_2_자전거 추가배치_vector.json",
    	BASE_URL+"bike_qna_3_대여소(개설_폐쇄)_vector.json",
    	BASE_URL+"bike_qna_4_결제_환불_마일리지_vector.json",
    	BASE_URL+"bike_qna_5_운영 및 정책_vector.json",
    	BASE_URL+"bike_qna_6_자전거 및 시설관리_vector.json",
    	BASE_URL+"bike_qna_7_앱 또는 홈페이지 문의_vector.json"
    ];

    // 위의 JSON 파일들을 모두 로딩
    async function loadData() {
      for (const file of files) {
        const res = await fetch(file);
        const json = await res.json();
        contentData.push(...json); // 배열에 계속 아래로 데이터를 이어 붙이기
      }
      console.log("총 로딩된 항목 수:", contentData.length);
    }

    loadData(); // 페이지 초기화 시 데이터 로딩 시작

    
    // ### 말풍선 만들어서 감싸주고  chat-container 창에 뿌려주는 함수.  ( 문의자,챗봇에 따라 스타일 다르게 주고.)  ###
    function appendMessage(role, text) {
      const chat = document.getElementById("chat-container");
      const msg = document.createElement("div");
      msg.className = "message " + (role === "user" ? "user" : "bot");

      const bubble = document.createElement("div");
      bubble.className = "bubble";
      bubble.innerText = text;

      msg.appendChild(bubble);
      chat.appendChild(msg);
      chat.scrollTop = chat.scrollHeight;
    }

    // ### RAG 기반 미리 준비된 json파일 list 중에, 사용자 문의사항과 유사 콘텐츠만 걸러내어 list로 필터링하는 함수  (vector 사용 안하는 경우)   ###
    function findRelevantContent(question) {
      const keyword = question.toLowerCase();
      return contentData.filter(item =>
        item.question.toLowerCase().includes(keyword) ||
        item.answer.toLowerCase().includes(keyword)
      );
    }

    // ### 질문에서 조사나 어미 제거하여 키워드 추출하는 함수   ###
    function extractKeywords(text) {
      const raw = text.toLowerCase()
        .replace(/[^가-힣a-z0-9\s]/g, "")
        .split(/\s+/)
        .filter(w => w.length > 1); // 2자 이상 단어만 유지

      const suffixes = ["은", "는", "이", "가", "을", "를", "에", "에서", "하다", "한가요", "하나요", "인가요", "나요"];

      return raw.map(word => {
        for (let s of suffixes) {
          if (word.endsWith(s) && word.length > s.length) {
            return word.slice(0, -s.length); // 조사 제거
          }
        }
        return word;
      });
    }

    // ### 사용자 질문을 임베딩 벡터로 변환하는 함수     ( vector 사용 위함)
    async function getEmbedding(text) {
      const res = await axios.post("https://api.openai.com/v1/embeddings", {
        input: text,
        model: "text-embedding-ada-002"
      }, {
        headers: {
          Authorization: `Bearer \${apiKey}`,
          "Content-Type": "application/json"
        }
      });
      return res.data.data[0].embedding;
    }

    // ### 두 벡터의 코사인 유사도 계산하는 함수   ( [RAG 기반을 위해 .json 파일에 준비된 vector] vs [사용자 문의 embedding한 vector] 유사도 계산  )
    function cosineSimilarity(a, b) {
      const dot = a.reduce((sum, val, i) => sum + val * b[i], 0); // 내적
      const normA = Math.sqrt(a.reduce((sum, val) => sum + val * val, 0));
      const normB = Math.sqrt(b.reduce((sum, val) => sum + val * val, 0));
      return dot / (normA * normB);
    }
  
  
     // ★★ ### openAI 가 제공하는 챗봇API 에 요청하고 응답받는 함수 ★★★  ######################
     async function sendToChatbot() {
	  
	      // 사용자 문의 입력값 준비해서 , 채팅창에 뿌려주기. 
	      const input = document.getElementById("userInput");
	      const question = input.value.trim();
	      if (!question) return;
	
	      appendMessage("user", question);
	      input.value = "";
	      input.focus();
	
      /******* RAG 기반 챗봇을 위해,  챗봇API 에 문의사항 응답을 위한 [유사 기반 자료]를 보내주기 위해 준비!  Start! **********/ 
 
      /****  방법1.  embedding한 vector 사용 안 하는 경우   *****/  
      
/* 	   // 1) 미리 학습된 json파일 list 중에, 사용자 문의사항과 유사 콘텐츠만 걸러내어 list 리턴.
	      const matches = findRelevantContent(question);
	      let context = "";
	
	   // 2) 미리 학습준비된 json 파일 중, 문의사항 관련 내용 걸러낸 대상 => 챗봇API 에 (응답 준비에 사용하라고 )보내기 위해 준비.  (matches  => context) 
	      if (matches.length > 0) {
	        context = matches.slice(0, 3).map(item =>
	          `• \${item.title}\n\${item.desc}\n링크: \${item.link}`
	        ).join("\n\n");
	      } else {
	        context = "관련 콘텐츠를 찾지 못했습니다.";
	      }
	
	   // 3) 챗봇API 에 응답 기반으로 사용하라고 (matches  => context => messages ) 준비된 대상 컨텐츠를 보낸다.
	      const messages = [
	        { role: "system", content: systemPrompt },
	        { role: "user", content: `다음은 콘텐츠입니다:\n\n${context}\n\n사용자 질문: ${question}` }
	      ]; */
	
	      
	   /****  방법2.  embedding한 vector 사용하는 경우   ******/
	   
	      const userEmbedding = await getEmbedding(question); // 질문 임베딩 생성
	      const keywords = extractKeywords(question);         // 키워드 추출

	      // 1) 각 콘텐츠 항목에 대해 유사도 및 키워드 일치 점수 계산
	      const scored = contentData.map(item => {
	        const text = (item.question || item.title || "") + " " + (item.answer || item.desc || "");

	        const keywordScore = keywords.reduce((score, kw) => {
	          return score + (text.includes(kw) ? 0.5 : 0); // 키워드 하나당 0.5점
	        }, 0);

	        const simScore = cosineSimilarity(userEmbedding, item.vector); // 임베딩 유사도
	        const finalScore = simScore * 0.7 + keywordScore * 0.3;         // 가중 합산

	        return { ...item, score: finalScore };
	      });

	      // 2) 상위 3개 항목 선택
	      const top = scored.sort((a, b) => b.score - a.score).slice(0, 3);

	      // 3) 유사한 항목이 없을 경우 안내
	      if (top.length === 0) {
	        appendMessage("bot", "죄송합니다. 관련된 정보를 찾을 수 없었습니다.");
	        return;
	      }

	      // 4) GPT에게 전달할 참고용 문맥 구성
	      const context = top.map(item =>
	        `• \${item.question || item.title}: \${item.answer || item.desc}`
	      ).join("\n\n");     
	      
	      
	     // 5) 챗봇API 에 응답 기반으로 사용하라고 (matches  => context => messages ) 준비된 대상 컨텐츠를 보낸다.
	      const messages = [
	        { role: "system", content: systemPrompt },
	        { role: "user", content: `다음은 콘텐츠입니다:\n\n\${context}\n\n사용자 질문: \${question}` }
	      ]; 
	      
 	 /******* RAG 기반 챗봇을 위해,  챗봇API 에 문의사항 응답을 위한 [유사 기반 자료]를 보내주기 위해 준비!  End! **********/     
	   
	 /******* ★★★ ## openAI 가 제공하는 챗봇API 에 요청하기.  axios.post로 요청.  ## ★★★ ********* */     
	      try {
		        const response = await axios.post("https://api.openai.com/v1/chat/completions", {
		          model: "gpt-3.5-turbo",
		          messages: messages
		        }, {
		          headers: {
		            "Content-Type": "application/json",
		            Authorization: `Bearer \${apiKey}`
		          }
		        });
		
		        const reply = response.data.choices?.[0]?.message?.content || "⚠️ 응답 오류";
		        appendMessage("bot", reply);
	        
	      } catch (err) {
		        console.error(err);
		        appendMessage("bot", "❗ 오류가 발생했습니다.");
	      }
    }

  

    document.getElementById("chat-toggle-btn").addEventListener("click", () => {
      const widget = document.getElementById("chat-widget");
      const icon = document.getElementById("toggle-icon");
      isChatOpen = !isChatOpen;
      widget.style.display = isChatOpen ? "flex" : "none";
      
      icon.src = isChatOpen ? IMG_BASE_URL+"close.png" : IMG_BASE_URL+"chatbot01.jpg"  ;
        
        if (isChatOpen && isFirstOpen) {
        appendMessage("bot", "안녕하세요! 자전거 관련해서 무엇이 궁금하신가요?");
        isFirstOpen = false;
      }
    });

    document.getElementById("userInput").addEventListener("keydown", e => {
      if (e.key === "Enter") sendToChatbot();
    });
    
 </script>
  