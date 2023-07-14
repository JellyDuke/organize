package controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Board;
import service.BoardService;

/**
 * Servlet implementation class Board
 */
@WebServlet({"/boardList", "/boardWriteForm", "/boardWrite", "/boardView"})
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardController() {
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
		
		HttpSession session = request.getSession();
		
		// 회원 관련 기능 SERVICE
		BoardService bsvc = new BoardService();
		
		switch(url) {
		case "/boardList" :

			System.out.println("게시판 이동 요청");
			// 1. Board 게시글 목록 조회
//			SELECT * FROM BOARDS WHERE BSTATE = '1';
			ArrayList<Board> bList = bsvc.getBoardList();
			request.setAttribute("bList", bList);
			
			// 2. 게시판 페이지로 응답
			request.getRequestDispatcher("BoardList.jsp").forward(request, response);
			break;
			
		case "/boardWriteForm" :
			System.out.println("글작성 페이지 이동요청");
			response.sendRedirect("BoardWriteForm.jsp");
			break;
			
		case "/boardWrite" :
			System.out.println("게시글 등록 요청");
			String bwiter = (String)request.getSession().getAttribute("loginMemberId");
			
			if(bwiter == null) {
				response.sendRedirect( path + "/Success.jsp"
						+ "?msg=" + URLEncoder.encode("로그인 후 이용 가능합니다.", "UTF-8")
						+ "&url=" + URLEncoder.encode(path + "/boardList", "UTF-8"));
			}
			else {
				
				String title = request.getParameter("title");
				String content = request.getParameter("content");
				
				int result = bsvc.getBoard(bwiter, title, content);
				
				if(result < 0) {
					response.sendRedirect(path + "/Fail.jsp"
							+ "?msg=" + URLEncoder.encode("게시글 등록에 실패했습니다.", "UTF-8"));
				}
				else {
					response.sendRedirect( path + "/Success.jsp"
							+ "?msg=" + URLEncoder.encode("게시글을 등록했습니다.", "UTF-8")
							+ "&url=" + URLEncoder.encode(path + "/boardList", "UTF-8"));
				}
				
			}
			
			break;
			
		case "/boardView" :
			System.out.println("글 상세보기 페이지 이동 요청");
			
			// 글번호 파라메터 조회
			int viewBno = Integer.parseInt(request.getParameter("viewBno"));
			System.out.println("상세보기 글번호 : " + viewBno);
			
			// 1. 상세보기 페이지에 출력할 글 조회
			// SELETE * FROM BOARD WHERE BNO = ?
			Board board = bsvc.getBoardView(viewBno);
			
			request.setAttribute("board", board);
			request.getRequestDispatcher("BoardView.jsp").forward(request, response);
			
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
