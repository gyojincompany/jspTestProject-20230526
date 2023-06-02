<%@page import="java.sql.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//signup.jsp에서 넘어온 파라미터값 불러오기
		request.setCharacterEncoding("utf-8");//한글 깨짐 방지	
		
		//DATABASE 연동 작업
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jspdb";
		String username = "root";
		String password = "12345";
		
		String sql = "SELECT * FROM members";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;//select문일때만 필요
		
		try {
			Class.forName(driverName);//jdbc 드라이버 불러오기
			conn = DriverManager.getConnection(url, username, password);//DB 연동 connection 설정
			
			pstmt = conn.prepareStatement(sql);					
			
			rs = pstmt.executeQuery();//모든 회원 리스트 반환
			
			while(rs.next()) {
				
				String id = rs.getString("id");
				String pw = rs.getString("passwd");
				String email = rs.getString("email");
				String signtime = rs.getString("signuptime");
				
				out.println(id + " / " + pw + " / " + email + " / " + signtime + "<br>");
			}
			
			
			
		} catch(Exception e) {
			e.printStackTrace();//에러내용을 출력
			out.println("회원 리스트 출력 실패 에러 발생!");
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
</body>
</html>