package com.movieProject.dao;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import com.movieProject.dto.Member;

public interface MemberDao {

	Member selectMemberInfo(@Param("id")String id);

	int insertMember_kakao(@Param("member")Member member);

	int joinInsertInfo(@Param("mem")Member mem);


}
