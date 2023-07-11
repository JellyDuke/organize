package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Member;
import service.MemberService;

/**
 * Servlet implementation class MemberController
 */
@WebServlet({"/memJoinForm", "/memLoginForm", "/main","/memJoin","/memIdCheck","/success","/fail" })
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
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out;
		//회원 관련 기능 서비스 객체
		MemberService msvc = new MemberService();
		
		switch(url) {
		
		case "/memJoinForm" :
			System.out.println("회원가입 페이지 이동 요청");
			response.sendRedirect(path + "/JoinForm.jsp");
		break;
			
		case "/memLoginForm" :
			System.out.println("로그인 페이지 이동 요청");
			response.sendRedirect(path + "/LoginForm.jsp");
			break;
			
		case "/memJoin" :
			System.out.println("회원가입 요청");
			//1. 파라메터 확인
			String joinId = request.getParameter("joinId");
			System.out.println("입력한 아이디 :" + joinId);
			Member joinMember = new Member();
			joinMember.setMid(joinId);
			joinMember.setMpw(request.getParameter("joinPw"));
			joinMember.setMname(request.getParameter("joinName"));
			joinMember.setMbirth(request.getParameter("joinBirth"));

			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address");
			String detailAddress = request.getParameter("detailAddress");
			String extraAddress = request.getParameter("extraAddress");
			
			String maddr = postcode+"_"+address+"_"+detailAddress+"_"+extraAddress;
			joinMember.setMaddr(maddr); //joinMember에 maddr을 넣음.
			System.out.println(joinMember);
			//2. 회원가입 처리 서비스 호출
			int joinForm = msvc.JoinForm(joinMember);
			//3. 회원가입결과 확인
			if(joinForm > 0) {
				//4. 회원가입 성공 >> "회원가입에 성공!"
				//				   메인페이지로 
				System.out.println("회원가입 성공");
				String joinMsg = "회원가입에 성공하였습니다.";
				String joinUrl = "main";
				//Success.jsp?변수명=값&변수명=값
				response.sendRedirect(path + "/Success.jsp"
						+"?"+URLEncoder.encode("msg","UTF-8")+"="+URLEncoder.encode(joinMsg,"UTF-8") 
						+"&"+URLEncoder.encode("url","UTF-8")+"="+URLEncoder.encode(joinUrl,"UTF-8"));
				
			}else {
				//   회원가입 실패 >> "회원가입 실패!"
				//				   회원가입 페이지로.
				System.out.println("회원가입 페이지 이동 요청");
				response.sendRedirect(path + "/Fail.jsp" + "?"+"msg"+"="+URLEncoder.encode("회원가입에 실패하였습니다.","UTF-8"));
			}
			
			break;
			
		case "/main" :
			System.out.println("메인 페이지 이동 요청");
			
			response.sendRedirect(path + "/Main.jsp");
			break;
		case "/memIdCheck" :
			System.out.println("아이디 중복 확인 요청");
			String checkId = request.getParameter("inputId");
			//getParameter data : ("inputId" : ...value) 의 아이디를 가져오겠다.
			System.out.println("확인할 아이디 : " + checkId);
			//2.아이디 중복확인 기능 호출
			String result = msvc.memberIdCheck(checkId);
			response.getWriter().print(result);
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
