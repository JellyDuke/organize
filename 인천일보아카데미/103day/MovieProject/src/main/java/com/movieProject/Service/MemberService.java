package com.movieProject.Service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.movieProject.dao.MemberDao;
import com.movieProject.dto.Member;

import lombok.val;

@Service
public class MemberService {

	@Autowired
	private MemberDao memdao;

	public Member getLoginMemberInfo_kakao(String id) {

		System.out.println("SERVICE - getLoginMemberInfo_kakao(String id)");

		return memdao.selectMemberInfo(id);
	}

	public int registMember_kakao(Member member) {
		System.out.println("SERVICE - registMember_kakao(Member member)");

		return memdao.insertMember_kakao(member);
	}

	public String midCheck(String inputId) {
		System.out.println("SERVICE - midCheck() 호출");
		System.out.println("아이디 : " + inputId);

		// SELECT * FROM MEMBERS WHERE MID = #{아이디}

		Member member = memdao.selectMemberInfo(inputId);

		System.out.println(member);

		String result = "N";

		if (member == null) {
			result = "Y";
		}

		return result;
	}

	public int memJoin(Member mem, HttpSession session) throws IllegalStateException, IOException {

		System.out.println("MemberService - memJoin() 호출");

		// 이메일
		// 업로드 된 파일 저장 - 저장경로 설정, 파일명 처리
		MultipartFile bfile = mem.getBfile(); // 첨부파일
		String mprofile = "";// 파일명 저장할 변수0
		String savePath = session.getServletContext().getRealPath("/resources/memberprofile"); // 파일일을 저장할 변수
		if (!bfile.isEmpty()) { // 첨부파일 확인
			// 첨부파일이 없는 경우
			// !bfile.isEmpty() 파일이 있는 경우 true
			System.out.println("첨부파일 있음");

			// 임의의 코드 + img3.jpg
			UUID uuid = UUID.randomUUID();
			String code = uuid.toString();
			System.out.println("code : " + code);
			mprofile = code + "_" + bfile.getOriginalFilename();

			// 저장할 경로 resources/boardUpload 폴더에 파일저장
			System.out.println("savePath: " + savePath);
			File newFile = new File(savePath, mprofile);
			bfile.transferTo(newFile);
		}
		System.out.println("파일이름: " + mprofile);
		mem.setMprofile(mprofile);
		System.out.println(mem);

		int result = 0;

		try {
			result = memdao.joinInsertInfo(mem);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(mem);
		return result;
	}

	public Member getLoginMemberInfo(String userId, String userPw) {
		System.out.println("SERVICE - getLoginMemberInfo() 호출");
		Member memInfo = memdao.selectMemberLogin(userId, userPw);
		return memInfo;
	}

	public ArrayList<HashMap<String, String>> getReserveList(String loginId) {
		System.out.println("SERVICE - getReserveList() 호출");
		ArrayList<HashMap<String, String>> reserveInfo = memdao.selectReserveList(loginId);
		return reserveInfo;
	}

	public int getCancleReserve(String recode, String loginId) {
		System.out.println("SERVICE - getCancleReserve() 호출");
		int cancleReserve = memdao.cancleReserve(recode, loginId);
		return cancleReserve;
	}

}
