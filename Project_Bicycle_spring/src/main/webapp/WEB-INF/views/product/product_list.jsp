<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<c:if test="${requestScope.msg !=null}" >
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>
    
<%@ include file="../include/u_header.jsp" %>  
<%@ include file="../include/u_top.jsp" %>
   
<div class="container mt-5 border shadow p-5">
	<h3>자전거이용권 상품 리스트</h3>
	<table class="table">
		<thead>
			<tr>
				<th>번호</th>					
				<th>카테고리 코드</th>
				<th>이용권명</th>
				<th>가격</th>
				<th>수량</th>
				<th>수정/삭제</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${requestScope.bicycleList == null}">
				<tr>
					<td>상품이 존재하지 않습니다!!</td>
				</tr>
			</c:if>
			<!-- 상품이 존재하는 경우  -->
			<c:if test="${requestScope.bicycleList != null}">
				<c:forEach var="dto" items="${requestScope.bicycleList}">
				<tr>
					<td>${dto.pnum}</td>
					<td>${dto.pcategory_fk}</td>
					<td>${dto.pname}</td>
					<td>${dto.price}</td>
					<td>${dto.pqty}</td>
					<td>
						<a href="productUpdate?pnum=${dto.pnum}" class="btn btn-sm btn-info">수정</a>
						<a href="productDelete?pnum=${dto.pnum}" 
							class="btn btn-sm btn-danger">삭제</a>
					</td>
				</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table> 
</div>
<!-- <script type="text/javascript">
	function productDel(pnum){
		let isDel = confirm("삭제 하시겠습니까?");
		if(isDel) 
 			location.href="<c:url value='/product/productDelete?pnum="+pnum+'/>"; 			
	}
</script> -->
<jsp:include page="../include/u_footer.jsp"/> 