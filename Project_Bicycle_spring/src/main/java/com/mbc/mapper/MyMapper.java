package com.mbc.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mbc.domain.BicycleBuy;
import com.mbc.domain.BicycleMember;


@Mapper
public interface MyMapper {
	
	// 마이룸 페이지
	List<BicycleMember> getMyProfileInfo();

	// 이용권 구매내역 리스트
	List<BicycleBuy> getBuyList(String id);
}
