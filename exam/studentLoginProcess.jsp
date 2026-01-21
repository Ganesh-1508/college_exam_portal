<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/examdb", "root", "");
        
        PreparedStatement ps = con.prepareStatement("SELECT * FROM student WHERE username=? AND password=?");
        ps.setString(1, username);
        ps.setString(2, password);
        
        ResultSet rs = ps.executeQuery();
        
        if(rs.next()) {
            session.setAttribute("studentId", rs.getInt("id"));
            session.setAttribute("studentName", rs.getString("name"));
            session.setAttribute("studentUser", username);
            response.sendRedirect("studentDashboard.jsp");
        } else {
            request.setAttribute("error", "Invalid username or password!");
            request.getRequestDispatcher("studentLogin.jsp").forward(request, response);
        }
        
        rs.close();
        ps.close();
        con.close();
        
    } catch(Exception e) {
        request.setAttribute("error", "Error: " + e.getMessage());
        request.getRequestDispatcher("studentLogin.jsp").forward(request, response);
    }
%>