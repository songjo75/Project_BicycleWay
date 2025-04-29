package com.mbc.util;

public enum BookSpec {
	
	COMMON("일반"), HIT("인기"), NEW("신규"), RECOMMEND("추천");
	
	private final String value;

	private BookSpec(String value) {
		this.value = value;
	}

	public String getValue() {
		return value;
	}


}
