# RAG (Retrieval-Argumented Generation)  기반 챗봇 기능을 위해.   학습된 .json 파일 준비!

1. [크롤링] => json 파일 1차 준비.
  - 01_bike_FAQ_crawl.py   수행.
  - 02_bike_QnA_crawl.py   수행.

2. openAI 의 [ embedding API ] 사용해서 vector값을  json 파일에 추가.   ( nodejs 사용 )
   - 03_bike_embedding.js  수행.

3. chatbot 프로그램   => Spring에 .jsp 파일로 변환해서 사용가능.  (위에 준비된 .json 파일도 함께 가져다두고.)
   - 04_bot_bike_RAG.html


 #########################################################################
  cf> [해당 프로젝트 폴더]에서,
       conda 가상환경 (crawling) 선택하고,  <-- 이 안에 pip install .. 로 selenium 등 설치되어 있음.
         ===>    .py 파일 실행.
 
       nodejs 의 패키지 관리자인 npm 설치하기.   ( 터미널: npm init -y )   --> package.json 생성됨.
         ===>  (nodejs 문법이 포함된)  .js 파일 실행.      ( 터미널: node  AA.js )   
 ######################################################################### 