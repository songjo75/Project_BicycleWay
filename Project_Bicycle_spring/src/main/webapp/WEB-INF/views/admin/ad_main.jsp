<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/u_header.jsp" %> 
<%@ include file="../include/u_top.jsp" %> 
   
<div class="container mt-5 w-100">
	<h3 width="300px" style="color:teal; font-family:sans-serif;" align="left" >&nbsp;&nbsp;&nbsp;관리자 페이지</h3>
	<br>
	<ul style="display:block; list-style:none;">
		<li><a href="<c:url value="/admin/cateInput" />"><span class="material-symbols-outlined">favorite</span>&nbsp;자전거 카테고리 등록</a></li><br>
		<li><a href="<c:url value="/admin/cateList" />"><span class="material-symbols-outlined">favorite</span>&nbsp;자전거 카테고리 리스트</a></li><br>
		<li><a href="<c:url value="/admin/productInput" />"><span class="material-symbols-outlined">favorite</span>&nbsp;자전거 이용권 등록</a></li><br>
		<li><a href="<c:url value="/admin/productList" />"><span class="material-symbols-outlined">favorite</span>&nbsp;자전거 이용권 리스트</a></li><br>
		<li><a href="<c:url value="/member/memberList" />"><span class="material-symbols-outlined">favorite</span>&nbsp;자전거 회원 리스트</a></li><br>
		<li><a href="<c:url value="/kind/bicycleKindInput" />"><span class="material-symbols-outlined">favorite</span>&nbsp;자전거 종류 등록</a></li><br>
		<li><a href="<c:url value="/kind/bicycleKindList" />"><span class="material-symbols-outlined">favorite</span>&nbsp;자전거 종류 조회</a></li><br>
	</ul>
</div>
<jsp:include page="../include/u_footer.jsp"/>    