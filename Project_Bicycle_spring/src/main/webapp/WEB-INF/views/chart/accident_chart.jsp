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

    <div style="margin:auto; border:1px solid blue; border-radius:15px; overflow:hidden;">
    	<h3  style="width:100%; color:teal; font-family:sans-serif; margin-top:20px;" align="center" >${chartTitle}</h3>
	    <img src="${imgUrl}" alt="${chartTitle}"  style="width:100%; margin:auto;" align="center" />   
    </div>
    
<%@ include file="../include/u_footer.jsp" %>