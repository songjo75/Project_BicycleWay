<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<div class="menu w-100">
    
     <!-- ----------------- 로그인 안 한 경우 -------------------------- -->      
      <c:if test="${sessionScope.loginDTO.id == null}">
      <ul>  
         <li class="nav-item">
           <a class="nav-link" href="<c:url value="/rent/place" />">
           <img src="<c:url value='/imgs/icon_search.png'/>"/> [자전거대여소 안내]&nbsp;&nbsp;</a>
         </li>
         <li class="nav-item">
           <a class="nav-link" href="javascript:alert('로그인이 필요합니다.')">
           <img src="<c:url value='/imgs/zoom1.png'/>"/>[자전거이용권 구매] &nbsp;&nbsp;</a>
         </li>
         <li class="nav-item" ">
           <a class="nav-link" href="<c:url value="/kind/bicycleKindList"/>">
           <img src="<c:url value='/imgs/ic_foreigner.png'/>"/>[자전거 종류 소개]&nbsp;&nbsp;</a>
         </li> 
         
         <li class="nav-item">
         	<div class="dropdown">
			    <span style="color:#0080c0;"><img src="<c:url value='/imgs/ic_foreigner.png'/>"/>&nbsp;[사고다발 지역조회(List)]&nbsp;</span>
			    <div class="dropdown-content">
			<!--  <a class="nav-link" href="http://127.0.0.1:5000/accident">   Flask서버로 app.route(url) 직접 호출 link  -->
			      <a class="nav-link" href="<c:url value="/flask/accident"/>"> [자전거 사고다발지역]</a>
			      <a class="nav-link" href="<c:url value="/flask/schoolzone"/>"> [스쿨존어린이 사고다발지역]</a>
			      <a class="nav-link" href="<c:url value="/flask/pedestrian"/>"> [보행자무단횡단 사고다발지역]</a>
			    </div>
			</div>
         
         </li>
         
         <li class="nav-item">
			  <div class="dropdown">
			    <span style="color:#0080c0;"><img src="<c:url value='/imgs/ic_foreigner.png'/>"/>&nbsp;[사고현황 그래프(List)]&nbsp;</span>
			    <div class="dropdown-content">
			      <a class="nav-link" href="<c:url value="/flask/chart_bicycle_accident"/>"> [자전거 사고현황(그래프)]</a>
			      <a class="nav-link" href="<c:url value="/flask/chart_schoolzone_accident"/>"> [스쿨존어린이 사고현황(그래프)]</a>
			      <a class="nav-link" href="<c:url value="/flask/chart_pedestrian_accident"/>"> [보행자무단횡단 사고현황(그래프)]</a>
			    </div>
			  </div>
	     </li>
      </ul>
      </c:if>
      
      <!-- ----------------- 사용자 로그인 했을 경우 -------------------------- -->    
      <c:if test="${sessionScope.loginDTO.id != null && sessionScope.mode == 'user'}">
      <ul>   
         <li class="nav-item">
           <a class="nav-link" href="<c:url value="/rent/place" />">
           <img src="<c:url value='/imgs/icon_search.png'/>"/> [자전거대여소 안내]&nbsp;&nbsp;</a>
         </li>
         <li class="nav-item">
           <a class="nav-link" href="<c:url value="/buy/buy_form" />">
           <img src="<c:url value='/imgs/zoom1.png'/>"/>[자전거이용권 구매] &nbsp;&nbsp;</a>
         </li>
         <li class="nav-item">
           <a class="nav-link" href="<c:url value="/kind/bicycleKindList"/>">
           <img src="<c:url value='/imgs/ic_foreigner.png'/>"/>[자전거 종류 소개]&nbsp;&nbsp;</a>
         </li> 
         
         <li class="nav-item">
         	<div class="dropdown">
			    <span style="color:#0080c0;"><img src="<c:url value='/imgs/ic_foreigner.png'/>"/>&nbsp;[사고다발 지역조회(List)]&nbsp;</span>
			    <div class="dropdown-content">
			<!--  <a class="nav-link" href="http://127.0.0.1:5000/accident">   Flask서버로 app.route(url) 직접 호출 link  -->
			      <a class="nav-link" href="<c:url value="/flask/accident"/>"> [자전거 사고다발지역]</a>
			      <a class="nav-link" href="<c:url value="/flask/schoolzone"/>"> [스쿨존어린이 사고다발지역]</a>
			      <a class="nav-link" href="<c:url value="/flask/pedestrian"/>"> [보행자무단횡단 사고다발지역]</a>
			    </div>
			</div>
         </li>
         
         <li class="nav-item">
			  <div class="dropdown">
			    <span style="color:#0080c0;"><img src="<c:url value='/imgs/ic_foreigner.png'/>"/>&nbsp;[사고현황 그래프(List)]&nbsp;</span>
			    <div class="dropdown-content">
			      <a class="nav-link" href="<c:url value="/flask/chart_bicycle_accident"/>"> [자전거 사고현황(그래프)]</a>
			      <a class="nav-link" href="<c:url value="/flask/chart_schoolzone_accident"/>"> [스쿨존어린이 사고현황(그래프)]</a>
			      <a class="nav-link" href="<c:url value="/flask/chart_pedestrian_accident"/>"> [보행자무단횡단 사고현황(그래프)]</a>
			    </div>
			  </div>
	     </li>
       </ul>
       </c:if>
        
       <!-- -----------------관리자 로그인 했을 경우 --------------------------- -->   
       <c:if test="${sessionScope.loginDTO.id != null && sessionScope.mode == 'admin'}">
       <ul>
         <li class="nav-item" style="font-size:14px; color:blue;" >
           <a class="nav-link" href="<c:url value="/admin/cateInput" />">카테고리등록&nbsp;&nbsp;</a>
         </li>
         <li class="nav-item" style="font-size:14px; color:blue;">
           <a class="nav-link" href="<c:url value="/admin/cateList" />">카테고리리스트&nbsp;&nbsp;</a>
         </li>
         <li class="nav-item" style="font-size:14px; color:blue;">
           <a class="nav-link" href="<c:url value="/admin/productInput" />">이용권상품 등록&nbsp;&nbsp;</a>
         </li>
         <li class="nav-item" style="font-size:14px; color:blue;">
           <a class="nav-link" href="<c:url value="/admin/productList" />">이용권상품 리스트&nbsp;&nbsp;</a>
         </li> 
         <li class="nav-item" style="font-size:14px; color:blue;">
           <a class="nav-link" href="<c:url value="/member/memberList"/>">회원관리&nbsp;&nbsp;</a>
         </li> 
         <li class="nav-item" style="font-size:14px; color:blue;">
           <a class="nav-link" href="<c:url value="/kind/bicycleKindInput"/>">자전거 종류 등록&nbsp;&nbsp;</a>
         </li> 
         <li class="nav-item" style="font-size:14px; color:blue;">
           <a class="nav-link" href="<c:url value="/kind/bicycleKindList"/>">자전거 종류 소개&nbsp;&nbsp;</a>
         </li> 
        </c:if>
        </ul>
     
</div>