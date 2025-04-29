package com.mbc.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.mbc.domain.BicycleAdmin;
import com.mbc.domain.BicycleMember;
import com.mbc.mapper.MemberMapper;

@Service
public class MemberService {
	@Autowired
	private MemberMapper memberMapper;

	// 패스워드 암호화를 위한 객체 생성
	@Autowired
	private BCryptPasswordEncoder encoder;

	String rawPassword = "";
	String encodePassword = "";

	public BicycleMember memberLogin(BicycleMember dto) {
		System.out.println("#### 사용자입력 Login정보 Service에서 매개변수로 넘겨받은 것 : " + dto);
		BicycleMember loginDTO = memberMapper.memberLogin(dto);
		System.out.println("#### 입력ID로 DB에서 해당회원자료 가져온 것 : " + loginDTO);
			
		if(loginDTO != null) {
			// user가 입력한 패스워드
			rawPassword = dto.getPw();
			// DB에 저장되어 있는 암호화된 패스워드
			encodePassword = loginDTO.getPw();
		}
		
		if(loginDTO != null && encoder.matches(rawPassword, encodePassword) ) {   // 사용자 로긴 성공
			return loginDTO;
		}
		
		BicycleMember loginFailDTO = new BicycleMember();
		loginFailDTO.setId("loginFail");
		
		return loginFailDTO;	
		}

	// 회원 가입
	public int userJoinOk(BicycleMember bicycleMember) {
		// 패스워드 저장 전에 암호화해서 넘겨주기.
		String rawPassword = bicycleMember.getPw();
		String encodePassword = encoder.encode(rawPassword);
		bicycleMember.setPw(encodePassword);
		
		int n = memberMapper.userJoinOk(bicycleMember);
		return n;
	}

	// 아이디 중복 체크
	public BicycleMember userIdDupCheck(String uid) {
		BicycleMember member = memberMapper.userIdDupCheck(uid);
		return member;
	}
	
	// 회원리스트 가져오기
	public List<BicycleMember> memberList() {
		List<BicycleMember> mList = memberMapper.memberList();
		return mList;
	}

	// 특정 회원정보 가져오기
	public BicycleMember getMemberInfo(String id) {
		BicycleMember bicycleMember = memberMapper.getMemberInfo(id);
		return bicycleMember;
	}

	// 회원정보 수정 처리
	public int memberUpdate(BicycleMember bicycleMember) {
//		// 화면에서 입력한 수정 비밀번호를 암호화 해서 DB에 저장하도록 보내기.
//		// 회원의 비밀번호를 화면에서 수정 받지 않기로 함.   비밀번호 분실 시, 비번 초기화 기능으로 대체! 
//		String rawPw = bicycleMember.getPw();
//		String encodePw = encoder.encode(rawPw);
//		bicycleMember.setPw(encodePw);
		
		int n = memberMapper.memberUpdate(bicycleMember);
		return n ;
	}

	// 회원정보 삭제
	public void memberDelete(String id) {
		memberMapper.memberDelete(id);
	}

	// name과 email 로 ID 찾기
	public BicycleMember idFind(String name, String email) {
		BicycleMember bicycleMember = memberMapper.idFind(name,email);
		return bicycleMember;
	}

	// id로 패스워드 초기화
	public int pwInit(String id) {
		
		String initPw = "121212";
		String encodedPw = encoder.encode(initPw);    // 초기 비밀번호를 암호화
		
		int n = memberMapper.pwInit(id,encodedPw);
		
		return n;
	}

	// 회원 비밀번호 변경처리
	public int pwModifyMember(BicycleMember bicycleMember) {
		
		// 사용자가 입력한 비밀번호를 암호화해서 , DB에 수정 요청. 
		String rawPassword = bicycleMember.getPw();
		String encodedPassword = encoder.encode(rawPassword);
		bicycleMember.setPw(encodedPassword);
		
		int n = memberMapper.pwModifyMember(bicycleMember);
		return n;
	}




	
}
