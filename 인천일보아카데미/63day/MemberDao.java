package com.spring_memberBoard.dao;



import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.spring_memberBoard.dto.Member;

public interface MemberDao {

	@Select("SELECT * FROM MEMBER WHERE MID = #{inputId}")
	Member selectMemberInfo(String inputId);

	@Select ("SELECT * FROM MEMBER WHERE MID = #{mid} AND MPW = #{inputPw}")
	Member selectMemberLoginLogin(@Param("inputId") String inputId, @Param("inputPw") String inputPw);

	

	Member selelctMemberInfo_mapper(@Param("inputId") String inputId);

	int signup(@Param("mem")Member mem);
	
}

