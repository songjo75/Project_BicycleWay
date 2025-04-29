package com.mbc.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class BicycleKind {
	private String kind_code;
	private String kind_name;
	private String kind_image;
	private String content;
	private Date input_date;
	

	
}
