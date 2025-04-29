package com.mbc.Project_Bicycle;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

@Controller
@RequestMapping("/flask")
public class FlaskChartController {
	
	// Flask 서버 주소
	private static final String FLASK_SERVER = "http://127.0.0.1:5000" ;
	
	
    ///////////Flask 서버에서 API요청/응답받은 자료를 html rendering. "지도에 마커표시한 위치정보"를  <ifram>태그에 넣어 보여주기.  ////////////////// 
	
	@GetMapping("/accident")
	public String getFormAccident(Model model) {
		
		String url = FLASK_SERVER + "/accident";
		model.addAttribute("url", url);
		return "/chart/accident_zone_form";
	}
	
	@GetMapping("/schoolzone")
	public String getFormSchoolzone(Model model) {
		
		String url = FLASK_SERVER + "/schoolzone";
		model.addAttribute("url", url);
		return "/chart/accident_zone_form";
	}
	
	@GetMapping("/pedestrian")
	public String getFormPedestrian(Model model) {
		
		String url = FLASK_SERVER + "/pedestrian";
		model.addAttribute("url", url);
		return "/chart/accident_zone_form";
	}
	
	////////////    Flask 서버에 저장된 "그래프 chart 그림파일 위치" 가져와서  <img>태그에 넣어 보여주기.  ////////////////// 
	
	@GetMapping("/chart_bicycle_accident")
	public String bicycleAccidentChart(Model model) {
		
		// Http 요청을 보내고 응답을 받는 클래스
		// get, post, delete, put... 요청 가능.     postForObject(url,Map.class) ...
		RestTemplate rt = new RestTemplate();
		String url = FLASK_SERVER + "/api/get_accident_chart";
		
		// 플라스크에서 전송된 json 파일을 Map객체로 변환
		Map<String,String> response = rt.getForObject(url, Map.class);
		model.addAttribute("chartTitle", "서울시 구별 자전거 사고현황");
		model.addAttribute("imgUrl", response.get("image_url"));
		
		return "/chart/accident_chart";
	}
	
	@GetMapping("/chart_schoolzone_accident")
	public String schoolzoneChart(Model model) {
		RestTemplate rt = new RestTemplate();
		String url = FLASK_SERVER + "/api/get_schoolzone_chart";
		
		// json문자열 형태로 받은 url(key:value)를  자바의 Map 객체로 변환
		Map<String,String> response = rt.getForObject(url, Map.class);
		model.addAttribute("chartTitle", "서울시 구별 스쿨존어린이 사고현황");
		model.addAttribute("imgUrl", response.get("image_url"));    // map객체.get(키값) => map객체.value 를 리턴. 즉, 실제 url.
		
		return "/chart/accident_chart";
	}
	
	@GetMapping("/chart_pedestrian_accident")
	   public String pedestrianChart(Model model) {
	      RestTemplate rt = new RestTemplate();
	      String url = FLASK_SERVER + "/api/get_pedestrian_chart";
	      
	      // json문자열 형태로 받은 url(key:value)를  자바의 Map 객체로 변환
	      Map<String,String> response = rt.getForObject(url, Map.class);
	      model.addAttribute("chartTitle", "서울시 구별 보행자무단횡단 사고현황");
	      model.addAttribute("imgUrl", response.get("image_url"));    // map객체.get(키값) => map객체.value 를 리턴. 즉, 실제 url.
	      
	      return "/chart/accident_chart";
	   }

	

}
