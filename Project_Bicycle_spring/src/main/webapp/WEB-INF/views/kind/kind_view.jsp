<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    

<%@ include file = "../include/u_header.jsp" %>  
<%@ include file = "../include/u_top.jsp" %>   


<div class="container mt-5">
	<h3 style="align-items:center; color:teal; margin:auto; width:300px;"> ${bicycleKind.kind_name} </h3>
    <ul class="d-flex" style="list-style:none">
    
	      <li class="me-5">
	         <img src="<c:url value='/uploads/${bicycleKind.kind_image}'/>" width="500px"/>
	      </li>
	      
	      <li>
	         <form name="infoForm" method="post">
	            <p class="mt-3"><b>[소개]</b><br>
	               ${bicycleKind.content}
	            </p>
	            
	            <input type="hidden" name="id" value ="${sessionScope.loginDTO.id}" />
	            
	            <a href="<c:url value='/kind/bicycleKindList' />" 
	               class="btn btn-sm btn-outline-primary">List로 되돌아가기</a>
	         </form>
	      </li>
    </ul>
</div>

<%@ include file = "../include/u_footer.jsp" %>    
