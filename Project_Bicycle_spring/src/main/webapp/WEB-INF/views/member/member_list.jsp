<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<c:if test="${requestScope.msg !=null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>
    
<%@ include file="../include/u_header.jsp" %>  
<%@ include file="../include/u_top.jsp" %>   
 
<div class="container w-85 mt-5">
	<h3 style="align-items:center; color:teal; margin:auto; width:300px;"> 회원리스트 </h3>
	<table class="table">
		<thead>
			<tr>
			    <th>아이디</th>                                                                                     
		   <!-- <th>비밀번호</th>   -->                                                                               
		        <th>이름</th>                                                           
		        <th>이메일</th>                                                                                     
		        <th>전화번호</th>    
		        <th>주소</th>                                                                                
		   <!-- <th>가입일</th>      -->                                                                           
		        <th>수정/삭제</th>                                                                                       
		      </tr>                                                                                                 
		    </thead>                                                                                                
		    <tbody> 
			<c:if test="${mList.size() == 0 }">
				<tr>
					<td colspan="7">회원이 존재하지 않습니다!!</td>
				</tr>
			</c:if>
			<c:if test="${mList.size() !=0 }">
				<c:forEach var="dto" items="${mList}">
				<tr>
					<td style="width:10%">${dto.id}</td>
			<!--	<td style="width:15%">${fn:substring(dto.pw,0,5)}***</td>  -->		
					<td style="width:10%">${dto.name}</td>					
					<td style="width:10%">${dto.email}</td>
					<td style="width:15%">${dto.tel}</td>
					<td style="width:45%">${dto.addr}</td>
			<!--  	<td style="width:10%"><fmt:formatDate value="${dto.rdate}" pattern="yyyy-MM-dd"/></td>  -->
					<td style="width:10%">
					<!--  	<a href="memberUpdate?id=${dto.id}" class="btn btn-sm btn-info">수정</a>  -->
						<a href="javascript:memberDel('${dto.id}')" class="btn btn-sm btn-danger">삭제</a>
					</td>
				</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>
<script type="text/javascript">
	function memberDel(id){
		let isDel = confirm("삭제 하시겠습니까?");
		if(isDel) 
			location.href="memberDelete?id="+id;
	}
</script>

<%@ include file="../include/u_footer.jsp" %> 