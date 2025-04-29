package com.mbc.Project_Bicycle;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mbc.domain.BicycleProduct;
import com.mbc.service.RentService;

@Controller
@RequestMapping("/rent")
public class RentController {
	
	@Autowired
	private RentService rentService;
	
	@GetMapping("/place")
	public String rentPlaceInfo() {
		return "/rent/place_info";
	}
	
	@GetMapping("/search")
	@ResponseBody
	public List<Map<String,Object>> searchPlace(@RequestParam(value="location", required=true) String location) {
		List<Map<String,Object>> locations =  rentService.searchPlace(location);
		return locations ;
	}
	

}
