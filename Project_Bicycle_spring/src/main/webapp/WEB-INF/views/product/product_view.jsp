<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    

<%@ include file = "../include/u_header.jsp" %>  
<%@ include file = "../include/u_top.jsp" %>   


<div class="container mt-5">
	<main class="d-flex">
		<div>	
			<!-- 	<h3>도서정보[${requestScope.catName}]</h3>   --> 
				<h3>이용권정보</h3>
	            <ul class="d-flex" style="list-style:none">
				      
				      <li>
				         <form name="prodForm" method="post">
				            번호 : ${dto.pnum} <br> 
				            이용권 이름 : ${dto.pname}<br>
				            이용권 가격 : ${dto.price} <br>
				            이용권 포인트 : ${dto.point}<br>
				            이용권 수량 : <input type="text" name="pqty" size="3" value ="1" /> 개<br>
				            <p class="mt-3"><b>[이용권 소개]</b><br>
				               ${dto.pcontent}
				            </p>
				            
				            <input type="hidden" name="pnum" value ="${dto.pnum}" />
				            <input type="hidden" name="id" value ="${sessionScope.loginDTO.id}" />
				            
				                <!-- 관리자 로그인 되었을 경우  -->
				            	<c:if test = "${sessionScope.loginDTO.id != null && sessionScope.mode == 'admin'}" >
				                  <a href="javascript:alert('사용자로 로그인 해주세요.')" class="btn btn-sm btn-primary">장바구니 담기</a>
								</c:if>
				            
				            	<!-- 사용자 로그인 되었을 경우  -->
				                <c:if test = "${sessionScope.loginDTO.id != null && sessionScope.mode == 'user' }" >
				                <!--  <a href="javascript:gocart(${book.pnum},${sessionScope.loginDTO.id})" class="btn btn-sm btn-primary">장바구니 담기</a> -->
				                  <a href="javascript:gocart()" class="btn btn-sm btn-primary">장바구니 담기</a>
								</c:if>
								<!-- 로그인 안 되었을 경우  -->
				                <c:if test = "${sessionScope.loginDTO.id == null }" >
				                  <a href="javascript:alert('로그인이 필요합니다.')" class="btn btn-sm btn-primary">장바구니 담기</a>
								</c:if>
								
				            <a href="<c:url value='/' />" 
				               class="btn btn-sm btn-outline-primary">계속 쇼핑하기</a>
				         </form>
				      </li>
	            </ul>
			    
		</div>
	</main>
</div>
<script>
	function gocart(){
	//	alert("들어왔다");
	//	document.prodForm.action="<c:url value='/cart/cartAdd?pnum="+pnum+"&id="+id+"'/>";
	//	document.prodForm.action="<c:url value='/cart/cartAdd?pnum="+pnum+"&id=${sessionScope.loginDTO.id}'/>";
		document.prodForm.action="<c:url value='/cart/cartAdd'/>";
		document.prodForm.submit();
	}
</script>

<%@ include file = "../include/u_footer.jsp" %>    