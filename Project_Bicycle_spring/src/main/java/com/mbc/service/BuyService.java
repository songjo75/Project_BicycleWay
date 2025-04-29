package com.mbc.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mbc.domain.BicycleBuy;
import com.mbc.domain.BicycleProduct;
import com.mbc.mapper.BuyMapper;

@Service
public class BuyService {

	    @Autowired
	    private BuyMapper buyMapper;
	    
	    // 이용권 구매 시, 이용권 종류 가져오기 
		public List<BicycleProduct> getRentProductInfo() {
			
			List<BicycleProduct> bicycleProdList = buyMapper.getRentProductInfo();
			return bicycleProdList;
		}

		// 결제하기
		public int buyOk(BicycleBuy buy) {
			
			int n = buyMapper.buyOk(buy);
			return n;
		}
	}
	
