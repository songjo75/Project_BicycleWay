
from flask import Flask, render_template, send_file, url_for, jsonify
import pandas as pd               # pip install pandas
import matplotlib
matplotlib.use('Agg')     # 웹 환경에서는 GUI를 사용하지 않도록 설정.  (matplotlib는 기본적으로 GUI 사용.)
import matplotlib.pyplot as plt
import seaborn as sns             # pip install seaborn
import os
import requests

# matplotlib 한글 깨짐 방지 . 폰트 설정 (맑은고딕)
plt.rc("font", family="Malgun Gothic")
# 마이너스(-) 기호 깨짐 방지
plt.rcParams["axes.unicode_minus"] = False
####################################################


# 자전거 사고다발지정보 API url
# https://opendata.koroad.or.kr/data/rest/frequentzone/bicycle?authKey=인증키&요청변수&type=json
# 스쿨존어린이 사고다발지정보 API url
# https://opendata.koroad.or.kr/data/rest/frequentzone/schoolzone/child?authKey=인증키&요청변수&type=json
#/요청변수   
    #    authKey 인증키
    #    searchYearCd  연도코드
    #    siDo  시도코드
    #    guGun  시군구코드
    #    type  데이터유형  ( xml ,  json )
## [xml 응답]을 위한 요청 url
#   https://opendata.koroad.or.kr/data/rest/frequentzone/bicycle?authKey=인증키&searchYearCd=2023&sido=11&gugun=680
## [json 응답]을 위한 요청 url :  URL 요청변수 끝에 &type=json 을 붙여야,  JSON 형태로 값을 리턴한다.
#   https://opendata.koroad.or.kr/data/rest/frequentzone/bicycle?authKey=인증키&searchYearCd=2023&sido=11&gugun=680&type=json
AUTH_KEY = "BV9FeTx2DZNGcxsdVkvsr0wERM0QtbgCZVZPHpWnblAndaY%2BgM6f7sLDB5Fcjvmq"
BASE_URL_BICYCLE = "https://opendata.koroad.or.kr/data/rest/frequentzone/bicycle"
BASE_URL_SCHOOL = "https://opendata.koroad.or.kr/data/rest/frequentzone/schoolzone/child"
BASE_URL_PEDESTRIAN = "https://opendata.koroad.or.kr/data/rest/frequentzone/pdestrians/jaywalking"
SEARCH_YEAR = 2023
SEARCH_YEAR2 = 2019
SI_DO = 11  # 서울시 코드

# 서울시 구별 구군코드 목록 (딕셔너리)
GU_GUN_LIST = {
    "강남구": 680, "강동구": 740, "강북구": 305, "강서구": 500, "관악구": 620, "광진구": 215,
    "구로구": 530, "금천구": 545, "노원구": 350, "도봉구": 320, "동대문구": 230, "동작구": 590,
    "마포구": 440, "서대문구": 410, "서초구": 650, "성동구": 200, "성북구": 290, "송파구": 710,
    "양천구": 470, "영등포구": 560, "용산구": 170, "은평구": 380, "종로구": 110, "중구": 140, "중랑구": 260
}
#########################################################################################################

# 1. Flask 객체 생성
app = Flask(__name__)

# 2. Flask 서버 홈 HTML 첫 페이지 렌더링
@app.route("/")
def index():
    return render_template("flask_index.html")  # Flask HTML 첫 페이지 렌더링

########################################################################################################
# 3. Spring에서 Flask로 url 요청. [자전거 사고다발지역 조회] 메뉴. 
# 처음에 map_accident.html 에 서울중심 지도 그려서 보여줌.
@app.route("/accident")
def accident():
    return render_template("map_accident.html")  # 자전거 사고다발지역 카카오맵 표시하는 HTML 페이지 렌더링


