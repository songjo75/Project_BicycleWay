package com.mbc.Project_Bicycle;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mbc.domain.BicycleBuy;
import com.mbc.domain.BicycleMember;
import com.mbc.domain.BicycleProduct;
import com.mbc.service.MemberService;
import com.mbc.service.MyService;


@Controller
@RequestMapping("/my")
public class MyController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MyService myService;
	

	// 마이폼페이지 이동
	@GetMapping("/myForm")
	public String myForm(HttpSession session, Model model) {

		// 로긴자 정보 찾아 바인딩
		BicycleMember loginDTO = (BicycleMember)session.getAttribute("loginDTO");
		String id = loginDTO.getId();
		model.addAttribute("loginDTO",loginDTO);
		model.addAttribute("id",id);
		
		BicycleMember bicycleMember = memberService.getMemberInfo(id);
		System.out.println(bicycleMember);
		
		model.addAttribute("bicycleMember",bicycleMember);
		
		// 마이페이지 3개 tab들 중에,  처음에 회원정보수정  페이지로 세팅.
		model.addAttribute("find","memberinfo");
		
		// 이용권 구매 내역 정보 가져와 바인딩
		List<BicycleBuy> buyList =  myService.getBuyList(id);
//		System.out.println(buyList.size());
		model.addAttribute("buyList",buyList);
		
		return "/my/my_form";
	}
	
}
