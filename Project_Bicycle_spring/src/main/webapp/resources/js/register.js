
//alert("asdfljkadfj");    // 이 JS 파일을 읽는지 확인용.

let isChecked = false; // 아이디 중복 체크 여부 저장

// 아이디 입력할 때 중복 체크 초기화 (아이디가 변경되면 다시 체크해야 함)
//$("#id").on("input", function() {
//    isChecked = false; // 아이디가 변경될 때 중복 체크 초기화
//});

// 아이디 중복 체크 함수
function idCheck() {
    let uid = $("#id").val().trim(); // 공백 제거
    console.log(uid);
    
    if (!uid) {
        alert("아이디를 입력해주세요.");
        return;
    }
    
    axios.get(MEMBER_ID_CHECK_URL, {
        params: { uid: uid }
    })
    .then(response => {
        const responseData = response.data;
        if (responseData == "yes") {
            $("#chkMsg").text("사용가능한 아이디 입니다.");
            isChecked = true;  // 중복 체크 완료
        } else {
            $("#chkMsg").text("사용중인 아이디 입니다.");
            isChecked = false; // 중복 체크 실패
        }

    })
    .catch(error => {
        alert("서버 에러!!");
    });     
}




// 회원가입 버튼 클릭 시 유효성 검사
// $("#joinForm").submit(function() {

function Validate() {
      //  alert("validate 함수 들어옴");

	    let uid = $.trim($("#id").val());
	    let upw = $.trim($("input[name='pw']").val());
	    let name = $.trim($("input[name='name']").val());
	    let email =$.trim( $("input[name='email']").val());
	    let tel = $.trim($("input[name='tel']").val());   
	    let addr = $.trim($("input[name='addr']").val());            
	
	    // 아이디 검사
	    if (!uid) {
	        alert("아이디를 입력해주세요.");
	       // event.preventDefault(); // 폼이 제출 방지
	        return;
	    }
	    if (!isChecked) {
	        alert("아이디 중복 체크를 해주세요.");
	       // event.preventDefault();
	        return;
	    }
	
	    // 비밀번호 검사 (영문,숫자,특수문자 포함 8자리 이상)
	    if ( !( /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/.test(upw) ) ) {
	        alert("비밀번호는 영문,숫자,특수문자 포함 8자리 이상 입력해주세요.");
	       // event.preventDefault();
	        return;
	    }
	
	    // 이름 검사 (입력 필수)
	    if (!name) {
	        alert("이름을 입력해주세요.");
	      //  event.preventDefault();
	        return;
	    }
	
	
	    // 이메일 검사 (기본 형식 체크)
	    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
	        alert("올바른 이메일을 입력해주세요.");
	      //  event.preventDefault();
	        return;
	    }
	
	    // 전화번호 검사 (숫자와 `-`만 허용)
	    if (!/^\d{2,3}-\d{3,4}-\d{4}$/.test(tel)) {
	        alert("올바른 전화번호를 입력해주세요. (예: 010-1234-5678)");
	      //  event.preventDefault();
	        return;
	    }
	    
	     // 주소 검사 (입력 필수)
	    if (!addr) {
	        alert("주소를 입력해주세요.");
	      //  event.preventDefault();
	        return;
	    }
	    
	    document.getElementById("joinForm").submit();
	    
// });     // end submit()
}    // end Validate()

 
 /* 	function idCheck(){
		let uid = $("#id").val(); // 사용자가 입력한 아이디
		console.log(uid);
		
		$.ajax({
			//옵션:지정값
			url:"<c:url value='memberIdCheck.do'/>",
			type:"get",
			data:{"uid":uid}, // 서버에 전송할 데이터
			success:function(responseData){ // responseData: 서버로부터 전송받은 데이터
				if(responseData == "yes"){
					//alert("사용가능한 아이디 입니다.");
					$("#chkMsg").text("사용가능한 아이디 입니다.");
				}else{
					//alert("사용중인 아이디 입니다.");
					$("#chkMsg").text("사용중인 아이디 입니다.");
				}
				$("#chkModal").modal("show"); // Modal을 보이도록 하는 명령 
			},
			error:function(){alert("서버 에러 입니다!!");}
		});
		
	} */
	

	
	