# 4. map_accident.html 에서 [사고다발지역 표시하기] 버튼 클릭시.  axios.get(url) 요청이 여기로 옴.
@app.route("/get_accident_data")
def get_accident_data():
    accident_data = []
    total_accidents = 0

    # 서울시의 25개 구를 돌아가며, api 자료 요청해서 response로 받아 처리.
    for gu_name, gu_code in GU_GUN_LIST.items():
        url = f"{BASE_URL_BICYCLE}?authKey={AUTH_KEY}&searchYearCd={SEARCH_YEAR}&siDo={SI_DO}&guGun={gu_code}&type=json"
        print(f"요청 URL: {url}")

        response = requests.get(url)
        print(f"응답 상태 코드: {response.status_code}")

        if response.status_code != 200:
            print(f"{gu_name} API 요청 실패 - 상태 코드: {response.status_code}")
            continue

        try:
            data = response.json()   # json문자열 형태로 응답받은 자료를 -> 파이썬 객체인 딕셔너리로 변환. 
            print(f"응답 데이터: {data}")  # API에서 받아온 데이터 확인

            # JSON 구조에서 'items' 하위에 'item' 배열이 존재
            items = data.get("items", {}).get("item", [])

            if not items:
                print(f"⚠️ {gu_name}에 대한 사고 데이터 없음")
                continue  # 데이터가 없으면 건너뜀

            if isinstance(items, dict):  # 단일 항목일 경우 리스트로 변환
                items = [items]

            # 각 구 마다.  사고건수와 위도,경도 초기화
            gu_accidents = 0
            lat_sum, lng_sum, count = 0, 0, 0

            # items(딕셔너리들이 들어있는 list) 에서 ,  item(딕셔너리 하나)씩 꺼내와  속성key정보 가져와  처리.
            for item in items:
                acc_cnt = int(item.get("occrrnc_cnt", 0))
                lat = float(item.get("la_crd", 0))
                lng = float(item.get("lo_crd", 0))

                gu_accidents += acc_cnt        # 해당구 사고건수 누적
                total_accidents += acc_cnt     # 서울 total 사고건수 누적

                if lat and lng:
                    lat_sum += lat
                    lng_sum += lng
                    count += 1

            if count > 0:
                avg_lat = lat_sum / count      #  각 구의 위도 평균값 구하기
                avg_lng = lng_sum / count      #  각 구의 경도 평균값 구하기

                # 각 구 정보(딕셔너리) => 리스트에 추가.
                accident_data.append({
                    "gu_name": gu_name,
                    "accidents": gu_accidents,
                    "lat": avg_lat,
                    "lng": avg_lng
                })

        except Exception as e:
            print(f"JSON 파싱 오류 ({gu_name}): {e}")

    print(f"최종 사고 데이터: {accident_data}")

    # [25개 딕셔너리들의 리스트]를 data 라는 key로.    [서울시total사고건수]를  total_accidents 라는 key 로.
    # 정보를 담은 딕셔너리를 json문자열 형태로 return.
    return jsonify({
        "total_accidents": total_accidents,
        "data": accident_data
    })


