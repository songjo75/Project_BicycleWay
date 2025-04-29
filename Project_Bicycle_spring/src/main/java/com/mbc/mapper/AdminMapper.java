package com.mbc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.mbc.domain.BicycleAdmin;
import com.mbc.domain.BicycleCategory;
import com.mbc.domain.BicycleProduct;


@Mapper
public interface AdminMapper {
	
	public BicycleAdmin adminLogin(BicycleAdmin dto);

	public int cateInputOk(BicycleCategory bicycleCategory);

	public List<BicycleCategory> cateList();

	public int cateDelete(int cat_num);

	public int productRegisterOk(BicycleProduct bicycleProduct);

	public List<BicycleProduct> productList();

	public List<BicycleProduct> categoryBicycleList(String code);

	public BicycleProduct getProduct(int pnum);

	public int productUpdateOk(BicycleProduct productUpdate);

    public void productDelete(int pnum);


	
}
