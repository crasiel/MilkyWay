package com.itbank.member;

import java.util.HashMap;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface MemberDAO {

	@Insert("insert into member (member_email,member_pw,member_name,member_nick,member_birth,member_gender)"
			+ " values(#{member_email},#{member_pw},#{member_name},#{member_nick},#{member_birth},#{member_gender})")
	int insert(MemberDTO dto);

	@Select("select * from member where member_email=#{member_email} and member_pw=#{member_pw}")
	MemberDTO selectOne(HashMap<String, String> param);
	
	@Select("select member_email from member where member_email=#{email}")
	MemberDTO check_email(String email);

	@Select("select member_nick from member where member_nick=#{nick}")
	MemberDTO check_nick(String nick);
	
	int updateEmail(HashMap<String, String>param);

	@Update("update member set member_pw=#{password} where member_email=#{email}")
	int updatePw(HashMap<String, String>param);

	
}