# 5. Spring에서 Flask로 url 요청. [자전거 사고현황] 메뉴.   ( 그래프 그리기)
@app.route("/api/get_accident_chart")
def get_accident_chart():
    accident_data = []
    total_accidents = 0

    # 서울시의 25개 구를 돌아가며, api 자료 요청해서 response로 받아 처리.
    for gu_name, gu_code in GU_GUN_LIST.items():
        url = f"{BASE_URL_BICYCLE}?authKey={AUTH_KEY}&searchYearCd={SEARCH_YEAR}&siDo={SI_DO}&guGun={gu_code}&type=json"
        print(f"요청 URL: {url}")

        response = requests.get(url)
        print(f"응답 상태 코드: {response.status_code}")

        if response.status_code != 200:
            print(f"{gu_name} API 요청 실패 - 상태 코드: {response.status_code}")
            continue

        try:
            data = response.json()   # json문자열 형태로 응답받은 자료를 -> 파이썬 객체인 딕셔너리로 변환. 
            print(f"응답 데이터: {data}")  # API에서 받아온 데이터 확인

            # JSON 구조에서 'items' 하위에 'item' 배열이 존재
            items = data.get("items", {}).get("item", [])

            if not items:
                print(f"⚠️ {gu_name}에 대한 사고 데이터 없음")
                continue  # 데이터가 없으면 건너뜀

            if isinstance(items, dict):  # 단일 항목일 경우 리스트로 변환
                items = [items]

            # 각 구 마다.  사고건수 초기화
            gu_accidents = 0

            # items(딕셔너리들이 들어있는 list) 에서 ,  item(딕셔너리 하나)씩 꺼내와  속성key정보 가져와  처리.
            for item in items:
                acc_cnt = int(item.get("occrrnc_cnt", 0))

                gu_accidents += acc_cnt        # 해당구 사고건수 누적
                total_accidents += acc_cnt     # 서울 total 사고건수 누적

                # 각 구 정보(딕셔너리) => 리스트에 추가.    1. openAPI 활용하여 , 필요한 딕셔너리들의 리스트 생성.
                accident_data.append({
                    "gu_name": gu_name,
                    "accidents": gu_accidents
                })

        except Exception as e:
            print(f"JSON 파싱 오류 ({gu_name}): {e}")

    print(f"최종 사고 데이터: {accident_data}")

    # DataFrame 만들기  (with 딕셔너리들의 리스트로.)    
    df = pd.DataFrame(accident_data)
    print(df)

    ## 도화지 준비
    plt.figure(figsize=(15,8))

    ## 그래프 그리기
    plt.subplot(1,2,1)
    plt.bar(df["gu_name"],df["accidents"],color="g")
    plt.title("(막대 그래프)")
    plt.xlabel("(구 이름)")
    plt.ylabel("(사고건수)")
    plt.xticks(rotation=45)

    # plt.subplot(1,2,1)
    # plt.pie(df["accidents"], labels=df["gu_name"],autopct='%.1f%%')
    # plt.title("원 그래프")

    plt.subplot(1,2,2)
    plt.plot(df["gu_name"],df["accidents"],color="b")
    plt.title("(선 그래프)")
    plt.xlabel("(구 이름)")
    plt.ylabel("(사고건수)")
    plt.xticks(rotation=45)

    plt.show()


    # static 폴더가 없으면 생성
    if not os.path.exists("static"):
        os.makedirs("static")

    file_path = os.path.join(app.static_folder, "bicycle_accident.png")
    plt.savefig(file_path, format="png", dpi=100)
    plt.close()  # 메모리 해제

    # # Flask웹페이지에 차트 표시 경우
    # return render_template("accident_chart.html", 
    #                        title="자전거 구별 사고현황", 
    #                        image_url=url_for('static', filename='bicycle_accident.png',
    #                        _external=True))

    # # 외부(Spring)에서 요청 온 것에 응답 경우
    return jsonify({"image_url": url_for('static',filename='bicycle_accident.png', _external=True)})



#################################################################################################################
# 6. Spring에서 Flask로 url 요청. [스쿨존어린이 사고다발지역 조회] 메뉴. 
# 처음에 map_schoolzone.html 에 서울중심 지도 그려서 보여줌.
@app.route("/schoolzone")
def schoolzone():
    return render_template("map_schoolzone.html")  # 스쿨존 사고다발지역 카카오맵 표시하는 HTML 페이지 렌더링


# 7. map_schoolzone.html 에서 [ 스쿨존 사고다발지역 표시하기] 버튼 클릭시.  axios.get(url) 요청이 여기로 옴.
@app.route("/get_schoolzone_data")
def get_schoolzone_data():
    schoolzone_data = []
    total_accidents = 0

    # 서울시의 25개 구를 돌아가며, api 자료 요청해서 response로 받아 처리.
    for gu_name, gu_code in GU_GUN_LIST.items():
        url = f"{BASE_URL_SCHOOL}?authKey={AUTH_KEY}&searchYearCd={SEARCH_YEAR}&siDo={SI_DO}&guGun={gu_code}&type=json"
        print(f"요청 URL: {url}")

        response = requests.get(url)
        print(f"응답 상태 코드: {response.status_code}")

        if response.status_code != 200:
            print(f"{gu_name} API 요청 실패 - 상태 코드: {response.status_code}")
            continue

        try:
            data = response.json()   # json문자열 형태로 응답받은 자료를 -> 파이썬 객체인 딕셔너리로 변환. 
            print(f"응답 데이터: {data}")  # API에서 받아온 데이터 확인

            # JSON 구조에서 'items' 하위에 'item' 배열이 존재
            items = data.get("items", {}).get("item", [])

            if not items:
                print(f"⚠️ {gu_name}에 대한 사고 데이터 없음")
                continue  # 데이터가 없으면 건너뜀

            if isinstance(items, dict):  # 단일 항목일 경우 리스트로 변환
                items = [items]

            # 각 구 마다.  사고건수와 위도,경도 초기화
            gu_accidents = 0
            lat_sum, lng_sum, count = 0, 0, 0

            # items(딕셔너리들이 들어있는 list) 에서 ,  item(딕셔너리 하나)씩 꺼내와  속성key정보 가져와  처리.
            for item in items:
                acc_cnt = int(item.get("occrrnc_cnt", 0))
                lat = float(item.get("la_crd", 0))
                lng = float(item.get("lo_crd", 0))

                gu_accidents += acc_cnt        # 해당구 사고건수 누적
                total_accidents += acc_cnt     # 서울 total 사고건수 누적

                if lat and lng:
                    lat_sum += lat
                    lng_sum += lng
                    count += 1

            if count > 0:
                avg_lat = lat_sum / count      #  각 구의 위도 평균값 구하기
                avg_lng = lng_sum / count      #  각 구의 경도 평균값 구하기

                # 각 구 정보(딕셔너리) => 리스트에 추가.
                schoolzone_data.append({
                    "gu_name": gu_name,
                    "accidents": gu_accidents,
                    "lat": avg_lat,
                    "lng": avg_lng
                })

        except Exception as e:
            print(f"JSON 파싱 오류 ({gu_name}): {e}")

    print(f"최종 사고 데이터: {schoolzone_data}")

    # [25개 딕셔너리들의 리스트]를 data 라는 key로.    [서울시total사고건수]를  total_accidents 라는 key 로.
    # 정보를 담은 딕셔너리를 json문자열 형태로 return.
    return jsonify({
        "total_accidents": total_accidents,
        "school_data": schoolzone_data
    })



