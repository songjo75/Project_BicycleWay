<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%@ include file="../include/u_header.jsp" %>

<c:if test="${errorMsg != null}" >
	alert("${errorMsg}");
</c:if>

<div class="container mt-5 w-50 border shadow p-5">
   <h3>회원 가입</h3>
   <form action="userJoinOk" method="post" name="joinForm" id="joinForm">
      <div class="mt-3 mb-3">
         <lable for="id">아이디</lable>
         <input type="button" class="btn btn-sm btn-warning" 
         	value="아이디중복체크"  onclick="idCheck()"   />
         <input type="text" class="form-control" id="id" 
         placeholder="아이디" name="id"/>
         <p style="color:red"" id="chkMsg"></p>
      </div>
      <div class="mb-3">
         <lable for="pw">비밀번호</lable>
         <input type="password" class="form-control" id="pw" placeholder="비밀번호" name="pw"/>
      </div>
      <div class="mb-3">
         <lable for="pwConfirm">비밀번호 확인</lable>
         <input type="password" class="form-control" id="pwConfirm" placeholder="비밀번호 확인" name="pwConfirm"/>
      </div>
      <div class="mb-3">
         <lable for="name">이름</lable>
         <input type="text" class="form-control" id="name" placeholder="이름" name="name"/>
      </div>
      <div class="mb-3">
         <lable for="tel">전화번호</lable>
         <input type="text" class="form-control" id="tel" placeholder="전화번호" name="tel"/>
      </div>
      <div class="mb-3">
         <lable for="email">이메일</lable>
         <input type="text" class="form-control" id="email" placeholder="이메일" name="email"/>
      </div>
      <div class="mb-3">
         <lable for="addr">주소</lable>
         <input type="text" class="form-control" id="addr" placeholder="주소" name="addr"/>
      </div>
      
      <div class="text-center">
         <input type="button" class="btn btn-sm btn-primary" 
         	value="회원가입"  onclick="Validate()"   />
         <input type="reset" class="btn btn-sm btn-warning" value="취소"/>
      </div>
   </form>
</div> 
<script>
	const MEMBER_ID_CHECK_URL = "<c:url value="/member/userIdDupCheck" />";
</script>
<script src="<c:url value="/js/register.js" />"></script>
<jsp:include page="../include/u_footer.jsp"/>    