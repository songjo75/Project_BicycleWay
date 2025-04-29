<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="../include/u_header.jsp" %>
<%@ include file="../include/u_top.jsp" %>


    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=8c7022399562d9f8f4adc86fc95ba34b&libraries=services"></script>
    <style>
        #map {
            width: 80%;
            max-width: 800px;
            height: 600px;
            margin: auto;
            
        }
        #search-container {
            text-align: center;
            margin: 20px;
        }
        #search-box {
            padding: 8px;
            width: 300px;
            font-size: 16px;
        }
        #search-btn {
            padding: 8px 12px;
            font-size: 16px;
            cursor: pointer;
        }
    </style>       

    <h4 style="text-align: center;"> [대여소 안내] 카카오맵 - 지역 검색</h4>
    
    <div id="search-container">
    <!--	<button onclick="getLocation()">내 위치 찾기</button>   -->
        <input type="text" id="search-box" placeholder="지역명을 입력하세요">
        <button id="search-btn">검색</button>
        <div id="results"></div>
    </div>

    <div id="map"></div>
    

<script>

		// 지도 관련 변수 선언    
		var map;
		var mapType = 'use_district' //'use_district'  // 'traffic';    // 'roadview'
		var currentTypeId;   // 지도에 추가된 지도타입정보를 가지고 있을 변수
	
		
	   // 이 페이지가 로드될 떄, 카카오Map API 가 있으면,  초기 지도 그리기 함수 호출! 
	   // 처음에 서울 중심부 (위도,경도) 주고 지도그리기 호출~
	   // 처음에 내위치 (위도,경도) 주고 지도그리기 호출~
	   document.addEventListener("DOMContentLoaded", function() {
	          //  initMap(37.5665 ,126.9780 );
	          getLocation();
	    });
		  
		 
	  // 초기 지도 그리기 
	    function initMap(lat, lng) { 
	    	  //  alert("initMap 들어왔다")
	        var container = document.getElementById('map');
	        var options = {
	            center: new kakao.maps.LatLng(lat, lng),
	            level: 3
	        };
	        map = new kakao.maps.Map(container, options);
	    }
	
	  // 내 위치 (위도,경도) 찾아서, 이 위치 중심으로 지도 그리기.
	    function getLocation() {
            if (navigator.geolocation) {
               //  이 Promise 함수를 호출 시,  매개변수로 function 2개를 넣어준 것임. ( 1.성공시 수행할 함수, 2.실패시 수행할 함수)
                navigator.geolocation.getCurrentPosition(      
                    function (position) {
                    	
                      // 1.내 위치를 중심점으로 지도 그리기	
                        var latitude = position.coords.latitude;   // 위도
                        var longitude = position.coords.longitude; // 경도
                        console.log("현재 위치: ", latitude, longitude);                   
                            initMap(latitude, longitude);      
            
                        
                      // 2.내위치 세팅 기본 마커 생성해서 지도에 그리기
                        // 1) 마커 생성에 필요한 옵션정보 준비
                        var mylocation =  new kakao.maps.LatLng(latitude, longitude);   // 내 위치 중심점
                        
                        var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; // 마커표시그림
                        var imageSize = new kakao.maps.Size(24, 35);   // 마커사이즈
                        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);  // 표시그림+사이즈 => 마커이미지 정보
                        
                         // 2) 위에 준비한 옵션들 반영해서 , 마커 생성
                        var marker = new kakao.maps.Marker({ 
                            position: mylocation,     // 내 위치 중심점을 위치로 마커 생성.
                            title: "내 위치",
                            image: markerImage     // 마커 이미지 정보
                        });
                        marker.setMap(map); 
                        
                      // 3. 지도타입 바꾸기 함수 호출!
                        setOverlayMapTypeId(mapType);    
                        
                    },
                    
                    function (error) {
                        console.error("위치 정보를 가져오는데 실패했습니다.", error);
                        alert("위치 정보를 가져올 수 없습니다.");
                    }
                );
            } else {
                alert("이 브라우저에서는 Geolocation을 지원하지 않습니다.");
            }
                                  
        }    // function getLocation()
	   
	  

	  // 지도 타입 바꾸기 함수 정의
	    function setOverlayMapTypeId(maptype) {
	        var changeMaptype;
	        
	        // maptype에 따라 지도에 추가할 지도타입을 결정합니다
	        if (maptype === 'traffic') {            
	            
	            // 교통정보 지도타입
	            changeMaptype = kakao.maps.MapTypeId.TRAFFIC;     
	            
	        } else if (maptype === 'roadview') {        
	            
	            // 로드뷰 도로정보 지도타입
	            changeMaptype = kakao.maps.MapTypeId.ROADVIEW;    

	        } else if (maptype === 'terrain') {
	            
	            // 지형정보 지도타입
	            changeMaptype = kakao.maps.MapTypeId.TERRAIN;    

	        } else if (maptype === 'use_district') {
	            
	            // 지적편집도 지도타입
	            changeMaptype = kakao.maps.MapTypeId.USE_DISTRICT;           
	        }
	        
	        // 이미 등록된 지도 타입이 있으면 제거합니다
	        if (currentTypeId) {
	            map.removeOverlayMapTypeId(currentTypeId);    
	        }
	        
	        // maptype에 해당하는 지도타입을 지도에 추가합니다
	        map.addOverlayMapTypeId(changeMaptype);
	        
	        // 지도에 추가된 타입정보를 갱신합니다
	        currentTypeId = changeMaptype;        
	    }
	    
	    
	    
	
	    // 지역명 검색 시,  ( 해당 지역의  자전거 대여소 위도,경도) 요청하고, 컨트롤러로부터 (위도, 경도) 응답받아서 newCenter 세팅하기.
	    // "컨트롤러"에서는 1) openAPI 에 자료 요청.  2) restTemplate 사용으로 JSONnode로 응답받아 response. 
	    // 아직 구현 안 했음. 
	    function searchLocation() {
	        var location = document.getElementById("search-box").value;
	
	        if (!location) {
	            alert("지역명을 입력하세요.");
	            return;
	        }
	
	       // ( 검색 지역의  자전거 대여소 위도,경도) 요청
	        axios.get("<c:url value='/rent/search?location=" + location + "' />")
                .then(response => {
                    let data = response.data;     // controller로부터 Map들의 List로 받아온다.
                    
                    console.log(data);
                    let resultDiv = document.getElementById("results");
                    resultDiv.innerHTML = "";
                    if (data.length === 0) {
                          resultDiv.innerHTML = `<p style="color:red;"> \${location} 에 대한 결과가 없습니다.</p>`;
                        return;
                    }
                    
                    // 해당 지역 자전거대여소 List<Map<String,Object>> 를 보내서, 마커 표시
                    displayMarkers(data);
                })
	       
	    }
	    
	   // 해당 지역 '대여소들 정보' [{key:value, key:value, ... },{},{}....] 응답받아,  마커 표시하는 함수 정의
	    function displayMarkers(rentStops) {
            var bounds = new kakao.maps.LatLngBounds();

            // 검색지역 대여소 정보  List<Map<String,Object>> rentStops
            rentStops.forEach(stop => {
            	var addr = stop.ADDR;
                var lat = parseFloat(stop.LAT);
                var lng = parseFloat(stop.LOT);
                
                
                var position = new kakao.maps.LatLng(lat, lng);              
             // var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; // 마커표시그림
                var imageSrc = "<c:url value='/imgs/bike01.png' />"; // 마커표시그림
                var imageSize = new kakao.maps.Size(24, 35);   // 마커사이즈
                var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);  // 표시그림+사이즈 => 마커이미지 정보

                // 기본 마커 생성
                var marker = new kakao.maps.Marker({ 
                    position: position,        // 마커 위치
                    title: addr,               // 마커 클릭시 보여주는 글자
                    image: markerImage         // 마커 이미지               
                });
                marker.setMap(map); 
                
                bounds.extend(position); // 마커들이 화면안에 모두 보이도록 화면을 자동 조정해줌

            });

            // 지도에 모든 마커가 보이도록 범위 조정
            if (rentStops.length > 0) {
                map.setBounds(bounds);
            }
        }
	    
	    
	    
	    document.getElementById("search-btn").addEventListener("click", searchLocation);
	    document.getElementById("search-box").addEventListener("keypress", function(event) {
	        if (event.key === "Enter") {
	            searchLocation();
	        }
	    });
	    	 
	    
</script>

<%@ include file="../include/u_footer.jsp" %>