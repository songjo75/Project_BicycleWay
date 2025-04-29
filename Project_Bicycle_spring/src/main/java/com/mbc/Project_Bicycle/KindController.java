package com.mbc.Project_Bicycle;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.mbc.domain.BicycleKind;
import com.mbc.service.AdminService;
import com.mbc.service.KindService;

@Controller
@RequestMapping("/kind")
public class KindController {
	
	@Autowired
	private KindService kindService;
	
	// 파일업로드 경로
	private static final String UPLOAD_DIR = "resources/uploads";
	
	
	   // 자전거 종류 등록 Form 요청
	   @GetMapping("/bicycleKindInput")
	   public String bicycleKindInput(@RequestParam(value="errorMsg",required=false) String errorMsg, Model model) 
	   {
		   model.addAttribute("errorMsg",errorMsg);
		   return "/kind/bicycle_kind_input";
	   }
	   
	   
	   // 자전거 종류 등록 처리
	   @PostMapping("/bicycleKindRegisterOk")
	   public String bicycleKindRegisterOk (@ModelAttribute BicycleKind bicycleKind,
			                                @RequestParam(value="bikefile", required=false) MultipartFile bikefile,
			                                HttpServletRequest request, Model model ) 
	   {
		    
		   if(!bikefile.isEmpty()) {   // MultipartFile 파일이 있으면
			   
	           //  ######### [1] 파일을 실제로 서버에 저장하는 작업  ############################## //
			   
				   /* pom.xml servlet 버전 확인.   request.getServletContext() 를 사용하기 위해,  servlet 버전 3.1.0 필요!!
					<dependency>
						<groupId>javax.servlet</groupId>
						<artifactId>javax.servlet-api</artifactId>
						<version>3.1.0</version>
						<scope>provided</scope>
					</dependency>
				    */
				// [ 1. 파일을 실제로 저장하는 경로] 구하기
				String uploadRealPath = request.getServletContext().getRealPath("")+"/"+UPLOAD_DIR;			
				System.out.println("uploadRealPath =" + uploadRealPath);	
			   					
				// [ 2. 업로드한 파일명 ]
				String originFilename = bikefile.getOriginalFilename();
				System.out.println("파일명 : " + originFilename);
				
				// [ 3.실제 서버에 파일을 저장하기 위한 "파일 객체" 생성. ] (실제 파일 저장할 전체경로, 업로드한 파일명 필요)
				// 만약, uploadPath = "c:/upload" , originFilename = sample.jpg    ==> c:/upload/smaple.jpg 이경로의 File객체 생성
				File destinationFile = new File(uploadRealPath, originFilename);
				
				// [ (3-1.파일명 중복되지 않게 파일명 세팅.) ]
				if(destinationFile.exists()) {
					String newFileName = System.currentTimeMillis() + "_" + originFilename;
					destinationFile = new File(uploadRealPath, newFileName);
					originFilename = newFileName;
				}				
				// [ 4.파일을 실제로 서버에 저장.) ]  이것을 위해 File 객체를 만든 것임.   ( 실제저장경로 + 파일명 )
				try {
					bikefile.transferTo(destinationFile);
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}				

	       //  ######### [2] 첨부한 이미지파일명을 DB Table에 저장하기 위해 bicycleKind dto에 세팅  ############################## //
				
				bicycleKind.setKind_image(originFilename);
				
				System.out.println(originFilename);
				System.out.println(bicycleKind.getKind_image());
				
		   }  //  if (MultipartFile 파일이 있으면  )

		
	   //파일명을 dto에 넣어서,  service에 파라미터로 넘겨 DB 테이블에 등록하는 작업하기 
		
		int n = kindService.bicycleKindRegisterOk(bicycleKind);
	    if(n > 0) {
	    	return "redirect:/kind/bicycleKindList";
	    }

		model.addAttribute("errorMsg","등록 실패"); 			
		return "redirect:/kind/bicycleKindInput";
		   
		
	 }    // 자전거 종류 등록 처리
	   
	  
	 // 자전거 종류 리스트
	 @GetMapping("/bicycleKindList")
	 public String bicycleKindList(@RequestParam(value="msg",required=false) String msg, Model model) {
		 
		 List<BicycleKind> bicycleKindList =  kindService.bicycleKindList();
		 model.addAttribute("bicycleKindList", bicycleKindList);
		 model.addAttribute("msg",msg);
		 
		 return "/kind/bicycle_kind_list";
	 }
	 
