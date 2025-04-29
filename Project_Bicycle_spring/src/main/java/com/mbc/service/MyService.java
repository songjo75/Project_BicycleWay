package com.mbc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mbc.domain.BicycleBuy;
import com.mbc.domain.BicycleMember;
import com.mbc.domain.BicycleProduct;
import com.mbc.mapper.MyMapper;

@Service
public class MyService {
	
	@Autowired
	private MyMapper myMapper;

	// 
	public List<BicycleMember> getMyProfileInfo() {
		
		List<BicycleMember> bicycleMemberList = myMapper.getMyProfileInfo();
		return bicycleMemberList;
	}

	// 이용권 구매내역 리스트
	public List<BicycleBuy> getBuyList(String id) {
		List<BicycleBuy> buyList = myMapper.getBuyList(id);
		System.out.println(buyList.size());
		return buyList;
	}

}
