package com.movieProject.dao;

import org.apache.ibatis.annotations.Param;

import com.movieProject.dto.Member;

public interface MemberDao {

	Member selectMemberInfo(@Param("id")String id);

	int insertMember_kakao(@Param("member")Member member);

}
