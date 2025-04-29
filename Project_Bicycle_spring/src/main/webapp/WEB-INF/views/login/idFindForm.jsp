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
  <!-- <form action="<c:url value="/login/idFindOk"/>" method="post">  -->
   <!-- 인터셉터 발생시, 무브url의 마지막 주소를 넘겨줌 ==> 로그인폼, 로그인폼OK로 넘겨줌 -->
      <h3 class="text-center mb-4"><span class="material-symbols-outlined input-icon-symbol">person</span>&nbsp;아이디 찾기</h3>
      <input class="form-control mb-3" type="text" id="name" name="name" placeholder="이름"/>
      <input class="form-control mb-2" type="text" id="email" name="email" placeholder="이메일"/>

      <div class="text-center pt-4">
         <input type="button" class="btn btn-primary w-100" onclick="idFind()" value="찾기"/>
      </div>
      
      <br>
      <p id="chkMsg" style="color:red"> </p>
   <!--  </form>  -->
</div>

<%@ include file="../include/u_footer.jsp" %>

<script>

    const MEMBER_ID_CHECK_URL = "<c:url value="/login/idFindOk"/>";

	function idFind() {
		 let uname = $("#name").val().trim(); // 공백 제거
		 console.log(uname);
		 let uemail = $("#email").val().trim(); // 공백 제거
		 console.log(uemail);
		    
		    if (!uname) {
		        alert("이름을 입력해주세요.");
		        return;
		    }
		    if (!uemail) {
		        alert("이메일을 입력해주세요.");
		        return;
		    }
		    
		    // get방식 요청임
		    axios.get(MEMBER_ID_CHECK_URL, {
		        params: { name: uname , email:uemail }
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