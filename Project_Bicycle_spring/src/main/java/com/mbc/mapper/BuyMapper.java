package com.mbc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.mbc.domain.BicycleAdmin;
import com.mbc.domain.BicycleBuy;
import com.mbc.domain.BicycleKind;
import com.mbc.domain.BicycleMember;
import com.mbc.domain.BicycleProduct;

@Mapper
public interface BuyMapper {

	
	// 자전거 이용권 정보 가져오기
	List<BicycleProduct> getRentProductInfo();


	// 이용권 구매사항 DB 저장
	int buyOk(BicycleBuy buy);

	

}
