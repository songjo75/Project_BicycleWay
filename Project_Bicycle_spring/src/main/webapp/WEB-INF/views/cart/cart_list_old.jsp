<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   

<c:if test="${requestScope.errorMsg != null}" >
	<script>
		alert("${requestScope.errorMsg}");
	</script>
</c:if> 

<%@ include file="../include/u_header.jsp" %>  
<%@ include file="../include/u_top.jsp" %>
  
<div class="container mt-5">
	<main class="d-flex">
		<div>	
			<h3>장바구니 리스트</h3>
			   <table class="table">
			      <thead>
			         <tr>
			            <th>상품이미지</th>
			            <th>상품명</th>
			            <th>수량</th>
			            <th>판매가</th>
			            <th>합계</th>
			            <th>삭제</th>
			         </tr>
			      </thead>
			      <tbody>
			      	<c:if test="${cartList.size() == 0 }" >
			         <tr>
			            <td colspan="6">장바구니가 비었습니다!!</td>
			         </tr>
			        </c:if>
			        
			        <c:if test="${cartList.size() != 0 }" >
			        	<c:set var="cartTotPrice" value="0" />
			        	<c:set var="cartTotPoint" value="0" />
			        
				        <c:forEach var="dto"  items="${cartList}" >
				         <tr>
				            <td>
				               <a href="<c:url value="/admin/bookView?pnum=${dto.pnum}" />" >
				                  <img src="<c:url value='/uploads/${dto.pimage}' />" width="60px" />
				               </a>   
				            </td>
				            <td>${dto.pname}</td>
				            <td>
				               <form action="cartModify" method="post">
				                  <input type="hidden" name="cartId" 
				                     value="${dto.cart_id}"/>
				                  <input type="text" size="3" name="pqty"
				                     value="${dto.pqty}"/>개<br/>
				                  <input type="submit" value="수정"
				                     class="btn btn-sm btn-secondary mt-3"/>   
				               </form>
				            </td>
				            <td><fmt:formatNumber value="${dto.price}"/>원 <br/>
                                <fmt:formatNumber value="${dto.point}"/>포인트<br/>
				            </td>
				            <td>
				                <c:set var="totalPrice" value="${dto.price * dto.pqty}" />
				                <c:set var="totalPoint" value="${dto.point * dto.pqty}" />
				                <fmt:formatNumber value="${totalPrice}"/>원 <br/>
                                <fmt:formatNumber value="${totalPoint}"/>포인트<br/>
				            </td>
				            <td>
				               <a href="cartDelete?cartId=${dto.cart_id}" class="btn btn-sm btn-danger">삭제</a> 
				            </td>                  
				            
				         </tr>
				        <c:set var="cartTotPrice" value="${cartTotPrice + totalPrice}" />
			        	<c:set var="cartTotPoint" value="${cartTotPoint + totalPoint }" />
			        	
				        </c:forEach>
			        </c:if>
			      </tbody>
			   </table>
			
			   <div class="text-end">
			      장바구니 총액 : <fmt:formatNumber value="${cartTotPrice}"/> 원 <br>
			      총 포인트 :  <fmt:formatNumber value="${cartTotPoint}"/> 포인트 <br>
			   </div>
			   <div class="text-center">
			      <a href="javascript:alert('구매하기는 구현하지 않았습니다.')" class="btn btn-primary me-2">구매하기</a>
			      <a href="<c:url value='/'/>" class="btn btn-outline-primary me-2">계속 쇼핑하기</a>
			   </div>

		</div>
	</main>
</div>
<%@ include file="../include/u_footer.jsp" %>