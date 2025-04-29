<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="./include/u_header.jsp" %>
<%@ include file="./include/u_top.jsp" %>


<div class="contents-slider" 
     style="width:1100px; height: 650px; border:1px solid white; border-radius:10%; overflow:hidden; margin-top:10px; padding-top:0px;" >
        <div class="item"><img src="imgs/main_visual.jpg" width="1200px" alt="없음"></div>
        <div class="item"><img src="imgs/bicycle1.jpg" width="1200px" alt="없음"></div>
        <div class="item"><img src="imgs/bicycle2.jpg" width="1200px" alt="없음"></div>
        <div class="item"><img src="imgs/bicycle3.jpg" width="1200px" alt="없음"></div>
        <div class="item"><img src="imgs/bicycle4.jpg" width="1200px" alt="없음"></div>
</div>



<!-- <script src="homework.js"></script> -->
<script>

$(document).ready(function(){
    $(".contents-slider").slick( {
     infinite: true ,      // 무한반복
     slidesToShow: 1,     // 보여지는 슬라이드 개수
     slidesToScroll: 1,   // 넘어가는 슬라이드 개수
     dots: true,         // 점 네비게이션 표시
     arrows: true ,     // 화살표 표시
     fade: false,            // 페이드 효과
     vertical: false,         // 상하 슬라이드
     autoplay: true,       //자동스크롤
     autoplaySpeed: 2000 ,  //자동스크롤 속도
     pauseOnHover: true, // 마우스 호버하면 슬라이딩 멈춤

     // 버튼 커스터마이징
     prevArrow: "<button class='prevBtn'><i class='xi-angle-left' ></i></button>",
     nextArrow: "<button class='nextBtn'><i class='xi-angle-right' ></i></button>"
    }
    );
});

</script>

<!-- Carousel -->
<!-- <div id="demo" class="carousel slide" data-bs-ride="carousel">

  Indicators/dots
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>
    <button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
    <button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button>
    <button type="button" data-bs-target="#demo" data-bs-slide-to="3"></button>
    <button type="button" data-bs-target="#demo" data-bs-slide-to="4"></button>
  </div>

  The slideshow/carousel
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="imgs/1.jpg" alt=".." class="d-block w-80">
    </div>
    <div class="carousel-item">
      <img src="imgs/2.jpg" alt=".." class="d-block w-80">
    </div>
    <div class="carousel-item">
      <img src="imgs/3.jpg" alt=".." class="d-block w-80">
    </div>
    <div class="carousel-item">
      <img src="imgs/4.jpg" alt=".." class="d-block w-80">
    </div>
    <div class="carousel-item">
      <img src="imgs/5.jpg" alt=".." class="d-block w-80">
    </div>
  </div>

  Left and right controls/icons
  <button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
    <span class="carousel-control-next-icon"></span>
  </button>
</div> -->

<%@ include file="./include/u_footer.jsp" %>