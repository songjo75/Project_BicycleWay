<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
    
<jsp:include page="../include/u_header.jsp"/>    
<%@ include file="../include/u_top.jsp" %> 
 
<div class="container mt-5 border shadow p-5">

<c:if test="${successMsg != null}">
	<script> alert("${successMsg}"); </script>
</c:if>
<c:if test="${errorMsg != null}">
	<script> alert("${errorMsg}"); </script>
</c:if>

	<h2>카테고리 리스트</h2>
	<table class="table">
		<thead>
			<tr>
				<th>번호</th>
				<th>코드</th>
				<th>카테고리명</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="cateDto" items="${requestScope.cateList}">			
			<tr>
				<td>${cateDto.cat_num}</td>
				<td>${cateDto.code}</td>
				<td>${cateDto.cat_name}</td>
				<td><a href="cateDelete?cat_num=${cateDto.cat_num}" class="btn btn-sm btn-outline-danger">삭제</a></td>
			</tr>		
			</c:forEach>	
		</tbody>
	</table>
</div>
<jsp:include page="../include/u_footer.jsp"/> 