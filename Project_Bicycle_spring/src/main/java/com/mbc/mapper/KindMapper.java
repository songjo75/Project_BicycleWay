package com.mbc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.mbc.domain.BicycleAdmin;
import com.mbc.domain.BicycleKind;
import com.mbc.domain.BicycleMember;

@Mapper
public interface KindMapper {

	
	// 자전거 종류 등록
	int bicycleKindRegisterOk(BicycleKind bicycleKind);

	// 자전거 종류 리스트 가져오기
	List<BicycleKind> bicycleKindList();

	// 특정 자전거 종류 정보 가져오기
	@Select("select * from tbl_bicycle_kind where kind_code = #{kind_code}")
	BicycleKind getBicycleKind(String kind_code);

	// 자전거 종류 수정 처리
	int bicycleKindUpdateOk(BicycleKind bicycleKind);

	// 자전거 종류 삭제 처리
	@Delete("delete from tbl_bicycle_kind where kind_code= #{kind_code} ")
	int kindDelete(String kind_code);

	

}
