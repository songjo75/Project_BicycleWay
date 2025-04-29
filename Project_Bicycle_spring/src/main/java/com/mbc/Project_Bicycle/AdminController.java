package com.mbc.Project_Bicycle;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.multipart.MultipartFile;

import com.mbc.domain.BicycleCategory;
import com.mbc.domain.BicycleKind;
import com.mbc.domain.BicycleProduct;
import com.mbc.service.AdminService;
import com.mbc.util.BookSpec;



@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	// 파일업로드 경로
	private static final String UPLOAD_DIR = "resources/uploads";
	
	// 관리자 메인 화면 요청
	@GetMapping("/adminMain")
	public String adminMain(HttpSession session) {
		// BicycleAdmin 일수도 있고, BicycleMember 일수도 있으므로, Object 로 받는다.
		// 관리자홈 페이지 요청은 사실... 관리자로 로긴한 경우만 가능하니,  BicycleAdmin 타입일 것이다.
		Object obj = session.getAttribute("loginDTO");
		String mode = (String)session.getAttribute("mode");
		
		// 세션이 관리자이면, 관리자홈 화면으로 보내기.
		if(obj != null && mode.equals("admin") ) {
			return "/admin/ad_main"; 
		}
		
		// 관리자 로긴 화면으로 보내기.
		return "redirect:/login/adminLogin";
	}
	
	// 카테고리 등록 Form 요청
	@GetMapping("/cateInput")
	public String cateInputForm(Model model , HttpSession session) {
		// BicycleAdmin 일수도 있고, BicycleMember 일수도 있으므로, Object 로 받는다.
		Object obj = session.getAttribute("loginDTO");
		String mode = (String)session.getAttribute("mode");
		
		// 세션이 관리자이면, 해당 화면으로 보내기.
		if(obj != null && mode.equals("admin") ) {
			return "/admin/category_input";
		}
		
		// 세션이 관리자가 아니면, 관리자 로긴 화면으로 보내기.
		return "redirect:/login/adminLogin";
	}
	
	// 카테고리 등록 처리 요청
	@PostMapping("/cateInputOk")
	public String cateInputOk(@ModelAttribute BicycleCategory bicycleCategory, Model model) {
		int n = adminService.cateInputOk(bicycleCategory);
		
		if(n>0) {   // 등록 성공
			model.addAttribute("successMsg","카테고리 등록성공");
			// jsp view를 바로 부르면, 리스트를 DB에서 못 가져옴.   redirect: 로 리스트 가져오게 get 요청.
            // return "/admin/category_list";
			return "redirect:/admin/cateList";
		}
		
		// 등록 실패
		model.addAttribute("errorMsg","카테고리 등록에러");
		return "/admin/category_input";
	}
	
	// 카테고리 리스트 요청
	@GetMapping("/cateList")
	public String cateList(@RequestParam(value="successMsg",required=false) String successMsg,
			               @RequestParam(value="errorMsg",required=false) String errorMsg, 
			               Model model,
			               HttpSession session) {
		
		// BicycleAdmin 일수도 있고, BicycleMember 일수도 있으므로, Object 로 받는다.
		Object obj = session.getAttribute("loginDTO");
		String mode = (String)session.getAttribute("mode");
		
		// 세션이 관리자이면, 해당 화면으로 보내기.
		if(obj != null && mode.equals("admin") ) {
		
			List<BicycleCategory> cateList = adminService.cateList();
			model.addAttribute("cateList",cateList);
			
			model.addAttribute("successMsg",successMsg);
			model.addAttribute("errorMsg",errorMsg);
			
			return "/admin/category_list";
		}
		
		// 세션이 관리자가 아니면, 관리자 로긴 화면으로 보내기.
		return "redirect:/login/adminLogin";
		
	}
	
	// 카테고리 삭제 요청
	@GetMapping("/cateDelete")
	public String cateDelete(@RequestParam(value="cat_num") int cat_num, Model model) {
		int n = adminService.cateDelete(cat_num);
		
		if(n>0) {
			// jsp view를 바로 부르면, 리스트를 DB에서 못 가져옴.   
			// redirect: 로 (리스트 가져오게) 컨트롤러에 get 요청.
			return "redirect:/admin/cateList";
		}
		
		model.addAttribute("errorMsg","카테고리 삭제 실패");
		return "redirect:/admin/cateList";
	}
	
	 // 상품 등록 폼 요청
	   @GetMapping("/productInput")
	   public String bicycleInputForm(@RequestParam(value="errorMsg", required=false) String errorMsg,
	                             HttpSession session , Model model) {
	      // BicycleAdmin 일수도 있고, BicycleMember 일수도 있으므로, Object 로 받는다.
	      Object obj = session.getAttribute("loginDTO");
	      String mode = (String)session.getAttribute("mode");
	      
	      
	      // 세션이 관리자이면, 해당 화면으로 보내기.
	      if(obj != null && mode.equals("admin") ) {
	         List<BicycleCategory> cateList = adminService.cateList();
	         model.addAttribute("cateList",cateList); 

	         model.addAttribute("errorMsg",errorMsg);
	         return "/product/product_input";
	      }
	      
	      // 세션이 관리자가 아니면, 관리자 로긴 화면으로 보내기.
	      return "redirect:/login/adminLogin";
	   }
	   
	   // 이용권 상품 등록 처리
	   @PostMapping("/productRegisterOk")
	   public String bicycleRegister(@ModelAttribute BicycleProduct bicycleProduct ,
	                             HttpServletRequest request, Model model) {
	         
	         int n = adminService.productRegisterOk(bicycleProduct);
	          if(n > 0) {
	              model.addAttribute("msg","상품등록 성공");
	             return "redirect:/admin/productList";
	          }

	      model.addAttribute("errorMsg","상품등록 실패");          
	      return "redirect:/admin/productInput";
	   }
	   
	   
	   // 이용권 상품리스트 전체 가져오기
	   @GetMapping("/productList")
	   public String bicycleList(@RequestParam(value="msg",required=false) String msg,   Model model) {
	      
	      List<BicycleCategory> cateList = adminService.cateList();
	      model.addAttribute("cateList",cateList);
	      
	      List<BicycleProduct> bicycleList =  adminService.bicycleList();
	      model.addAttribute("bicycleList",bicycleList);
	      
	      model.addAttribute("msg",msg);
	      return "/product/product_list";
	   }
	   
	   // 상품리스트 (특정 카테고리) 가져오기
	   @GetMapping("/categoryList")
	   public String categoryList(@ModelAttribute BicycleCategory bicycleCategory, Model model) {
	      
	      List<BicycleCategory> cateList = adminService.cateList();
	      model.addAttribute("cateList",cateList);
	      
	      String code = bicycleCategory.getCode();
	      List<BicycleProduct> bicycleList =  adminService.categoryBicycleList(code);
	      model.addAttribute("bicycleList",bicycleList);
	      
	      return "/product/product_list";
	   }
	      
	   
	   // 이용권 상품 수정 Form 요청
	   @GetMapping("/productUpdate")
	   public String bicycleUpdateForm(@RequestParam(value="pnum",required=true) int pnum,  
	                              @RequestParam(value="errorMsg",required=false) String errorMsg,
	                              Model model) 
	   {
	      
	      List<BicycleCategory> cateList = adminService.cateList();
	      model.addAttribute("cateList",cateList);
	      
	      BicycleProduct bicycle = adminService.getProduct(pnum);
	      model.addAttribute("bicycle", bicycle); 
	      
	      model.addAttribute("errorMsg",errorMsg);
	      
	      return "/product/product_update";
	   }
	   
	   
	   // 이용권 상품 수정 처리
	   @PostMapping("/productUpdateOk")
	   public String bicycleUpdate(@ModelAttribute BicycleProduct bicycleProduct, 
	                          Model model,
	                          HttpServletRequest request){
	            int n = adminService.productUpdateOk(bicycleProduct);
	             if(n > 0) {
	                model.addAttribute("msg","상품수정 성공");
	                return "redirect:/admin/productList";
	             } else {
	                model.addAttribute("errorMsg","상품수정 실패");          
	                model.addAttribute("bicycleProduct",bicycleProduct);
	                
	               return "redirect:/admin/productUpdate";
	             }             
	      }

	   
	   
	   // 이용권 삭제 처리.
	   @GetMapping("/productDelete")
	   public String bicycleDelete(@RequestParam(value ="pnum", required=true) int pnum,
	                          Model model )
	   {
	      adminService.productDelete(pnum);
	      return "redirect:/admin/productList";
	   }
	   
	   
	   
	   
//	   // 도서 상세 정보 요청
//	   @GetMapping("/productView")
//	   public String bicycleView(@RequestParam(value="pnum") int pnum , Model model) {
//	      
//	      List<BicycleCategory> cateList = adminService.cateList();
//	      model.addAttribute("cateList",cateList); 
//	      
//	      BicycleProduct bicycle = adminService.getProduct(pnum);
//	      model.addAttribute("bicycle", bicycle); 
//	      
//	      return "/product/product_view";
//	      
//	   }
	   
	   
}

