from selenium import webdriver                                # 웹 브라우저 자동화를 위한 모듈
from selenium.webdriver.chrome.service import Service         # ChromeDriver 서비스 객체
from selenium.webdriver.common.by import By                   # 요소 선택을 위한 By 클래스
from selenium.webdriver.chrome.options import Options          # Chrome 옵션 설정 클래스
import time                                                   # 대기 시간을 위한 모듈
import json                                                   # JSON 파일 저장을 위한 모듈

# Chrome 브라우저 실행 옵션 설정
options = Options()
options.add_argument("--headless")                            # 브라우저 창 없이 실행 (백그라운드 모드)
options.add_argument("--no-sandbox")                          # 샌드박스 모드 비활성화 (리눅스 환경에서 권한 문제 방지용)
options.add_argument("--disable-dev-shm-usage")               # 공유 메모리 관련 이슈 방지 옵션

# Chrome 드라이버 실행
driver = webdriver.Chrome(service=Service(), options=options)

# FAQ 페이지 접속
url = "https://www.bikeseoul.com/customer/faq/faqList.do?gbn=faq"
driver.get(url)

# 페이지 로딩 대기
time.sleep(2)

# FAQ 항목 전체 리스트 가져오기
items = driver.find_elements(By.CSS_SELECTOR, ".faq_list > li")

# 질문과 답변을 담을 리스트 초기화
faq_list = []

# 각 항목에 대해 반복 처리
for idx, item in enumerate(items, 1):
    try:
        # 질문 HTML 가져오기 (innerHTML: HTML 태그 포함 전체 내용)
        question_html = item.find_element(By.CSS_SELECTOR, "dt").get_attribute("innerHTML")

        # span.cont 안에 들어 있는 질문 텍스트만 추출
        start = question_html.find('<span class="cont">')
        end = question_html.find('</span>', start)
        question = question_html[start + len('<span class="cont">'):end].strip()

        # 질문이 비어 있을 경우 건너뜀
        if not question:
            print(f"[{idx}] 질문 비어있음 — 건너뜀")
            continue

        # 질문을 클릭하여 답변을 펼치기 (JavaScript 실행)
        link = item.find_element(By.CSS_SELECTOR, "dt a")
        driver.execute_script("arguments[0].click();", link)
        time.sleep(0.3)  # 클릭 후 잠시 대기 (답변 로딩 시간)

        # 답변 요소 찾기
        answer_el = item.find_element(By.CSS_SELECTOR, "dd")

        # 답변 텍스트 가져오기 (innerText로 텍스트만 추출)
        # '답변'이라는 텍스트를 제거하고 정리
        answer = answer_el.get_attribute("innerText").replace("답변", "").strip()

        # 결과를 딕셔너리로 저장 후 리스트에 추가
        faq_list.append({
            "question": question,
            "answer": answer
        })

        # 현재 항목의 질문 일부 출력
        print(f"[{idx}] Q: {question[:30]}")
    except Exception as e:
        # 예외 발생 시 에러 메시지 출력
        print(f"[{idx}] 오류 발생: {e}")

# 결과를 JSON 파일로 저장
with open("seoulbike_faq.json", "w", encoding="utf-8") as f:
    # ensure_ascii=False: 한글을 유니코드로 변환하지 않고 그대로 저장
    # indent=2: 사람이 보기 좋게 들여쓰기
    json.dump(faq_list, f, ensure_ascii=False, indent=2)

# 저장 완료 메시지 출력
print(f"\n총 {len(faq_list)}개 저장 완료: seoulbike_faq.json")

# 드라이버 종료
driver.quit()