# 8.  Spring에서 Flask로 url 요청. [ 스쿨존 사고현황(그래프)] 메뉴. 
@app.route("/api/get_schoolzone_chart")
def get_schoolzone_chart():
    accident_data = []
    total_accidents = 0

    # 서울시의 25개 구를 돌아가며, api 자료 요청해서 response로 받아 처리.
    for gu_name, gu_code in GU_GUN_LIST.items():
        url = f"{BASE_URL_SCHOOL}?authKey={AUTH_KEY}&searchYearCd={SEARCH_YEAR}&siDo={SI_DO}&guGun={gu_code}&type=json"
        print(f"요청 URL: {url}")

        response = requests.get(url)
        print(f"응답 상태 코드: {response.status_code}")

        if response.status_code != 200:
            print(f"{gu_name} API 요청 실패 - 상태 코드: {response.status_code}")
            continue

        try:
            data = response.json()   # json문자열 형태로 응답받은 자료를 -> 파이썬 객체인 딕셔너리로 변환. 
            print(f"응답 데이터: {data}")  # API에서 받아온 데이터 확인

            # JSON 구조에서 'items' 하위에 'item' 배열이 존재
            items = data.get("items", {}).get("item", [])

            if not items:
                print(f"⚠️ {gu_name}에 대한 사고 데이터 없음")
                continue  # 데이터가 없으면 건너뜀

            if isinstance(items, dict):  # 단일 항목일 경우 리스트로 변환
                items = [items]

            # 각 구 마다.  사고건수 초기화
            gu_accidents = 0

            # items(딕셔너리들이 들어있는 list) 에서 ,  item(딕셔너리 하나)씩 꺼내와  속성key정보 가져와  처리.
            for item in items:
                acc_cnt = int(item.get("occrrnc_cnt", 0))

                gu_accidents += acc_cnt        # 해당구 사고건수 누적
                total_accidents += acc_cnt     # 서울 total 사고건수 누적

                # 각 구 정보(딕셔너리) => 리스트에 추가.
                accident_data.append({
                    "gu_name": gu_name,
                    "accidents": gu_accidents
                })

        except Exception as e:
            print(f"JSON 파싱 오류 ({gu_name}): {e}")

    print(f"chart 최종 사고 데이터: {accident_data}")

    ## DataFrame 만들기  (with 딕셔너리들의 리스트로.)
    df = pd.DataFrame(accident_data)
    print(df)

    ## 도화지 준비
    plt.figure(figsize=(15,8))

    ## 그래프 그리기
    plt.subplot(1,2,1)
    plt.bar(df["gu_name"], df["accidents"], color="g")
    plt.title("(막대그래프)로 보기")
    plt.xlabel("(구 이름)")
    plt.ylabel("(사고건수)")
    plt.xticks(rotation=45)

    plt.subplot(1,2,2)
    plt.plot(df["gu_name"], df["accidents"], color="b")
    plt.title("(선 그래프)로 보기)")
    plt.xlabel("(구 이름)")
    plt.ylabel("(사고건수)")
    plt.xticks(rotation=45)

    #plt.show()

    # static 폴더가 없으면 생성
    if not os.path.exists("static"):
        os.makedirs("static")

    file_path = os.path.join(app.static_folder, "school_accident.png")
    plt.savefig(file_path, format="png", dpi=100)
    plt.close()  # 메모리 해제

    ## Flask웹페이지에 차트 표시 경우 return
    # return render_template(
    #     "schoolzone_chart.html",
    #     title="스쿨존 사고현황",
    #     # image_url=url_for('static', filename='school_accident.png', _external=True)
    #     image_url=url_for('static', filename='school_accident.png')
    # )

    ## 외부(Spring)에서 요청 온 것에 응답 경우 return
    return jsonify({"image_url": url_for('static',filename='school_accident.png', _external=True)})



