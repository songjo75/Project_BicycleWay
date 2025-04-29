package com.mbc.Project_Bicycle;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mbc.domain.BicycleAdmin;
import com.mbc.domain.BicycleCategory;
import com.mbc.domain.BicycleMember;
import com.mbc.domain.BicycleProduct;
import com.mbc.service.AdminService;
import com.mbc.service.MemberService;
import com.mbc.util.BookSpec;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private AdminService adminService;
	
	// 회원가입 폼 요청
	@GetMapping("/userJoin")
	public String userJoinForm() {
		return "member/user_join";
	}
	
	// 회원가입 처리 요청
	@PostMapping("/userJoinOk")
	public String userJoinOk(@ModelAttribute BicycleMember bicycleMember , Model model) {
		int n = memberService.userJoinOk(bicycleMember);
		if(n>0) {
			model.addAttribute("msg","회원가입 성공! 로그인 해주세요.");
			return "redirect:/login/userLogin";
		}
		model.addAttribute("errorMsg","회원가입 실패되었습니다.");
		return "member/user_join";
	}
	
	// 아이디 중복 체크
	@GetMapping("/userIdDupCheck")
	@ResponseBody
	public String userIdDupCheck(String uid) {
		BicycleMember member = memberService.userIdDupCheck(uid);
		if(member != null) { 
			 return "no"; 
		} else {
			 return "yes";
		}
	}
	
	// 회원 리스트
	@GetMapping("/memberList")
	public String memberList(@RequestParam(value="msg", required=false) String msg,  Model model) {
		List<BicycleMember> mList = memberService.memberList();
		model.addAttribute("mList",mList);
		model.addAttribute("msg",msg);
		return "/member/member_list";
	}
	
	// 회원정보 수정 폼 요청
	@GetMapping("/memberUpdate")
	public String memberUpdateForm(@RequestParam(value="id", required=true) String id, 
			                       @RequestParam(value="msg", required=false) String msg,
			                       Model model) {
		BicycleMember bicycleMember = memberService.getMemberInfo(id);
		model.addAttribute("bicycleMember",bicycleMember);
		
		model.addAttribute("msg",msg);
		model.addAttribute("find","memberinfo");
		return "/my/my_form";
	}
	
	// 회원정보 수정처리 요청
	@PostMapping("/memberUpdateOk")
	public String memberUpdateOk(@ModelAttribute BicycleMember bicycleMember, Model model) {
		
		int n = memberService.memberUpdate(bicycleMember);
		String id = bicycleMember.getId();
		model.addAttribute("id",id);
		
		if(n > 0) {
			model.addAttribute("msg","회원정보가 수정되었습니다!");
			return "redirect:/member/memberUpdate";
		}
		
		model.addAttribute("msg","회원정보 수정 실패!");
		return "redirect:/member/memberUpdate";
	}
	
	// 회원정보 삭제
	@GetMapping("/memberDelete")
	public String memberDelete(@RequestParam(value="id",required=true) String id, Model model) {
		memberService.memberDelete(id);
		model.addAttribute("msg","회원정보가 성공적으로 삭제되었습니다!");
		return "redirect:/member/memberList";
	}
	
	
	
}
