<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
			//login.jsp에서 넘어온 파라미터값 불러오기
			request.setCharacterEncoding("utf-8");//한글 깨짐 방지
		
			String mid = request.getParameter("adminID");//관리자 아이디
			String mpw = request.getParameter("adminPW");//관리자 비밀번호	
			
			//DATABASE 연동 작업
			String driverName = "com.mysql.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/jspdb";
			String username = "root";
			String password = "12345";
			
			String sql = "SELECT * FROM members WHERE id=? AND passwd=?";
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;//select문일때만 필요
			
			try {
				Class.forName(driverName);//jdbc 드라이버 불러오기
				conn = DriverManager.getConnection(url, username, password);//DB 연동 connection 설정
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, mid);			
				pstmt.setString(2, mpw);
				
				//successFlag = pstmt.executeUpdate();//성공하면 1이 반환
				rs = pstmt.executeQuery();
				
				if(rs != null) {//참이면 로그인 성공
					session.setAttribute("adminID", mid);
					//session.setAttribute("adminEMAIL", rs.getString("email"));
					
					out.println("관리자 로그인 성공<br><br>");
					out.println("관리자 : " + mid + "님이 로그인하였습니다.");
				} else {//로그인 실패
					response.sendRedirect("loginErr.jsp");
				}				
				
				
			} catch(Exception e) {
				e.printStackTrace();//에러내용을 출력
				out.println("관리자 로그인 에러 발생!");
			} finally {
				try {
					if(rs != null) {
						rs.close();
					}
					if(pstmt != null) {
						pstmt.close();
					}
					if(conn != null) {
						conn.close();	
					}
					
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
	
	%>
	
	<table border="0">
		<tr>
			<td>
				<form action="memberList.jsp">
					<input type="submit" value="◀ 등록 회원 관리하기">
				</form>
			</td>
			<td>
				<form action="logout.jsp">
					<input type="submit" value="관리자 로그 아웃 ▶">
				</form>
			</td>
		</tr>	
	</table>
</body>
</html>