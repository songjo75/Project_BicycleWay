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
        <iframe src="${url}"  style="width:100%; height:680px; margin:auto;" align="center" />
    </div>
    
    
<%@ include file="../include/u_footer.jsp" %>