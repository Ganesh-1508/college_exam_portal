<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/examdb", "root", "");
        
        PreparedStatement ps = con.prepareStatement("INSERT INTO student (name, email, username, password) VALUES (?, ?, ?, ?)");
        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, username);
        ps.setString(4, password);
        
        int result = ps.executeUpdate();
        
        ps.close();
        con.close();
        
        if(result > 0) {
            request.setAttribute("success", "Registration successful! Please login.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    } catch(Exception e) {
        request.setAttribute("error", "Registration failed: " + e.getMessage());
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
%>