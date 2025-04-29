<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- 천단위로 변경 -->

<%@ include file="../include/u_header.jsp" %>	
<%@ include file="../include/u_top.jsp" %>	

<style>/* 세로정렬 */
	td {vertical-align:middle;}
</style> 

<!-- msg 띄우는 것 -->
<c:if test="${requestScope.msg != null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>

<div class="container ps-5 w-75 mt-3">
	<h3>장바구니 리스트</h3><br>
	<table class="table">
		<thead>
			<tr>
				<th>상품명</th>
				<th>수량</th>
				<th>판매가</th>
				<th>합계</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
			<!-- '장바구니 담기'가 아닌, '장바구니 확인'하기를 하였을때 장바구니가 없을경우 확인 -->
			<c:if test="${dtos.size() == 0}">
				<tr>
					<td colspan="6">장바구니가 비었습니다!!</td>
				</tr>
			</c:if>
			<c:if test="${dtos.size() != 0}">
				<!-- 총액 합계초기화 -->
				<c:set var="cartTotPrice" value="0"/>
				<c:set var="cartTotPoint" value="0"/>
				
				<!-- 카트리스트 커맨드에서 바인딩된 dtos를 dto-var변수에 넣는다  -->
				<c:forEach var="dto" items="${dtos}"> 
					<tr>
						<td>
							<a href="ProductView.do?pnum=${dto.pnum}"> <!-- 클릭시 접속링크 -->
							</a>
						</td>
						<td>${dto.pname}</td>
						<td><br>
							<form action="modifyCart.do" method="post">
								<input type="hidden" name="cart_num" value="${dto.cart_num}"/>
								<input type="text" size="3" name="pqty" value="${dto.pqty}"/>개<br/>
								<input type="submit" value="수정" class="btn btn-sm btn-secondary mt-3"/>
							</form>
						</td>
						<td>
							<fmt:formatNumber value="${dto.price}"/>원<br/>
							<fmt:formatNumber value="${dto.point}"/>포인트
						</td>
						<td>
							<fmt:formatNumber value="${dto.totPrice}"/>원<br/>
							<fmt:formatNumber value="${dto.totPoint}"/>포인트
						</td>
				    	<td>
				    		<form action="deleteCart.do" method="post">
								<input type="hidden" name="cart_num" value="${dto.cart_num}"/>
								<input type="submit" value="삭제" class="btn btn-sm btn-danger"/>
							</form>
							<!-- <a href="cartDelete.do" class="btn btn-sm btn-danger">삭제</a> -->
						</td>
						
						<!-- 총액 합계 계산 -->
						<c:set var="cartTotPrice" value="${cartTotPrice + dto.totPrice}"/>
						<c:set var="cartTotPoint" value="${cartTotPoint + dto.totPoint}"/>
						
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table><br/>
	<!-- 장바구니 총액표시 -->
	<div class="text-end">
		장바구니 합계 :  <fmt:formatNumber value="${cartTotPrice}"/> 원 <br>
		포인트 합계 : <fmt:formatNumber value="${cartTotPoint}"/> 포인트 <br>
	</div><br/>
	<div class="text-center">
		<c:if test="${dtos.size() != 0}">	<!-- 장바구니 비어있지 않을때 구매하기 버튼 활성화 -->
			<a href="checkout.do" class="btn btn-primary me-2">구매하기</a>
		</c:if>
		<a href="<c:url value="userMainForm.do"/>" class="btn btn-outline-primary me-2">계속 쇼핑하기</a>
	</div>
</div>

<%@ include file="../include/u_footer.jsp" %>