################################################################################################################
# 9. Spring에서 Flask로 url 요청. [보행자 무단횡단 사고지역 조회] 메뉴. 
# 처음에 map_schoolzone.html 에 서울중심 지도 그려서 보여줌.
@app.route("/pedestrian")
def pedestrian():
    return render_template("map_pedestrian.html")  # 스쿨존 사고다발지역 카카오맵 표시하는 HTML 페이지 렌더링


# 10. map_pedestrian.html 에서 [보행자 무단횡단 사고지역 표시]  버튼 클릭시.  axios.get(url) 요청이 여기로 옴.
@app.route("/get_pedestrian_data")
def pedestrian_data():
    pedestrian_data = []
    total_accidents = 0

    # 서울시의 25개 구를 돌아가며, api 자료 요청해서 response로 받아 처리.
    for gu_name, gu_code in GU_GUN_LIST.items():
        url = f"{BASE_URL_PEDESTRIAN}?authKey={AUTH_KEY}&searchYearCd={SEARCH_YEAR2}&siDo={SI_DO}&guGun={gu_code}&type=json"
        print(f"요청 URL: {url}")

        response = requests.get(url)
        print(f"응답 상태 코드: {response.status_code}")

        if response.status_code != 200:
            print(f"{gu_name} API 요청 실패 - 상태 코드: {response.status_code}")
            continue

        try:
            data = response.json()   # json문자열 형태로 응답받은 자료를 -> 파이썬 객체인 딕셔너리로 변환. 
            print(f"응답 데이터: {data}")  # API에서 받아온 데이터 확인

            # JSON 구조에서 'items' 하위에 'item' 배열이 존재
            items = data.get("items", {}).get("item", [])

            if not items:
                print(f"⚠️ {gu_name}에 대한 사고 데이터 없음")
                continue  # 데이터가 없으면 건너뜀

            if isinstance(items, dict):  # 단일 항목일 경우 리스트로 변환
                items = [items]

            # 각 구 마다.  사고건수와 위도,경도 초기화
            gu_accidents = 0
            lat_sum, lng_sum, count = 0, 0, 0

            # items(딕셔너리들이 들어있는 list) 에서 ,  item(딕셔너리 하나)씩 꺼내와  속성key정보 가져와  처리.
            for item in items:
                acc_cnt = int(item.get("occrrnc_cnt", 0))
                lat = float(item.get("la_crd", 0))
                lng = float(item.get("lo_crd", 0))

                gu_accidents += acc_cnt        # 해당구 사고건수 누적
                total_accidents += acc_cnt     # 서울 total 사고건수 누적

                if lat and lng:
                    lat_sum += lat
                    lng_sum += lng
                    count += 1

            if count > 0:
                avg_lat = lat_sum / count      #  각 구의 위도 평균값 구하기
                avg_lng = lng_sum / count      #  각 구의 경도 평균값 구하기

                # 각 구 정보(딕셔너리) => 리스트에 추가.
                pedestrian_data.append({
                    "gu_name": gu_name,
                    "accidents": gu_accidents,
                    "lat": avg_lat,
                    "lng": avg_lng
                })

        except Exception as e:
            print(f"JSON 파싱 오류 ({gu_name}): {e}")

    print(f"최종 사고 데이터: {pedestrian_data}")

    # [25개 딕셔너리들의 리스트]를 data 라는 key로.    [서울시total사고건수]를  total_accidents 라는 key 로.
    # 정보를 담은 딕셔너리를 json문자열 형태로 return.
    return jsonify({
        "total_accidents": total_accidents,
        "pedestrian_data": pedestrian_data
    })



