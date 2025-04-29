<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${requestScope.msg != null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>

<%@ include file="../include/u_header.jsp" %>	
<%@ include file="../include/u_top.jsp" %>	
             
                                                    
<div class="container w-50 shadow rounded border shadow p-5 mt-5">
			 
	  <!-- Tab List 구성 -->
	  <h3 class="text-center"> [ MyRoom ]</h3>		 
	  <ul class="nav nav-tabs" role="tablist">
	    <li class="nav-item">
	      <a id = "memberinfo" class="nav-link ${find == 'memberinfo' ? 'active':''}" data-bs-toggle="tab" href="#menu1">회원정보 수정</a>
	    </li>
	    <li class="nav-item">
	      <a id="chgPw" class="nav-link ${find == 'chgPw' ? 'active':''}" data-bs-toggle="tab" href="#menu2">비밀번호 변경</a>
	    </li>
	    <li class="nav-item">
	      <a id="buylist" class="nav-link ${find == 'buyList' ? 'active':''}" data-bs-toggle="tab" href="#menu3">구매내역 리스트</a>
	    </li>
	  </ul>
		
	  <!-- 각 Tab 내용들   -->
	  <div class="tab-content">
		  	<!-- 1.회원정보 수정 - TAB -->
		    <div id="menu1" class="container tab-pane fade ${find == 'memberinfo' ? 'show active':''}"><br>  
			      	<form action="<c:url value="/member/memberUpdateOk"/>" method="post">     
						  <h5 class="text-center mb-4"><span class="material-symbols-outlined input-icon-symbol">person</span>&nbsp;${sessionScope.loginDTO.name} 님의 회원정보</h5>
					      <div class="mb-2">
					         <lable for="id">아이디</lable>
					         <input type="text" class="form-control" id="id" name="id" value="${sessionScope.loginDTO.id}" readonly/>
					      </div>
					      <div class="mb-2">
					         <lable for="pw"> ※ 비밀번호는 [비밀번호 Tab]에서 수정하세요 </lable><br>
					   <!--  <input type="password" class="form-control" id="pw" name="pw" value="${dto.pw}" readonly/>  --> 
					      </div>    
					      <div class="mb-2">
					         <lable for="name">이름</lable>
					         <input type="text" class="form-control" id="name" name="name" value="${bicycleMember.name}" readonly/>
					      </div>
					      <div class="mb-2">
					         <lable for="tel">전화번호</lable>
					         <input type="text" class="form-control" id="tel" name="tel" value="${bicycleMember.tel}"/>
					      </div>
					      <div class="mb-2">
					         <lable for="email">E-mail</lable>
					         <input type="text" class="form-control" id="email" name="email" value="${bicycleMember.email}"/>
					      </div>
					      
					      <!----------------------------------- 주소 ----------------------------------->
					      	<div class="mb-2">
					      		<lable for="addr">주소</lable><br>
					    			<input class="form-control" type="text" id="addr" name="addr" value="${bicycleMember.addr}"/>
					    	</div>
					      <!----------------------------------------------------------------------------------------------->
					      
					      <div class="text-center mt-3"><br>
					         <input type="submit" class="btn btn-sm btn-primary" value="회원정보 수정" />
					         <input type="reset" class="btn btn-sm btn-warning" value="취소"/>
					      </div>
			      </form>	
		    </div>
	    
		    <!-- 2. 비밀번호 변경 - TAB -->
			<div id="menu2" class="container tab-pane fade  ${find == 'pw' ? 'show active':''}"><br>
			      <h5 class="text-center mb-4"><span class="material-symbols-outlined input-icon-symbol">key</span>&nbsp;비밀번호 변경</h5>
			      <p style="color:tomato;">비밀번호는 영문,숫자,특수문자 포함 8자리 이상 입력해주세요.</p>
			      <input class="form-control mb-3" type="text" id="id" name="id" value="${bicycleMember.id}" readonly />
			      <input class="form-control mb-3" type="text" id="pw" name="pw" placeholder="수정할 비밀번호"/>
			      <input class="form-control mb-3" type="text" id="pw_confirm" name="pw_confirm" placeholder="수정할 비밀번호 확인"/>
			      
			      <div class="text-center pt-4">
			         <input type="button" class="btn btn-primary w-100" onclick="pwModify()" value="비밀번호 변경"/>
			      </div>
			      
			      <br>
			      <p id="chkMsg" style="color:violet"> </p>
			</div>
			
			<!--  3. 이용권 구매내역 - TAB -->
			<div id="menu3" class="container tab-pane fade  ${find == 'buyList' ? 'show active':''}"><br>
				<h5 class="text-center mb-4"><span class="material-symbols-outlined input-icon-symbol">list</span>&nbsp;이용권구매 내역</h5>
			    <p style="color:tomato;">이용권 구매한 이력입니다.</p>
			    <table class="table">
					<thead>
						<tr>
						    <th>아이디</th>                                                                                                                                                                                               
					        <th>이용권</th>                                                                                     
					        <th>금액</th>    
					        <th>구입날짜</th>                                                                                                                                                                       
					      </tr>                                                                                                 
				    </thead>                                                                                                
				    <tbody> 
						<c:if test="${buyList.size() == 0 }">
							<tr>
								<td colspan="4" style="color:blue;" >구매내역이 존재하지 않습니다!!</td>
							</tr>
						</c:if>
						<c:if test="${buyList.size() != 0 }">
							<c:forEach var="dto" items="${buyList}">
								<tr>
									<td style="width:10%">${dto.id}</td>									
									<td style="width:15%">${dto.pname}</td>
									<td style="width:15%">${dto.price}</td>
									<td style="width:40%">${dto.indate}</td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>  
			</div>
			
	  </div>  <!-- 각 Tab 내용들   -->
	
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
	 console.log("upw : "+upw);
     console.log("upw_confirm : " +upw_confirm);
	    
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