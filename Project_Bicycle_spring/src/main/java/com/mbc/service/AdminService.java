package com.mbc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.mbc.domain.BicycleAdmin;
import com.mbc.domain.BicycleCategory;
import com.mbc.domain.BicycleProduct;
import com.mbc.mapper.AdminMapper;

@Service
public class AdminService {
	@Autowired
	private AdminMapper adminMapper;
	
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	
	// 관리자 로긴
	public BicycleAdmin adminLogin(BicycleAdmin dto) {
	  BicycleAdmin loginDTO = adminMapper.adminLogin(dto);
	  
	  String rawPassword = dto.getPassword();
	  String encodePassword = loginDTO.getPassword();
	  
	  // if(loginDTO != null && encoder.matches(rawPassword, encodePassword) ) {   // 관리자 로긴 성공
	  // 관리자 패스워드 1212 는 암호화하지 않고 , DB에 저장해 두었으므로 아래와 같이 문자열 바로 비교.
	  if(loginDTO != null && rawPassword.equals(encodePassword) ) {   // 관리자 로긴 성공
			return loginDTO;
		}
		
	  return null;
		
	}
	
	// 카테고리 등록
	public int cateInputOk(BicycleCategory bicycleCategory) {
		int n = adminMapper.cateInputOk(bicycleCategory);
		return n;
	}

	// 카테고리 리스트 조회
	public List<BicycleCategory> cateList() {
		List<BicycleCategory> cateList = adminMapper.cateList();
		return cateList;
	}

	// 카테고리 삭제
	public int cateDelete(int cat_num) {
		int n = adminMapper.cateDelete(cat_num);
		return n;
	}

	// 이용권 등록 처리
	   public int productRegisterOk(BicycleProduct bicycleProduct) {
	      int n = adminMapper.productRegisterOk(bicycleProduct);
	      return n;
	      
	   }

	   // 이용권 리스트 조회
	   public List<BicycleProduct> bicycleList() {
	      List<BicycleProduct> bicycleList = adminMapper.productList();
	      return bicycleList;
	   }

	   // (특정 카테고리 ) 상품리스트 조회
	   public List<BicycleProduct> categoryBicycleList(String code) {
	      List<BicycleProduct> bicycleList = adminMapper.categoryBicycleList(code);
	      return bicycleList;
	   }


	   // pnum 으로 특정 상품 가져오기
	   public BicycleProduct getProduct(int pnum) {
	      BicycleProduct bicycle = adminMapper.getProduct(pnum);
	      return bicycle;
	   }

	   // 이용권 수정
	   public int productUpdateOk(BicycleProduct bicycleProduct) {
	      int n = adminMapper.productUpdateOk(bicycleProduct);
	      return n;
	   }

	   // 이용권 삭제
	   public void productDelete(int pnum) {
	      adminMapper.productDelete(pnum);
	   }


	
}