# 11.  Spring에서 Flask로 url 요청. [보행자 무단횡단 사고(그래프)] 메뉴. 
@app.route("/api/get_pedestrian_chart")
def get_pedestrian_chart():
    accident_data = []
    total_accidents = 0

    # 서울시의 25개 구를 돌아가며, api 자료 요청해서 response로 받아 처리.
    for gu_name, gu_code in GU_GUN_LIST.items():
        url = f"{BASE_URL_PEDESTRIAN}?authKey={AUTH_KEY}&searchYearCd={SEARCH_YEAR2}&siDo={SI_DO}&guGun={gu_code}&type=json"
        print(f"요청 URL: {url}")

        response = requests.get(url)
        print(f"응답 상태 코드: {response.status_code}")

        if response.status_code != 200:
            print(f"{gu_name} API 요청 실패 - 상태 코드: {response.status_code}")
            continue

        try:
            data = response.json()   # json문자열 형태로 응답받은 자료를 -> 파이썬 객체인 딕셔너리로 변환. 
            print(f"응답 데이터: {data}")  # API에서 받아온 데이터 확인

            # JSON 구조에서 'items' 하위에 'item' 배열이 존재
            items = data.get("items", {}).get("item", [])

            if not items:
                print(f"⚠️ {gu_name}에 대한 사고 데이터 없음")
                continue  # 데이터가 없으면 건너뜀

            if isinstance(items, dict):  # 단일 항목일 경우 리스트로 변환
                items = [items]

            # 각 구 마다.  사고건수 초기화
            gu_accidents = 0

            # items(딕셔너리들이 들어있는 list) 에서 ,  item(딕셔너리 하나)씩 꺼내와  속성key정보 가져와  처리.
            for item in items:
                acc_cnt = int(item.get("occrrnc_cnt", 0))

                gu_accidents += acc_cnt        # 해당구 사고건수 누적
                total_accidents += acc_cnt     # 서울 total 사고건수 누적

                # 각 구 정보(딕셔너리) => 리스트에 추가.
                accident_data.append({
                    "gu_name": gu_name,
                    "accidents": gu_accidents
                })

        except Exception as e:
            print(f"JSON 파싱 오류 ({gu_name}): {e}")

    print(f"chart 최종 사고 데이터: {accident_data}")

    ## DataFrame 만들기  (with 딕셔너리들의 리스트로.)
    df = pd.DataFrame(accident_data)
    print(df)

    ## 도화지 준비
    plt.figure(figsize=(16,8))

    ## 그래프 그리기
    plt.subplot(1,2,1)
    plt.bar(df["gu_name"], df["accidents"], color="g")
    plt.title("(막대 그래프)로 보기")
    plt.xlabel("(구 이름)")
    plt.ylabel("(사고건수)")
    plt.xticks(rotation=45)

    plt.subplot(1,2,2)
    plt.plot(df["gu_name"], df["accidents"], color="b")
    plt.title("(선 그래프)로 보기")
    plt.xlabel("(구 이름)")
    plt.ylabel("(사고건수)")
    plt.xticks(rotation=45)

    plt.show()

    # static 폴더가 없으면 생성
    if not os.path.exists("static"):
           os.makedirs("static")

    file_path = os.path.join(app.static_folder, "pedestrian_accident.png")
    plt.savefig(file_path, format="png", dpi=100)
    plt.close()  # 메모리 해제

    ## Flask웹페이지에 차트 표시 경우 return
    # return render_template(
    #     "pedestrian_chart.html",
    #     title="스쿨존 사고현황",
    #     # image_url=url_for('static', filename='pedestrian_accident.png', _external=True)
    #     image_url=url_for('static', filename='pedestrian_accident.png')
    # )

    ## 외부(Spring)에서 요청 온 것에 응답 경우 return
    return jsonify({"image_url": url_for('static',filename='pedestrian_accident.png', _external=True)})


################################################################################################################



# 외부(Spring)에서 Flask 서버에 접근하는 경우. host="0.0.0.0" 설정해야 함!
# Spring 에서 html(jsp) 만들고,  axios.get(플라스크서버 컨트롤러 url) 로 요청으로 처리하는 경우에.
# app.run(host="0.0.0.0", port=5000, debug=True)
if __name__ == "__main__":
    #app.run(debug=True)
    app.run(host="0.0.0.0", port=5000, debug=True)
