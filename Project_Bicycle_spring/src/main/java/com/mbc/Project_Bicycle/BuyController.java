package com.mbc.Project_Bicycle;

import java.sql.Array;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mbc.domain.BicycleBuy;
import com.mbc.domain.BicycleMember;
import com.mbc.domain.BicycleProduct;
import com.mbc.service.BuyService;
import com.mbc.service.RentService;

@Controller
@RequestMapping("/buy")
public class BuyController {
	
	@Autowired
	private BuyService buyService;
	
	@GetMapping("/buy_form")
	public String rentBuy(@RequestParam(value="msg",required=false) String msg, Model model) {
		
		List<BicycleProduct> bicycleProdList = buyService.getRentProductInfo();
		model.addAttribute("bicycleProdList",bicycleProdList);
		
		model.addAttribute("msg",msg);
		return "/buy/buy_form";
	}
	
	@GetMapping("/buyOk")
	public String buyOk(@RequestParam(value="buy_sel",required=true) String buy_sel , 
			                       HttpSession session,
			                       Model model) {
		
		// System.out.println("buyOk 들어왔다.");
		BicycleMember loginDTO = (BicycleMember)session.getAttribute("loginDTO");
		String id = loginDTO.getId();
		
		String[] arr_buy_sel = buy_sel.split(" ");
		String pname = arr_buy_sel[0];
		int price = Integer.parseInt(arr_buy_sel[1]);
		int pnum = Integer.parseInt(arr_buy_sel[2]);
		
		BicycleBuy buy = new BicycleBuy();
		buy.setId(id);
		buy.setPnum(pnum);
		buy.setPname(pname);
		buy.setPrice(price);
		
		int n = buyService.buyOk(buy);
		
		if(n > 0) {
			model.addAttribute("msg","결제완료 되었습니다.");
			return "redirect:/buy/buy_form";
		}
		
		model.addAttribute("msg","결제실패 되었습니다.");
		return "redirect:/buy/buy_form";
		
	}
	

}
