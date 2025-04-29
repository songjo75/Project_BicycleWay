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
import com.mbc.domain.BicycleKind;
import com.mbc.mapper.KindMapper;

@Service
public class KindService {
	
	@Autowired
	private KindMapper kindMapper;

	// 자전거 종류 등록
	public int bicycleKindRegisterOk(BicycleKind bicycleKind) {
		
		int n = kindMapper.bicycleKindRegisterOk(bicycleKind);
		
		return n;
	}

	// 자전거 종류 리스트 가져오기
	public List<BicycleKind> bicycleKindList() {
		
		List<BicycleKind> bicycleKindList = kindMapper.bicycleKindList();
		
		return bicycleKindList;
	}

	// 특정 자전거 종류 정보 가져오기
	public BicycleKind getBicycleKind(String kind_code) {
		
		BicycleKind bicycleKind = kindMapper.getBicycleKind(kind_code);
		
		return bicycleKind;
	}

	// 자전거 종류 정보 수정 처리
	public int bicycleKindUpdateOk(BicycleKind bicycleKind) {
		
		int n = kindMapper.bicycleKindUpdateOk(bicycleKind);
		
		return n;
	}

	// 자전거 종류 정보 삭제 처리
	public int kindDelete(String kind_code) {

        int n = kindMapper.kindDelete(kind_code);
		
		return n;
	}



		
		
}
	
