package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class TestController
 */
@WebServlet({"/join","/joinForm", "/loginForm","/mainPage"})
public class TestController extends HttpServlet {
	private static final long serialVersionUID = 1L;
//요청 받아서 아래에서 처리       

	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TestController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
    //요청 처리 doGet 요청에대한 정보 객체가 request, 요청에 대한 답변이 response(응답) 다 get으로 처리 됨
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String url = request.getServletPath();
		// url의 문자형 변수에 클라이언트에서 보내는 요청 request, 어떤 주소로 요청했는지 확인하는 getServlePath 클래스
		// /TestController이 나옴. 주소 test02로 하면 /test02가 출력됨
		System.out.println("url : " + url);
		String path = request.getContextPath(); //JSP_project/resultPage.jsp
		//요청.파일경로 = path객체 저장 
//		response.sendRedirect(path+"/resultPage.jsp");
		//응답.주소다시보내기(path+"/resultPage.jsp"); 
		//주소가 /JSP_Project/resultPage.jsp로 바뀐다.
		//sendRedirect 클라이언트의 주소를 다시 보낸다.
		
		//응답.새로운문서를 작성하는 객체().문서안의 추가한다.request (요청자가보낸.경로가무엇인지 출력하겠다());
//		response5.getWriter().append("Served at: ").append(request.getContextPath());
		//Served at: JSP_Project 출력이 된다.
		
		request.setCharacterEncoding("UTF-8");
		//요구객체의. 문자인코딩을 UTF-8로 해주겠다.
		//한글이 안깨지고 나오게 하게끔.
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out;
		
		switch(url) {
		case "/joinForm":
			//회원가입 페이지 이동 요청
			System.out.println("회원가입 페이지 이동요청");
			response.sendRedirect(path+"/joinForm.jsp");
			break;
			
		case "/loginForm":
			System.out.println("로그인 페이지 이동요청");
			response.sendRedirect(path+"/loginForm.jsp");
			break;
			
		case "/mainPage":
			System.out.println("메인 페이지 이동요청");
			response.sendRedirect(path+"/mainPage.jsp");
			break;
		case "/join":
			System.out.println("회원가입 요청");
//			1.파라메터 확인
			String id = request.getParameter("joinId");
			System.out.println("입력한 아이디: "+  id);
			
			String pw = request.getParameter("joinPw");
			System.out.println("입력한 비번: "+  pw);
			
			String birth = request.getParameter("joinBirth");
			System.out.println("입력한 생일: "+  birth);
			
			int joinResult = 1; //service 회원가입 처리
			if(joinResult > 0) {
				System.out.println("회원가입 성공");
				//메인페이지로 이동
//				response.sendRedirect(path+"/mainPage.jsp?check=y");
//				response.sendRedirect(path+"/joinSuccess.jsp");
				out = response.getWriter();
					//response.getWriter => PrintWriter객체를 의미
				out.println("<script>");
				out.println("alert('회원가입성공');");
				out.println("location.href='"+path+"/mainPage.jsp'");
				out.println("</script>");
				//회원가입페이지로 이동
//				response.sendRedirect(path+"/joinFail.jsp");
				}
				else{
					out = response.getWriter();
					out.println("<script>");
					out.println("alert('fail');");
					out.println("history.back();");
					out.println("</script>");
					System.out.println("회원가입 실패");
				}
			break;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	//요청 처리 doPost
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("doPost() 실행");
		doGet(request, response);
	}

}
