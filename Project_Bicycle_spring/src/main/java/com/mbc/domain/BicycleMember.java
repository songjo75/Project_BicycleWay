package com.mbc.domain;

import java.security.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class BicycleMember {
	private String id;
	private String pw;
	private String name;
	private String tel;
	private String email;
	private String addr;
	private Timestamp rdate;
}
