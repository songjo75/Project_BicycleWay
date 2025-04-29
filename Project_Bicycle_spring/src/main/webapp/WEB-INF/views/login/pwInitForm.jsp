<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/u_header.jsp" %>	
<%@ include file="../include/u_top.jsp" %>	

<c:if test="${requestScope.msg != null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>

<div class="container w-50 shadow rounded border p-5 mt-5" style="height:400px">
   <!-- 인터셉터 발생시, 무브url의 마지막 주소를 넘겨줌 ==> 로그인폼, 로그인폼OK로 넘겨줌 -->
      <h3 class="text-center mb-4"><span class="material-symbols-outlined input-icon-symbol">key</span>&nbsp;비밀번호 초기화</h3>
      <input class="form-control mb-3" type="text" id="id" name="id" placeholder="아이디"/>
      <div class="text-center pt-4">
         <input type="button" class="btn btn-primary w-100" onclick="pwInit()" value="비밀번호 초기화"/>
      </div>
      
      <br>
      <p id="chkMsg" style="color:red"> </p>
</div>

<%@ include file="../include/u_footer.jsp" %>

<script>

    const MEMBER_ID_CHECK_URL = "<c:url value="/login/pwInitOk"/>";

	function pwInit() {
		 let uid = $("#id").val().trim(); // 공백 제거
		 console.log(uid);
		    
		    if (!uid) {
		        alert("아이디를 입력해주세요.");
		        return;
		    }
		    
		    // get방식 요청임
		    axios.get(MEMBER_ID_CHECK_URL, {
		        params: { id: uid }
		    })
		    .then(response => {
		        const responseData = response.data;
		            $("#chkMsg").text(responseData);
		          
		    })
		    .catch(error => {
		        alert("서버 에러!!");
		    });     
	}
</script>