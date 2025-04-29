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

<br>
<h4 style="width:100%; color:teal; font-family:sans-serif; margin-top:10px;" align="center" > 자전거 이용권(상품) 구매/결제</h4>
<form action="<c:url value="/buy/buyOk" />" >
<div class="container mt-5 border shadow p-5" style="display:flex;">

	<div style="width:55%; border:1px solid gray; padding:20px; margin:10px;">
	 
	   <ul style="display:block; border:1px solid aqua; padding:3px; border-radius:10px;">
	       <li>1회 1매씩 구매가 가능합니다.</li>
	       <li><span class="buy_info">대여시간은 1시간이며, 정해진 기간동안, 대여 반납이 가능합니다.</span></li>
	       <li>초과시 5분마다 추가요금(200원)과금됩니다.<br>
	         	<span class="buy_info">예시) 기본 초과 1분 ~ 5분 : 200원, 6분 ~ 10분 : 400원</span>
	       </li>
	       <li>추가요금은 이용권 결제수단으로 자동결제됩니다.</li>
	   </ul>
	   
	
	   <table style=" width:100%; border:1px solid aqua; padding:20px; margin-top:10px;">
	         <tr>
	            <td style="color:teal;">이용권명 (선택)</td>
	            <td>
	               <select class="form-select form-select-sm" name="buy_sel"  id="buy_sel" >
	                  <option value="0">이용권 선택</option>
	               	<c:forEach var="dto" items="${requestScope.bicycleProdList}">	
	            <!--  <option value="${dto.pnum}">${dto.pname}[${dto.price}원]</option> -->
	                  <option value="${dto.pname} ${dto.price} ${dto.pnum}">${dto.pname} [${dto.price}원]</option> 
	                 </c:forEach>
	               </select>
	            </td>
	         </tr>
	   </table>   
	   <br>
	
	   <!-- ###########   결제방법  #############-->
	   <p style="font-size:20px;font-weight:bold;">결제방법</p>
	   <div id="payMethod" style="display:flex;">
			<div><input type="radio" id="radio5" class="radioPayClass" name="radioPayMethod" value="BIM_012" onclick="radioChk(5)"><label for="radio5"><span></span><strong style="font-size: 14px;"><font color="red">제로페이</font></strong></label></div>&nbsp;&nbsp;
			<div><input type="radio" id="radio2" class="radioPayClass" name="radioPayMethod" value="SC0010" onclick="radioChk(2)"><label for="radio2"><span></span>신용/체크카드</label></div>&nbsp;&nbsp;
			<div><input type="radio" id="radio3" class="radioPayClass" name="radioPayMethod" onclick='radioChk(3)' value="BIM_007"/><label for="radio3"><span></span><img src="<c:url value='/imgs/payco.png'/>" alt="payco" style="height:13px"></label></div>&nbsp;&nbsp;
			<div ><input type="radio" id="radio4" class="radioPayClass" name="radioPayMethod" onclick='radioChk(4)' value="BIM_010"/><label for="radio4"><span></span><img src="<c:url value='/imgs/ico_kakaopay.gif'/>" alt="kakaopay" style="margin-top:-3px; vertical-aligh:top;"></label></div>&nbsp;&nbsp;
			<div><input type="radio" id="radio1" class="radioPayClass" name="radioPayMethod" value="SC0060" onclick="radioChk(1)"><label for="radio1"><span></span>휴대폰결제</label></div>&nbsp;&nbsp;
			<div id="samsungPayRadio"><input type="radio" id="radio6" class="radioPayClass" name="radioPayMethod" value="BIM_026" onclick="radioChk(6)"><label for="radio6"><span></span>삼성페이</label></div>&nbsp;&nbsp;
	   </div>
		
		<!--payco-->
		<div id="paycoInfo" class="payco_box" style="display: none;">
			<ul>
				<li>PAYCO는 온/오프라인 쇼핑은 물론 송금, 멤버십 적립까지 가능한 통합 서비스입니다.</li>
				<li>휴대폰과 카드 명의자가 동일해야 결제 가능하며, 결제금액 제한은 없습니다.</li>
				<li>지원카드 : 모든 신용/체크카드 결제 가능</li>
			</ul>
		</div>
		<!--payco-->
	
		<!--kakao-->
		<div id="kakaoInfo" class="payco_box" style="display: none;">
			<ul>
			    <li>카카오톡에서 신용/체크카드 연결하고, 결제도 지문으로 쉽고 편리하게 이용하세요!</li>
			    <li>본인명의 스마트폰에서 본인명의 카드 등록 후 사용 가능</li>
			    <li>(카드등록 : 카카오톡 > 더보기 > 카카오페이 > 카드)</li>
			    <li>30만원 이상 결제, ARS 추가 인증 필요</li>
			    <li>이용가능 카드사 : 모든 국내 신용/체크카드</li>
			    <li>카카오페이는 무이자할부 및 제휴카드 혜택 내용과 관계가 없으며, 자세한 사항은 카카오페이 공지사항에서 확인하실 수 있습니다.</li>
			</ul>
		</div>
		<!--kakao-->
	
		<!--zeropay-->
		<div id="zeropayInfo" class="payco_box" style="display: none;">
			<ul>
				<li>제로페이를 이용하시면 우리나라 소상공인에게 힘이 됩니다!!</li>
				<li style="font-weight:bold;">제로페이 결제시 필수 확인사항</li>
				<li><span style="color: red;">① 따릉이 앱 최신버전 다운로드</span></li>
				<li><span style="color: red;">② 참여결제사(은행권, 간편결제사)앱 최신 버전 다운로드</span></li>
				<li>③ 추가요금 결제를 위해 결제수단 등록을 꼭 확인해주세요.<br>(따릉이 앱 나의공간 > 결제관리 > 추가과금 수단변경)</li>
			</ul>
		</div>
		<!--zeropay-->
		
	</div>
	
	<div style="width:45%; border:1px solid gray; padding:20px; margin:10px;">
	
	    <!-- ######### 결제금액 ########### -->
	    <div class="pay_box total" style="margin-top:20px;">
	    	<p style="font-size:20px;font-weight:bold;">결제금액</p>
	    	<input style="margin-top:2px" type="text" class="w80" id="TOT_AMOUNT" name="price"  readonly><span>원</span>
	    </div>
	         
	    <!-- ########### 동의사항 체크 ###########-->
	    <div class="check" style="margin-top:20px; display:flex;">
	        <input type="checkbox" id="agree" name="agree" value="General" >
	    	<label for="agree">&nbsp;추가요금자동결제,환불규정, 이용약관에 동의하며 결제를 진행합니다.</label>
	    </div>    
	    <div class="check" style="letter-spacing:-1px;line-height: normal;text-align: left;margin-top:10px; margin-bottom: 20px; display:flex;">
	    	<input type="checkbox" id="agree2" name="agree2" value="General">
	    	<label for="agree2">&nbsp;만 13세 미만의 미성년자가 서비스를 이용하는 경우, 사고 발생 시 보험 적용을 받을 수 없는 등의 불이익을 받으실 수 있습니다. (만 15세 미만의 경우 상법 제732조에 의거하여 사망 보험 적용 불가)</label>
	    </div>
	              
	    <div class="text-center">
	       <input type="button" onClick="check_BicycleRentBuy()" class="btn btn-sm btn-primary" value="결제하기"/> 
	    </div>
	   
	</div>

