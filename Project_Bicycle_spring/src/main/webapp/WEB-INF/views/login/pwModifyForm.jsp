<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/u_header.jsp" %>
<%@ include file="../include/u_top.jsp" %>	

<c:if test="${requestScope.msg != null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>

<div class="container w-50 shadow rounded border p-5 mt-5" style="height:470px">
      <h3 class="text-center mb-4"><span class="material-symbols-outlined input-icon-symbol">key</span>&nbsp;비밀번호 변경</h3>
      <p style="color:tomato;">비밀번호는 영문,숫자,특수문자 포함 8자리 이상 입력해주세요.</p>
      <input class="form-control mb-3" type="text" id="id" name="id" value="${requestScope.id}" readonly />
      <input class="form-control mb-3" type="text" id="pw" name="pw" placeholder="수정할 비밀번호"/>
      <input class="form-control mb-3" type="text" id="pw_confirm" name="pw_confirm" placeholder="수정할 비밀번호 확인"/>
      
      <div class="text-center pt-4">
         <input type="button" class="btn btn-primary w-100" onclick="pwModify()" value="비밀번호 변경"/>
      </div>
      
      <br>
      <p id="chkMsg" style="color:violet"> </p>
      
</div>

<script>

    const MEMBER_PW_MODIFY_URL = "<c:url value="/login/pwModifyOk"/>";

	function pwModify() {
		// 유효성 검사들 먼저
		 let uid = $("#id").val().trim(); // 공백 제거
		 console.log(uid);
		    
		    if (!uid) {
		        alert("아이디를 입력해주세요.");
		        return;
		    }
		    
	    let upw = $("#pw").val().trim(); // 공백 제거
	    let upw_confirm = $("#pw_confirm").val().trim(); // 공백 제거
		 console.log(upw);
		    
		    if (!upw) {
		        alert("수정하실 [비밀번호]를 입력해주세요.");
		        return;
		    }
		    
		    if (!upw_confirm) {
		        alert("수정하실[ 비밀번호 확인]을 입력해주세요.");
		        return;
		    }
		    
		    if (upw !== upw_confirm) {
		    	alert("[비밀번호 확인]이 [비밀번호]와 불일치 합니다.");
		        return;
		    }
		    
		    // 비밀번호 8자 이상. 영문,숫자,특수문자 포함
		    if ( !( /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/.test(upw) ) ) {
		    	alert("비밀번호는 영문,숫자,특수문자 포함 8자리 이상 입력해주세요.");
		        return;
		    }
		    
		    
		    
	    // get방식 요청임
	    axios.get(MEMBER_PW_MODIFY_URL, {
	        params: { id: uid , pw:upw }
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

<%@ include file="../include/u_footer.jsp" %>
