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
	<h3 style="align-items:center; color:teal; margin:auto; width:300px;">자전거 종류 소개</h3>
	<table class="table">
		<thead>
			<tr>
				<th>자전거 종류명</th>
				<th>이미지</th>
				<th>소개 내용</th>
				<th>수정/삭제</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${requestScope.bicycleKindList == null}">
				<tr>
					<td>등록된 자전거종류가 존재하지 않습니다!!</td>
				</tr>
			</c:if>
			<!-- 상품이 존재하는 경우  -->
			<c:if test="${requestScope.bicycleKindList != null}">
				<c:forEach var="dto" items="${requestScope.bicycleKindList}">
				<tr>
					<td style="width:15%" >${dto.kind_name}</td>
					<td style="width:10%">										
						<a href="<c:url value="/kind/kindView?kind_code=${dto.kind_code}" />">
							<img src="<c:url value="/uploads/${dto.kind_image}"/>" width="60px"/>
						</a>
					</td>
					<td style="width:60%">${dto.content}</td>
					<td style="width:15%">
						<a href="<c:url value="/kind/kindUpdate?kind_code=${dto.kind_code}" />" class="btn btn-sm btn-info">수정</a>
						<a href="javascript:kindDel('${dto.kind_code}','${dto.kind_image}')" 
							class="btn btn-sm btn-danger">삭제</a>
					</td>
				</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table> 
</div>

<script type="text/javascript">

    function kindDel(kind_code, kind_image){
		let isDel = confirm("삭제 하시겠습니까?");
		if(isDel) 
 			location.href="<c:url value='/kind/kindDelete?kind_code="+kind_code+"&kind_image="+kind_image+"'/>"; 			
	}
    
</script>

<%@ include file="../include/u_footer.jsp" %>
