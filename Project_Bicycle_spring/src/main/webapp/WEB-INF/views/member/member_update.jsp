<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<c:if test="${requestScope.msg !=null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>

<%@ include file="../include/u_header.jsp" %>  
<%@ include file="../include/u_top.jsp" %>

<div class="container mt-5 border shadow p-5">
   <h3>회원 수정</h3>
   <form action="<c:url value="/member/memberUpdateOk"/>" method="post">
      <table class="table table-borderless">
         <tbody>
         	<tr>
         		<td>아이디</td>
         		<td>
         			<input type="text" class="form-control form-control-sm"
         				name="id" value="${bicycleMember.id}" readonly/>
         		</td>
         	</tr>
            <tr>
               <td>이름</td>
               <td><input type="text" class="form-control form-control-sm" 
               		name="name" value="${bicycleMember.name}" disabled/></td>
            </tr>
            <tr>
               <td>전화번호</td>
               <td><input type="text" class="form-control form-control-sm" 
               		name="tel" value="${bicycleMember.tel}"/></td>
            </tr>
            <tr>
               <td>이메일</td>
               <td><input type="text" class="form-control form-control-sm" 
               		name="email" value="${bicycleMember.email}"/></td>
            </tr>
            <tr>
               <td>주소</td>
               <td><input type="text" class="form-control form-control-sm" 
               		name="addr" value="${bicycleMember.addr}"/></td>
            </tr>
            <tr>
               <td colspan="2" class="text-center">
                  <input type="submit" class="btn btn-sm btn-primary" value="회원수정"/>   
                  <input type="reset" class="btn btn-sm btn-secondary" value="취소"/>   
               </td>
            </tr>
         </tbody>         
      </table>   
   </form>
</div>
<jsp:include page="../include/u_footer.jsp"/>