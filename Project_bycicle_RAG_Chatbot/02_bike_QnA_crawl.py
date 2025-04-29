import time                               # 대기 시간 설정을 위한 모듈
import json                               # JSON 파일 저장을 위한 모듈
import re                                 # 정규 표현식을 사용하기 위한 모듈
from selenium import webdriver            # 셀레니움 웹드라이버
from selenium.webdriver.common.by import By   # 요소 탐색 방식 지정
from selenium.webdriver.chrome.options import Options  # 크롬 옵션 설정

# 셀레니움 크롬 실행 옵션 설정
options = Options()
options.add_argument("--headless")        # 브라우저 창을 띄우지 않고 실행 (필요 시 주석 처리 가능)
driver = webdriver.Chrome(options=options)

# 고객의견 게시판 기본 URL
base_url = "https://www.bikeseoul.com/customer/opinionBoard/opinionBoardList.do"

# 1. 메뉴 정보 수집 (한 번만 실행하면 됨)
driver.get(base_url)                      # 페이지 접속
time.sleep(2)                             # 페이지 로딩 대기

# 상단 메뉴 항목들 가져오기 (고객의견 카테고리 버튼)
menu_elements = driver.find_elements(By.CSS_SELECTOR, ".opinion_btns dl dd.ticket a")
menu_list = []

# 첫 7개의 메뉴 항목을 순회하며 정보 추출
for idx, btn in enumerate(menu_elements[:7]):
    menu_text = btn.find_element(By.TAG_NAME, "b").text.strip()         # 메뉴 이름 텍스트
    onclick_value = btn.get_attribute("href")  
    # onclick 속성에서 카테고리 코드 추출, javascript:goCateList('FAQ_002');에서 FAQ_002 추출
    cate_code_match = re.search(r"goCateList\('(.+?)'\)", onclick_value)
    if cate_code_match:
        cate_code = cate_code_match.group(1)                            # 정규표현식으로 cate_code 추출
        menu_list.append((idx + 1, menu_text, cate_code))              # (번호, 메뉴이름, 코드)로 저장

# 2. 각 메뉴별로 다시 페이지 접속 후 해당 메뉴 클릭 → Q&A 수집
for idx, menu_text, cate_code in menu_list:
    driver.get(base_url)                    # 페이지 다시 진입 (초기화)
    time.sleep(1)

    # 자바스크립트 함수 호출을 통해 해당 메뉴 클릭 처리
    driver.execute_script(f"goCateList('{cate_code}')")
    time.sleep(2)                           # 로딩 대기

    print(f"[{idx}] 메뉴 클릭: {menu_text}")
    faq_items = driver.find_elements(By.CSS_SELECTOR, "ul.faq_list > li")  # Q&A 항목 리스트
    print(f"  → Q&A 개수: {len(faq_items)}")

    faq_data = []                           # 해당 메뉴의 Q&A 데이터를 담을 리스트
    for item in faq_items:
        try:
            # 질문 텍스트 추출
            question = item.find_element(By.CSS_SELECTOR, "dt > a > span.cont").text.strip()

            # 답변 텍스트 추출 (innerText로 줄바꿈 포함 내용 가져옴)
            answer = item.find_element(By.CSS_SELECTOR, "dd").get_attribute("innerText").strip()

            # 데이터 저장
            faq_data.append({"question": question, "answer": answer})
        except Exception as e:
            print(f"    항목 파싱 오류: {e}")

    # 파일 이름에서 사용할 수 없는 문자 제거 (윈도우 호환을 위해 특수문자 제거)
    safe_menu = re.sub(r'[\\/:*?"<>|]', "_", menu_text)
    filename = f"bike_qna_{idx}_{safe_menu}.json"

    # JSON 파일로 저장
    with open(filename, "w", encoding="utf-8") as f:
        json.dump(faq_data, f, ensure_ascii=False, indent=2)

    print(f"저장 완료: {filename}")
    print("-" * 50)

# 모든 작업 완료 후 브라우저 종료
driver.quit()
