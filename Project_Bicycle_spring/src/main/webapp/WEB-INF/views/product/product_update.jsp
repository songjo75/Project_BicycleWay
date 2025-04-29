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
   <h3>이용권 수정</h3>
   <form action="productUpdateOk" method="post" enctype="multipart/form-data">
      <table class="table table-borderless">
         <tbody>
         	<tr>
         		<td>이용권번호</td>
         		<td>
         			<input type="text" class="form-control form-control-sm"
         				name="pnum" value="${bicycle.pnum}" readonly/>
         		</td>
         	</tr>
            <tr>
               <td>카테고리</td>
               <td>
                  <select class="form-select form-select-sm" name="pcategory_fk">
                  	<c:if test="${cateList == null}">
                  		<option value="">카테고리 없음</option>
                  	</c:if>
                  	<c:if test="${cateList != null}">
	                  	<c:forEach var="cDto" items="${requestScope.cateList}">	
	                    	<option value="${cDto.code}" 
	                    		${cDto.code == bicycle.pcategory_fk ? 'selected':''}>
	                    		${cDto.cat_name}[${cDto.code}]
	                    	</option>
	                    </c:forEach>
                    </c:if>
                  </select> 
               </td>
            </tr>
            <tr>
               <td>상품명</td>
               <td><input type="text" class="form-control form-control-sm" 
               		name="pname" value="${bicycle.pname}"/></td>
            </tr>      
            <tr>
               <td>이용권 수량</td>
               <td><input type="text" class="form-control form-control-sm" 
               		name="pqty" value="${bicycle.pqty}"/></td>
            </tr>
            <tr>
               <td>이용권 가격</td>
               <td><input type="text" class="form-control form-control-sm" 
               		name="price" value="${bicycle.price}"/></td>
            </tr>           
            <tr>
               <td>상품설명</td>
               <td>
                  <textarea class="form-control" name="pcontent" rows="3">${bicycle.pcontent}</textarea>
               </td>
            </tr>
            <tr>
               <td>상품포인트</td>
               <td><input type="text" class="form-control form-control-sm" 
               		name="point" value="${bicycle.point}"/></td>
            </tr>
            <tr>
               <td colspan="2" class="text-center">
                  <input type="submit" class="btn btn-sm btn-primary" value="수정"/>   
                  <input type="reset" class="btn btn-sm btn-secondary" value="취소"/>   
               </td>
            </tr>
         </tbody>         
      </table>   
   </form>
</div>
<%@ include file="../include/u_footer.jsp" %>