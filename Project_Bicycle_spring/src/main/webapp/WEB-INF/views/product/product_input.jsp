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
   <h3>자전거 이용권(상품) 등록</h3>
   <form action="productRegisterOk" method="post" enctype="multipart/form-data" id="productForm">
      <table class="table table-borderless">
         <tbody>
            <tr>
               <td>카테고리</td>
               <td>
                  <select class="form-select form-select-sm" name="pcategory_fk">
                  	<c:forEach var="dto" items="${requestScope.cateList}">	
                    	<option value="${dto.code}">${dto.cat_name}[${dto.code}]</option>
                    </c:forEach>
                  </select>
               </td>
            </tr>
            <tr>
               <td>이용권명</td>
               <td><input type="text" class="form-control form-control-sm" id="pname" name="pname"/></td>
            </tr>
            <tr>
               <td>상품수량</td>
               <td><input type="text" class="form-control form-control-sm" name="pqty"/></td>
            </tr>
            <tr>
               <td>이용권가격</td>
               <td><input type="text" class="form-control form-control-sm" id="price" name="price"/></td>
            </tr>
            <tr>
               <td>이용권소개</td>
               <td>
                  <textarea class="form-control" id="pcontent" name="pcontent" rows="3"></textarea>
               </td>
            </tr>
            <tr>
               <td>이용포인트</td>
               <td><input type="text" class="form-control form-control-sm" name="point"/></td>
            </tr>
            <tr>
               <td colspan="2" class="text-center">
                  <input type="button" onClick="check_BicycleInput()" class="btn btn-sm btn-primary" value="이용권등록"/>   
                  <input type="reset" class="btn btn-sm btn-secondary" value="취소"/>   
               </td>
            </tr>
         </tbody>         
      </table>   
   </form>
</div>
<script>
	function check_BicycleInput() {
		
		if($("#pname").val() == "") {
			alert("이용권명을 등록해 주세요");
			return;
		}
		if($("#price").val() == "") {
			alert("가격을 등록해 주세요");
			return;
		}
		if($("#pcontent").val() == "") {
			alert("소개내용을 등록해 주세요");
			return;
		}
		
		//document.form.submit();
		$("form").submit();
	}
	
	
	
</script>
<jsp:include page="../include/u_footer.jsp"/>