package com.movieProject.dao;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import com.movieProject.dto.Member;

public interface MemberDao {

	Member selectMemberInfo(@Param("id")String id);

	int insertMember_kakao(@Param("member")Member member);

	int joinInsertInfo(@Param("mem")Member mem);

	Member selectMemberLogin(@Param("mid")String userId, @Param("mpw")String userPw);

	ArrayList<HashMap<String, String>> selectReserveList(String loginId);

	int cancleReserve(@Param("recode")String recode,@Param("loginId")String loginId);

	String selectReviewCode(String recode);

}
