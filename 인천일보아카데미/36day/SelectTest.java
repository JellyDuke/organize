package p0613;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class SelectTest {

	public static void main(String[] args) {
				//2. DB 접속
				String url ="jdbc:oracle:thin:@//localhost:1521/xe";
				String userid = "PJH_DBA";
				String userpw = "1111";
				Connection con = null;
				try {
					Class.forName("oracle.jdbc.OracleDriver"); //드라이버 설정
					con = DriverManager.getConnection(url,userid,userpw);
				} catch (ClassNotFoundException e) { //드라이버 예외
					e.printStackTrace();
				} catch (SQLException e) { //db예외
					e.printStackTrace();
				}
				if(con == null) {
					System.out.println("db접속 실패");
					return;
				}
				else {
					System.out.println("db접속 성공");
				}
//				2.쿼리문 실행 및 결과 값 반환
				String sql = "Select * FROM CRUDTEST";
				//결과 값을 저장할 변수
				ArrayList<CrudDto> crudList = new ArrayList<CrudDto>();
				
				try {
					//접속된 db에 쿼리문 전송 준비
					PreparedStatement pstmt = con.prepareStatement(sql);
					//쿼리문 실행 및 결과 값 반환
					ResultSet rs = pstmt.executeQuery();
					while(rs.next()) {
						System.out.println("출력");
						CrudDto crud = new CrudDto();
						crud.setNumtest(rs.getInt(1));
						crud.setChartest(rs.getString(2));
						crud.setDatetest(rs.getString(3));
						crudList.add(crud);
					}
				} catch (SQLException e) {
					e.printStackTrace();
			}
				//3. 출력
				for(int i = 0; i < crudList.size(); i ++) {
					System.out.print(crudList.get(i).getNumtest());
					System.out.print(" " +crudList.get(i).getChartest());
					System.out.println(" " + crudList.get(i).getDatetest());
					
				}
	}

}
