<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<c:if test="${requestScope.errorMsg != null}" >
	<script>
		alert("${requestScope.errorMsg}");
	</script>
</c:if>
    
<%@ include file="../include/u_header.jsp" %>
<%@ include file="../include/u_top.jsp" %>

<div class="container mt-5 border shadow p-5">
   <h3>자전거 종류정보 수정</h3>
   <form action="<c:url value="/kind/bicycleKindUpdateOk" />" method="post" enctype="multipart/form-data">
      <table class="table table-borderless">
         <tbody>
         	<tr>
               <td>자전거 종류코드</td>
               <td><input type="text" class="form-control form-control-sm" id="kind_code" name="kind_code"  value="${bicycleKind.kind_code}" readonly /></td>
            </tr>
            <tr>
               <td>자전거 종류명</td>
               <td><input type="text" class="form-control form-control-sm" id="kind_name" name="kind_name" value="${bicycleKind.kind_name}" /></td>
            </tr>            
            <tr>
               <td>자전거 이미지</td>
               <td>
                   <img src="<c:url value="/uploads/${bicycleKind.kind_image}"/>" width="100px"/><br/><br/>	
               	   <!-- 이미지를 수정 -->
               	   <input type="file" class="form-control form-control-sm" name="bicyclefile" /> 
               		
               	   <!-- 이미지를 수정하지 않는 경우 -->
               	   <input type="hidden" class="form-control form-control-sm" 
               		name="kind_image" value="${bicycleKind.kind_image}"/>
               </td>
            </tr>
               <td>자전거 소개</td>
               <td>
                  <textarea class="form-control" id="content" name="content" rows="3">${bicycleKind.content}</textarea>
               </td>
            </tr>
            <tr>
               <td colspan="2" class="text-center">
                  <input type="button" onClick="check_BicycleKindUpdate()" class="btn btn-sm btn-primary" value="수정"/>   
                  <input type="reset" class="btn btn-sm btn-secondary" value="취소"/>   
               </td>
            </tr>
            
         </tbody>         
      </table>   
   </form>
</div>

<script>

	function check_BicycleKindUpdate() {
		
		if($("#kind_name").val() == "") {
			alert("자전거 종류명을 압력해 주세요");
			return;
		}
		if($("#content").val() == "") {
			alert("소개할 내용을 입력해 주세요");
			return;
		}
		
		//document.form.submit();
		$("form").submit();
	}
	
</script>

<%@ include file="../include/u_footer.jsp" %>