	 // 자전거 종류 자료정보 수정 페이지로 이동
	 @GetMapping("/kindUpdate")
	 public String bicycleKindUpdate(@RequestParam(value="kind_code",required=true) String kind_code, Model model) {
		 
		 BicycleKind bicycleKind = kindService.getBicycleKind(kind_code);
		 model.addAttribute("bicycleKind", bicycleKind);
		 
		 return "/kind/bicycle_kind_update"; 
	 }
	 
	 // 자전거 종류 자료정보 수정 처리
	 @PostMapping("/bicycleKindUpdateOk")
	 public String bicycleKindUpdateOk(@ModelAttribute BicycleKind bicycleKind,
			                           @RequestParam(value="bicyclefile",required=false) MultipartFile bicyclefile,
			                           HttpServletRequest request,
			                           Model model)
	 {
			// ######### [첨부 파일을 수정한 경우 (file 존재)]  ############
			if(!bicyclefile.isEmpty()) 
			{   // 파일이 있으면
				// 1. 파일을 실제로 서버에 저장
				
					// 1) [ 파일을 실제로 저장하는 경로] 구하기
					String uploadRealPath = request.getServletContext().getRealPath("")+"/"+UPLOAD_DIR;			
					System.out.println("uploadRealPath =" + uploadRealPath);	
				
				
				    // 2) [실제파일명]도 구해서,  [File 객체] 생성
					String originFilename = bicyclefile.getOriginalFilename();
					File destinationFile = new File(uploadRealPath, originFilename);
					
					// 3) 파일명 중복되지 않게 파일명 세팅.
					if(destinationFile.exists()) {
						String newFileName = System.currentTimeMillis() + "_" + originFilename;
						destinationFile = new File(uploadRealPath, newFileName);
						
						originFilename = newFileName;
					}				
					// 4) 파일을 실제로 서버에 저장.  이것을 위해 File 객체를 만든 것임.   ( 실제저장경로 + 파일명 )
					try {
						bicyclefile.transferTo(destinationFile);
					} catch (IllegalStateException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}		
						
				// 2. 먼저 파일 경로에서 삭제하기.  요즘은 삭제 안하고 보관.
						
				// 3. 수정된 파일명을 DB Table에 저장하기 위해 dto에 세팅.	
					bicycleKind.setKind_image(originFilename);
							
			} // if  
				
			int n = kindService.bicycleKindUpdateOk(bicycleKind);
			
		    if(n > 0) {
		        model.addAttribute("msg","자전거종류 정보 수정 성공했습니다.");
		    	return "redirect:/kind/bicycleKindList";
		    	
		    } 
		    
	    	model.addAttribute("errorMsg","자전거종류 정보 수정 실패. 다시 시도해 주세요."); 			
	    	model.addAttribute("bicycleKind",bicycleKind);
	    	
			return "/kind/bicycle_kind_update";
		    

	 }  // 자전거 종류 자료정보 수정 처리
	 
	 
	 // 자전거 종류 정보 삭제
	 @GetMapping("kindDelete")
	 public String kindDelete(@RequestParam(value="kind_code", required=true) String kind_code, Model model ) {
		 
		 int n = kindService.kindDelete(kind_code);
		 
		 if(n>0) {
			 model.addAttribute("msg","해당 정보가 삭제되었습니다.");
			 return "redirect:/kind/bicycleKindList";
		 }
		 
		 model.addAttribute("msg","해당 정보가 삭제 실패되었습니다.");
		 return "redirect:/kind/bicycleKindList";
	 }
	 
	 // 자전거 이미지 크게 보기
	 @GetMapping("/kindView")
	 public String kindView(@RequestParam(value="kind_code",required=true) String kind_code, Model model) {
		 
		BicycleKind bicycleKind =  kindService.getBicycleKind(kind_code);
		
		model.addAttribute("bicycleKind",bicycleKind);
		
		return "/kind/kind_view";
	 }
	 
	 

}
