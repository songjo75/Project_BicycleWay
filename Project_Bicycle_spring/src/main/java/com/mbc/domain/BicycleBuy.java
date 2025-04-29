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
public class BicycleBuy {
	private int buy_id;
	private String id;
	private int pnum;
	private String pname;
	private int pqty;
	private int price;
	private Timestamp indate;
	
}
