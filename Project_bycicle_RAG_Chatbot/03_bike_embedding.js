const fs = require("fs"); // 파일 시스템 모듈: 파일 읽기/쓰기용
const path = require("path"); // 경로 조작 모듈: 파일 경로 다룰 때 사용
const axios = require("axios"); // HTTP 요청 모듈: OpenAI API 호출에 사용

// 처리할 입력 JSON 파일들의 목록을 정의
const inputFiles = [
  "seoulbike_faq.json",
  "bike_qna_1_대여 및 반납.json",
  "bike_qna_2_자전거 추가배치.json",
  "bike_qna_3_대여소(개설_폐쇄).json",
  "bike_qna_4_결제_환불_마일리지.json",
  "bike_qna_5_운영 및 정책.json",
  "bike_qna_6_자전거 및 시설관리.json",
  "bike_qna_7_앱 또는 홈페이지 문의.json"
];

// OpenAI API 키 설정 (보안을 위해 외부 설정 파일 또는 환경변수로 관리하는 것이 안전함)
const apiKey = "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"; // OpenAI API 키 입력

/**
 * OpenAI API를 사용하여 입력된 텍스트의 임베딩 벡터를 가져오는 함수
 */
async function getEmbedding(text) {
  try {
    const response = await axios.post(
      "https://api.openai.com/v1/embeddings",
      {
        model: "text-embedding-ada-002", // 사용할 OpenAI 임베딩 모델
        input: text // 임베딩할 텍스트
      },
      {
        headers: {
          Authorization: `Bearer ${apiKey}`, // API 인증 헤더
          "Content-Type": "application/json"
        }
      }
    );
    return response.data.data[0].embedding; // 임베딩 결과 반환
  } catch (error) {
    console.error("임베딩 요청 중 오류 발생:", error.response?.data || error.message);
    return null;
  }
}

/**
 * 하나의 JSON 파일을 처리하는 함수
 * - 각 항목에 대해 질문+답변 텍스트를 결합하여 임베딩을 생성하고 저장
 * inputFile - 처리할 입력 파일 이름
 */
async function processFile(inputFile) {
  // 입력 JSON 파일을 동기적으로 읽어옴
  const raw = fs.readFileSync(inputFile, "utf-8");
  const data = JSON.parse(raw); // JSON 문자열을 객체로 변환
  const result = []; // 결과를 저장할 배열

  for (let i = 0; i < data.length; i++) {
    const item = data[i];

    // 질문/답변 또는 제목/설명을 합쳐서 임베딩 입력 텍스트 구성
    const inputText = item.question
      ? `${item.question} ${item.answer}` // FAQ 스타일 데이터
      : `${item.title} ${item.desc || ""}`; // title/desc 기반 데이터

    // 임베딩 API 호출
    const vector = await getEmbedding(inputText);
    if (!vector) continue; // 임베딩 실패 시 건너뜀

    // 기존 항목에 벡터 추가 후 결과 배열에 저장
    result.push({ ...item, vector });

    console.log(`[${i + 1}/${data.length}] ${inputFile} 항목 처리 중`);

    // 과도한 요청 방지를 위해 200ms 대기
    await new Promise((r) => setTimeout(r, 200));
  }

  // 파일명에서 .json 제거 후 _vector.json 확장자로 출력 파일 이름 생성
  const outputFile = path.basename(inputFile, ".json") + "_vector.json";

  // 결과를 JSON 파일로 저장 (2칸 들여쓰기 적용)
  fs.writeFileSync(outputFile, JSON.stringify(result, null, 2), "utf-8");
  console.log(`저장 완료: ${outputFile}\n`);
}

/**
 * 전체 파일들을 순차적으로 처리하는 메인 함수
 */
async function main() {
  for (const file of inputFiles) {
    console.log(`\n파일 처리 시작: ${file}`);
    await processFile(file);
  }
  console.log("전체 파일 처리 완료");
}

// 실행 시작
main();
