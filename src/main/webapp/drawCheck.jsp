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
	
		String mid = request.getParameter("userID");//아이디	
		
		//DATABASE 연동 작업
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jspdb";
		String username = "root";
		String password = "12345";
		
		String sql = "DELETE FROM members WHERE id=?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		//ResultSet rs = null;//select문일때만 필요
		
		int successFlag = 0;//sql 실행 성공 여부를 저장 1이면 성공 0이면 실패
		
		try {
			Class.forName(driverName);//jdbc 드라이버 불러오기
			conn = DriverManager.getConnection(url, username, password);//DB 연동 connection 설정
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);			
			
			successFlag = pstmt.executeUpdate();//성공하면 1이 반환
			
			if(successFlag == 1) {				
				System.out.println("회원 탈퇴 성공!");
				response.sendRedirect("drawSuccess.jsp");
				
			} else {
				System.out.println("회원 탈퇴 실패!");
				response.sendRedirect("drawErr.jsp");
			}
			
		} catch(Exception e) {
			e.printStackTrace();//에러내용을 출력
			out.println("회원 탈퇴 실패 에러 발생!");
		} finally {
			try {
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