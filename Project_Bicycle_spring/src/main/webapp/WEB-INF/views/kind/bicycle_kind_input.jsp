<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
    
<c:if test="${requestScope.errorMsg != null}">
	<script>
		alert("${requestScope.errorMsg}");
	</script>
</c:if>

<%@ include file="../include/u_header.jsp" %>  
<%@ include file="../include/u_top.jsp" %>

<div class="container mt-5 border shadow p-5">
   <h3>자전거 종류 등록</h3>
   <form action="<c:url value='/kind/bicycleKindRegisterOk' />" method="post" enctype="multipart/form-data" id="bicycleKindForm">
      <table class="table table-borderless">
         <tbody>
            <tr>
               <td>자전거 종류코드</td>
               <td><input type="text" class="form-control form-control-sm" id="kind_code" name="kind_code"/></td>
            </tr>
            <tr>
               <td>자전거 종류명</td>
               <td><input type="text" class="form-control form-control-sm" id="kind_name" name="kind_name"/></td>
            </tr>            
            <tr>
               <td>자전거 이미지</td>
               <td>
                   <div id="div-file">
                      <!-- Controller 에서 다른 파라미터들을 @ModelAttribute로 dto로 받을 떄, 
                           file은 dto로 받아지지 않게,  @RequestParam으로 별도 요청해서, MultipartFile 타입으로 받아야 하므로,
                           file은 dto의 멤버필드명 아닌 별도의 파라미터명으로 보내기!   -->
                       <input type="file" class="form-control form-control-sm" id="bikefile" name="bikefile"/> 
                   </div>
               </td>
            </tr>
               <td>자전거 소개</td>
               <td>
                  <textarea class="form-control" id="content" name="content" rows="3"></textarea>
               </td>
            </tr>
            <tr>
               <td colspan="2" class="text-center">
                  <input type="button" onClick="check_BicycleKindInput()" class="btn btn-sm btn-primary" value="등록"/>   
                  <input type="reset" class="btn btn-sm btn-secondary" value="취소"/>   
               </td>
            </tr>
         </tbody>         
      </table>   
   </form>
</div>

<script>

	function check_BicycleKindInput() {
		
		if($("#kind_code").val() == "") {
			alert("자전거 종류코드를 입력해 주세요");
			return;
		}
		if($("#kind_name").val() == "") {
			alert("자전거 종류명을 압력해 주세요");
			return;
		}
		if($("#bikefile").val() == "") {
			alert("자전거 사진을 등록해 주세요");
			return;
		}
		if($("#content").val() == "") {
			alert("소개할 내용을 등록해 주세요");
			return;
		}
		
		//document.form.submit();
		$("form").submit();
	}
	
</script>

<%@ include file="../include/u_footer.jsp" %> 
