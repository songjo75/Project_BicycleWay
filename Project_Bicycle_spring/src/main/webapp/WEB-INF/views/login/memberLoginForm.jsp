<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/u_header.jsp" %>	
<%@ include file="../include/u_top.jsp" %>	

<c:if test="${requestScope.msg != null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>
<c:if test="${requestScope.loginErr != null}">
	<script>
		alert("${requestScope.loginErr}");
	</script>
</c:if>

<div class="container w-50 shadow rounded border p-5 mt-5" style="height:400px">
   <form action="<c:url value="/login/userLoginOk"/>" method="post">
   <!-- 인터셉터 발생시, 무브url의 마지막 주소를 넘겨줌 ==> 로그인폼, 로그인폼OK로 넘겨줌 -->
      <h3 class="text-center mb-4"><span class="material-symbols-outlined input-icon-symbol">person</span>&nbsp;회원 로그인</h3>
      <input class="form-control mb-3" type="text" id="id" name="id" placeholder="아이디"/>
      <input class="form-control mb-2" type="password" id="pw" name="pw" placeholder="비밀번호"/>
	  		<c:if test="${requestScope.loginErr == 'idErr' || requestScope.loginErr == 'pwdErr'}">   
		    	<p class="text-danger text-center mt-3 mb-0" style="font-size:15px">아이디 또는 비밀번호 불일치!!</p>
		    </c:if>
      <div class="text-center pt-4">
         <input type="submit" class="btn btn-primary w-100" value="로그인"/>
      </div>
   </form>
   
   <div class="mt-3 w-100 findIdPw">
      <div class="d-flex justify-content-between">
         <div><i class="fa fa-lock"></i>&nbsp;<a href="<c:url value="/login/idPwFind?find=id"/>">아이디찾기</a>
         		<a>&nbsp;|&nbsp;&nbsp;</a><i class="fa fa-lock"></i>&nbsp;<a href="<c:url value="/login/idPwFind?find=pw"/>">비밀번호초기화</a></div>
         <div><i class="fa fa-user-plus"></i>&nbsp;<a href="<c:url value="/member/userJoin"/>">회원가입</a></div>
      </div>
   </div>
</div>

<%@ include file="../include/u_footer.jsp" %>