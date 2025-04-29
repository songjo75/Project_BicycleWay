package com.mbc.domain;

import java.sql.Timestamp;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class BicycleProduct {
	private int pnum;
	private String pname;
	private String pcategory_fk;
	private String pcompany;
	private String pimage;
	
	private int pqty;
	private int price;
	private String pspec;
	private String pcontent;
	private int point;
	private Timestamp pinput_date;
	
}
