package controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Member;
import service.MemberService;

/**
 * Servlet implementation class MemberController
 */
@WebServlet({"/memJoinForm", "/memLoginForm", "/main", "/memJoin", "/memIdCheck", "/Success", "/Fail", "/memLogin", "/memLogout", "/myInfo"})
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String url = request.getServletPath(); // /memJoinForm
		String path = request.getContextPath(); // /JSP_Board
		
		request.setCharacterEncoding("UTF-8");
//		response.setContentType("text/html; charset=UTF-8;");
		
		// 회원 관련 기능 SERVICE
		MemberService msvc = new MemberService();
		
		HttpSession session = request.getSession();
		
		switch(url) {
		
		case "/memJoinForm" :
			System.out.println("회원가입 페이지 이동 요청");
			response.sendRedirect(path + "/JoinForm.jsp");
		break;
			
		case "/memJoin" :
			System.out.println("회원가입 요청");
			
			// 1. 파라메터 확인
			
			String joinId = request.getParameter("joinId");
			System.out.println("입력된 아이디 : " + joinId);
			
			Member joinMember = new Member();
			joinMember.setMid(joinId);
			joinMember.setMpw(request.getParameter("joinPw"));
			joinMember.setMname(request.getParameter("joinName"));
			joinMember.setMbirth(request.getParameter("joinBirth"));
			
			String postcode = request.getParameter("postcode");
			
			String address = request.getParameter("address");
			
			String detailAddress = request.getParameter("detailAddress");
			
			String extraAddress = request.getParameter("extraAddress");
			//             우편번호           주소             상세주소                참고항목
			String maddr = postcode + "_" + address + "_" + detailAddress + "_" + extraAddress;
			
			joinMember.setMaddr(maddr);
			System.out.println(joinMember);
			
			// 2. 회원가입 처리 서비스 호출
			int joinResult = msvc.signupSvc(joinMember);//0
			
			if(joinResult > 0) {
				System.out.println("회원가입 성공");
//				String joinMsg = "회원가입에 성공하였습니다.";
//				String joinUrl = "main";
//				response.sendRedirect(path + "/Success.jsp?변수명=값&변수명=값");
				response.sendRedirect( path + "/Success.jsp"
						+ "?msg=" + URLEncoder.encode("회원가입에 성공하였습니다.", "UTF-8")
						+ "&url=" + URLEncoder.encode(path + "/main", "UTF-8"));
			}
			else {
				System.out.println("회원가입 실패");
				response.sendRedirect(path + "/Fail.jsp"
				+ "?msg=" + URLEncoder.encode("회원가입에 실패했습니다.", "UTF-8") );
			}
			// 3. 회원가입 결과 확인
			// 4. 회원가입 성공 >> "회원가입에 성공하였습니다." >> 메인 페이지로 이동
			//    회원가입 실패 >> "회원가입에 실패하였습니다." >> 회원가입 페이지로 이동
			break;
			
		case "/memLoginForm" :
			System.out.println("로그인 페이지 이동 요청");
			response.sendRedirect(path + "/LoginForm.jsp");
			break;
			
		case "/main" :
			System.out.println("메인 페이지 이동 요청");
			response.sendRedirect(path + "/Main.jsp");
			break;
			
		case "/memIdCheck" :
			System.out.println("아이디 중복 확인 요청");
			String checkId = request.getParameter("inputId");
			System.out.println("확인할 아이디 " + checkId);
			// 2. 아이디 중복확인 기능(SERVICE) 호출
			String result = msvc.memberIdCheck(checkId);
			response.getWriter().print(result);
			break;
			
		case "/memLogin" :
			System.out.println("로그인 요청");
			// 1. 아이디, 비밀번호 파라메터 확인
			String loginId = request.getParameter("loginId");
			String loginPw = request.getParameter("loginPw");
			System.out.println("입력한 아이디 : " + loginId);
			System.out.println("입력한 패스워드 : " + loginPw);
			// 2. SERVICE - 회원정보 조회
			// SELECT * FROM MEMBERS WHERE MID = ? AND MPW = ?
			Member memInfo = msvc.memberLogin(loginId, loginPw);
			
			System.out.println("memInfo : " + memInfo);
			
			if(memInfo == null) {
				System.out.println("로그인 실패");
				response.sendRedirect(path + "/Fail.jsp"
				+ "?msg=" + URLEncoder.encode("아이디 또는 비밀번호가 일치하지 않습니다.", "UTF-8"));
			}
			else {
				System.out.println("로그인 성공");
				// 로그인 처리 - 세션
				session.setAttribute("loginMemberId", memInfo.getMid());
				response.sendRedirect( path + "/Success.jsp"
						+ "?msg=" + URLEncoder.encode("로그인에 성공하였습니다.", "UTF-8")
						+ "&url=" + URLEncoder.encode(path + "/main", "UTF-8"));
			}
			break;
			
		case "/memLogout" :
			System.out.println("로그아웃 요청");
			session.removeAttribute("loginMemberId");
			response.sendRedirect( path + "/Success.jsp"
					+ "?msg=" + URLEncoder.encode("로그아웃 되었습니다.", "UTF-8")
					+ "&url=" + URLEncoder.encode(path + "/main", "UTF-8"));
			break;
			
		case "/myInfo" :
			System.out.println("내 정보 확인 페이지 이동 요청");
			String infoId = (String)session.getAttribute("loginMemberId");
			
			if(infoId == null) {
//				response.sendRedirect(path + "/Fail.jsp"
//						+ "?msg=" + URLEncoder.encode("로그인 후 이용 가능합니다.", "UTF-8"));
				
				response.sendRedirect( path + "/Success.jsp"
						+ "?msg=" + URLEncoder.encode("로그인 후 이용 가능합니다.", "UTF-8")
						+ "&url=" + URLEncoder.encode(path + "/memLoginForm", "UTF-8"));
			}
			else {
				// SERVICE - 회원 정보 조회
				// SELECT * FROM MEMBERS WHERE MID = 로그인된 아이디
				Member memberInfo = msvc.memberInfo(infoId);
				System.out.println(memberInfo);
				request.setAttribute("mInfo", memberInfo);
				request.getRequestDispatcher("myInfo.jsp").forward(request, response);
				
				// myInfo.jsp
				
				
				
//				response.sendRedirect(path + "/myInfo.jsp" + "?"
//						+ "mid=" + URLEncoder.encode(memberInfo.getMid(), "UTF-8") + "&"
//						+ "mpw=" + URLEncoder.encode(memberInfo.getMpw(), "UTF-8") + "&"
//						+ "mname=" + URLEncoder.encode(memberInfo.getMname(), "UTF-8") + "&"
//						+ "mbirth=" + URLEncoder.encode(memberInfo.getMbirth(), "UTF-8") + "&"
//						+ "maddr=" +  URLEncoder.encode(memberInfo.getMaddr(), "UTF-8"));
			}
			
			break;
			
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
