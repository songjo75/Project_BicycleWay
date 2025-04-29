package com.mbc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.mbc.domain.BicycleAdmin;
import com.mbc.domain.BicycleMember;

@Mapper
public interface MemberMapper {

	public BicycleMember memberLogin(BicycleMember dto);

	public int userJoinOk(BicycleMember bicycleMember);
	
	public BicycleMember userIdDupCheck(String uid);
	
	public List<BicycleMember> memberList();

	public BicycleMember getMemberInfo(String id);

	public int memberUpdate(BicycleMember bicycleMember);

	public void memberDelete(String id);

	// Mapper Interface 의 추상메소드에 매개변수 2개 이상일때는 @Param 어노테이션으로 표시해야 한다.
	public BicycleMember idFind(@Param("name") String name, @Param("email") String email);

	@Select("select * from tbl_bicycle_member where id = #{id}")
	public BicycleMember pwFind(String id);

	// Mapper Interface 의 추상메소드에 매개변수 2개 이상일때는 @Param 어노테이션으로 표시해야 한다.
	@Update("update tbl_bicycle_member set pw = #{encodedPw} where id = #{id}")
	public int pwInit(@Param("id") String id, @Param("encodedPw") String encodedPw);

	@Update("update tbl_bicycle_member set pw = #{pw} where id = #{id}")
	public int pwModifyMember(BicycleMember bicycleMember);

}
