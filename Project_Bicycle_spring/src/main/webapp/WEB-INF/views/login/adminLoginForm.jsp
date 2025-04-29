<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/u_header.jsp" %>	

<c:if test="${requestScope.msg != null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>

<div class="container w-50 shadow rounded border p-5 mt-5" style="height:400px">
   <form action="<c:url value="/login/adminLoginOk"/>" method="post">
   <!-- 인터셉터 발생시, 무브url의 마지막 주소를 넘겨줌 ==> 로그인폼, 로그인폼OK로 넘겨줌 -->
      
      <h3 class="text-center mb-4"><span class="material-symbols-outlined input-icon-symbol">person</span>&nbsp;관리자 로그인 </h3>
      <input class="form-control mb-3" type="text" id="id" name="id" placeholder="아이디"/>
      <input class="form-control mb-2" type="password" id="pw" name="password" placeholder="비밀번호"/>
	  		<c:if test="${requestScope.loginErr == 'idErr' || requestScope.loginErr == 'pwdErr'}">   
		    	<p class="text-danger text-center mt-3 mb-0" style="font-size:15px">아이디 또는 비밀번호 불일치!!</p>
		    </c:if>
      <div class="text-center pt-4">
      <input type="submit" class="btn btn-primary w-100" value="로그인" />

      </div>
   </form>
   
</div>

<%@ include file="../include/u_footer.jsp" %>