</div>
</form>

<script>

	function radioChk(num){
		fn_showHidePaymentClsTypeComments(num); 
	};
	
	function fn_showHidePaymentClsTypeComments(num){
		// TODO naver 추가시 변수 추가 필요
		var id = "radio";
		for(var i=1; i< 7; i++){
			var radioBtn = id+i;
			if(i!=num){
				$("#"+radioBtn).attr("checked", false);
			} 
		}
		
		$("#paycoInfo").css("display","none");
		$("#kakaoInfo").css("display","none");
		$("#zeropayInfo").css("display","none");
		
		switch ( num ){
		case 1 :
			$('[name="paymentMethodCd"]').val("BIM_009");
			break;
		break;	
		case 2 :
			$('[name="paymentMethodCd"]').val("BIM_008");
			break;
		case 3 :
			 $('[name="paymentMethodCd"]').val("BIM_007");
			 $("#paycoInfo").css("display","");
			break;
		case 4 :		
			 $('[name="paymentMethodCd"]').val("BIM_010");
			 $("#kakaoInfo").css("display","");
			 break;
		case 5 	: 
			 $('[name="paymentMethodCd"]').val("BIM_012");
			 $("#zeropayInfo").css("display","");
			 break;
		case 6 :
			 $('[name="paymentMethodCd"]').val("BIM_026");
			 break;
		}
	} 
	

	function check_BicycleRentBuy() {
			
		    let radios = document.querySelectorAll(".radioPayClass");
		    let radio_sel_num = "";
		    
		    for(let i=0; i < radios.length; i++) {
		    	if(radios[i].checked) {
		    		radio_sel_num = i;
		    		console.log(radio_sel_num);
		    	}
		    }
		    
		    if($("#buy_sel option:selected").val() == 0 || $("#buy_sel option:selected").val() == "") {
		    	alert("이용권을 선택해 주세요.");
		    	return;
		    }
		    
		    
		    if(radio_sel_num === ""){
		    	alert("결제방법을 선택해 주세요.");
				return;
		    }
		
		
			if($("#agree").is(":checked") == false) {
				alert("추가요금자동결제,환불규정, 이용약관에 동의해 주세요.");
				return;
			}
			if($("#agree2").is(":checked") == false) {
				alert("동의사항에 동의해 주세요");
				return;
			}
			
			//document.form.submit();
			$("form").submit();
	}
	

      // 선택하는 이용권명에 따라 결제금액에 반영되게 처리.	  
	  $("#buy_sel").change(function() {
		    let value = $("#buy_sel option:selected").val();
		    let val_arr = value.split(" ");
		    let pname = val_arr[0];
		    let price = val_arr[1];
		    let pnum = val_arr[2];
		    $("#TOT_AMOUNT").val(price);
		});
		
	
</script>

<%@ include file="../include/u_footer.jsp" %>
