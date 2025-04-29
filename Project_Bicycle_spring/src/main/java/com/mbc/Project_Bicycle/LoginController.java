package com.mbc.Project_Bicycle;

import javax.servlet.http.HttpServletRequest;
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
import com.mbc.domain.BicycleMember;
import com.mbc.service.AdminService;
import com.mbc.service.MemberService;




@Controller
@RequestMapping("/login")
public class LoginController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping("/userLogin")
	public String userLogin(@RequestParam(value="loginErr",required=false) String loginErr, 
			                @RequestParam(value="msg",required=false) String msg, 
			                Model model) {
		model.addAttribute("loginErr",loginErr);
		model.addAttribute("msg",msg);
		return "login/memberLoginForm";
	}
	
	@PostMapping("/userLoginOk")
	public String userLoginOk(@ModelAttribute BicycleMember dto, HttpSession session, Model model) {
		   System.out.println("@@@@@@@@ Login Controller (사용자입력 id,pw)" + dto);	
		   BicycleMember loginDTO = memberService.memberLogin(dto);
		   System.out.println("#### 컨트롤러에서 응답받아온 login DB 정보 : " + loginDTO);
		   
		   if(loginDTO.getId().equals("loginFail")) {   // 로그인 실패
			   model.addAttribute("loginErr","아이디가 없거나, 비밀번호가 불일치합니다.");
			   return "redirect:/login/userLogin";
		   } 
		   
		   session.setAttribute("loginDTO", loginDTO);
		   session.setAttribute("mode", "user");
		   return "redirect:/";
	}	
	
	@GetMapping("/userLogout")
	public String memberLogout(HttpSession session) {
		session.invalidate();   // 세션초기화
		return "redirect:/";
	}
	
	@GetMapping("/adminLogin")
	public String adminLogin(@RequestParam(value="loginErr", required=false) String loginErr, Model model) {
		model.addAttribute("loginErr", loginErr);
		return "login/adminLoginForm";
	}

	@PostMapping("/adminLoginOk")
	public String adminLoginOk(@ModelAttribute BicycleAdmin dto, HttpSession session, Model model) {
		BicycleAdmin loginDTO = adminService.adminLogin(dto);
		
		if(loginDTO == null) {   // 로그인 실패
			model.addAttribute("loginErr","idErr");
			return "redirect:/login/adminLogin";
		}
		
		session.setAttribute("loginDTO", loginDTO);
		session.setAttribute("mode", "admin");
		return "redirect:/";
		
	}
	
	@GetMapping("/adminLogout")
	public String adminLogout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@GetMapping("/idPwFind")
	public String idPwFind(@RequestParam("find") String find) {
		
		if(find.equals("id")) {
			return "/login/idFindForm";
		} else if(find.equals("pw")) {
			return "/login/pwInitForm";
		} 
		
		return "/login/idFindForm";
	}
	
	// axios 요청 응답하기.    ( ID 찾기 )
	@GetMapping("/idFindOk")
	@ResponseBody
	public String idFindOk(@ModelAttribute BicycleMember bookMember) {
		
		String name = bookMember.getName();
		String email = bookMember.getEmail();
		BicycleMember findMember = memberService.idFind(name,email);
		
		if(findMember != null) {
			String findId = findMember.getId();
			return "아이디는 "+findId+" 입니다.";
		}
		
		return "해당ID가 없습니다.";
	}
	
	
	// axios 요청 응답하기.    ( 비밀번호 초기화 )
	@GetMapping("/pwInitOk")
	@ResponseBody
	public String pwInitOk(@RequestParam(value="id") String id) {
		int n = memberService.pwInit(id);
		
		if(n > 0) {
			return "패스워드 121212 로 초기화 되었습니다.  ";
		}
		
		return "해당 ID가 없습니다. ";
		
	}
	
	
	// 비밀번호 변경 Form 으로 이동
	@GetMapping("/pwModify")
	public String pwModify(@RequestParam("id") String id , Model model) {
		
		model.addAttribute("id",id);
		return "/login/pwModifyForm";
	}
	
	// 비밀번호 변경 처리 .   axios.get(url) 으로 요청옴.   json문자열 또는 String 으로 응답보내기.
	@GetMapping("/pwModifyOk")
	@ResponseBody
	public String pwModifyOk(@ModelAttribute BicycleMember bicycleMember) {
		
		int n = memberService.pwModifyMember(bicycleMember);
		
		if(n>0) {
			return "비밀번호 변경이 완료되었습니다.";
		}
		
		return "비밀번호 변경 실패되었습니다.";
	}
	
	
	
}
