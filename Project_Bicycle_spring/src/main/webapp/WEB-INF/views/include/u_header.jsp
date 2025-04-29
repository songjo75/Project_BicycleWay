<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자전거 산책</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- JQuery 라이브러리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- Bootstrap 라이브러리 -->
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- slick.js 라이브러리 -->
<!-- <script type="text/javascript" src="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> -->
<!-- slick  StyleSheet -->
<!-- <link rel="stylesheet" type="text/css" href="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/> -->
<!-- <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.min.css"/> -->

<!-- XEicon style css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css"><!-- 폰트어썸 style css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css">
<!-- Google Material Icons (Outlined) -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined&display=swap">
<!-- Axios 라이브러리 -->
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<!-- custom css -->
<link rel="stylesheet" href="<c:url value='/css/common.css'/>">
<link rel="stylesheet" href="<c:url value='/css/chatbot.css'/>">

</head>


<body>    <!-- u_footer 에서 닫기  -->
<div class="total_container">    <!-- u_footer 에서 닫기  -->

<header>	
<nav class="navbar navbar-expand-sm bg-light w-100">  

  <div class="container-fluid">
    <ul class="navbar-nav w-100">
      <li>
	      <a class="navbar-brand" href="<c:url value='/'/>">
	      	<img src="<c:url value='/imgs/bicycle_mainlogo.jpg'/>" alt="Logo" style="width:50px;" class="rounded-pill" /> 
	        <span style="color:#00CC66; font-size:23px; font-family:cursive;">Bicycle Way</span>
	   <!-- <span style="color:#00CC66; font-size:23px; font-family:"Nanum Pen Script", cursive; font-weight: 300;">자전거 산책 </span>  -->
	      </a>
      </li>

      
      <!-- 로그인 안했을 경우  -->
      <c:if test="${sessionScope.loginDTO.id == null}">
      	  <li class="ms-auto">
	        <a class="nav-link"  style="font-size:10px; color:gray;" href="<c:url value="/login/adminLogin" />">
	        	<img src="<c:url value='/imgs/ic_nomember.png'/>"/> 관리자로그인
	        </a>
	      </li>
	      <li class="nav-init ms-auto">
	        <a class="nav-init" href="<c:url value="/login/userLogin" />">
	        	<i class="material-symbols-outlined input-icon-symbol">login</i>로그인
	        </a>
	      </li>&nbsp;
	      <li class="nav-init">
	        <a class="nav-init" href="<c:url value="/member/userJoin" />">
	        	<i class="material-symbols-outlined">person_add</i>회원가입
	        </a>
	      </li>
      </c:if>
   	  
      <!-- ----------------- 사용자 로그인 했을 경우 -------------------------- -->   	  
      <c:if test="${sessionScope.loginDTO.id != null && sessionScope.mode == 'user'}">
      
      	  <li class="ms-auto" style="color:green; font-size:13px; line-height:40px;">
	     	   ${sessionScope.loginDTO.name}님 즐거운 하루되세요!! &nbsp;&nbsp;
	   	  </li>  
	<!--  <li class="nav-init">
	        <a class="nav-init" href="<c:url value="/login/pwModify?id=${sessionScope.loginDTO.id}"/>"  >
	             <span class="material-symbols-outlined">key</span> 비밀번호변경
	        </a>
	      </li>&nbsp;      -->
	      <li class="nav-init">
	        <a class="nav-init" href="<c:url value="/my/myForm?id=${sessionScope.loginDTO.id}"/>"  >
	             <span class="material-symbols-outlined">key</span> MyRoom
	        </a>
	      </li>&nbsp;	  
	   	  <li class="nav-init">
	        <a class="nav-init" href="<c:url value="/login/userLogout"/>" style="align-items: center;" >
	            <span class="material-symbols-outlined">logout</span> 로그아웃
	        </a>
	      </li>&nbsp;
   <!--   <li class="nav-init">
	        <a class="nav-init" href="<c:url value="/cart/cartList" />" style="align-items: center;">
	            <span class="material-symbols-outlined">luggage</span>장바구니
	        </a>
	      </li>      -->
   	  </c:if>
   	  
   	  
   	   <!-- -----------------관리자 로그인 했을 경우 --------------------------- -->   
      <c:if test="${sessionScope.loginDTO.id != null && sessionScope.mode == 'admin'}">
		
		  <li class="ms-auto" style="color:green; line-height:40px">
	     	관리자님 반가워요! &nbsp;&nbsp;
	   	  </li>		
	   	  <li class="nav-init">
	        <a class="nav-link" href="<c:url value="/login/adminLogout"/>" style="display:inline-block; color:gray;">관리자 로그아웃</a>
	      </li>&nbsp;
	      <li class="nav-init">
	        <a class="nav-link" href="<c:url value="/admin/adminMain"/>" style="display:inline-block; color:purple;">관리자홈</a>
	      </li>
   	  </c:if>
  	
    </ul>
  </div>
</nav>
  
</header>

