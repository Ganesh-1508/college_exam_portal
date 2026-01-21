<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    if(session.getAttribute("adminUser") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif; }
        body { background: #f0f2f5; min-height: 100vh; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px 40px; display: flex; justify-content: space-between; align-items: center; }
        .header h2 { font-size: 24px; }
        .btn-logout { padding: 10px 20px; background: white; color: #764ba2; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; font-weight: bold; }
        .container { padding: 30px; }
        .stats { display: flex; gap: 20px; margin-bottom: 30px; }
        .stat-card { flex: 1; background: white; padding: 25px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center; }
        .stat-card h3 { color: #667eea; font-size: 36px; margin-bottom: 5px; }
        .stat-card p { color: #666; margin-top: 5px; }
        .section { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 20px; }
        .section h3 { color: #333; margin-bottom: 15px; border-bottom: 2px solid #667eea; padding-bottom: 10px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #667eea; color: white; font-weight: 600; }
        tr:hover { background: #f5f5f5; }
        .subject-badge { display: inline-block; padding: 4px 12px; border-radius: 15px; font-size: 12px; font-weight: bold; }
        .subject-cpp { background: #ffe5e5; color: #e74c3c; }
        .subject-fods { background: #e5ffe5; color: #27ae60; }
        .subject-dbms { background: #e5f5ff; color: #3498db; }
    </style>
</head>
<body>
    <div class="header">
        <h2>🔧 Admin Dashboard</h2>
        <a href="logout.jsp" class="btn-logout">Logout</a>
    </div>
    
    <div class="container">
        <div class="stats">
            <%
                int totalStudents = 0;
                int totalExams = 0;
                int totalQuestions = 0;
                
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/examdb", "root", "");
                    
                    Statement stmt = con.createStatement();
                    
                    ResultSet rs1 = stmt.executeQuery("SELECT COUNT(*) FROM student");
                    if(rs1.next()) totalStudents = rs1.getInt(1);
                    
                    ResultSet rs2 = stmt.executeQuery("SELECT COUNT(*) FROM results");
                    if(rs2.next()) totalExams = rs2.getInt(1);
                    
                    ResultSet rs3 = stmt.executeQuery("SELECT COUNT(*) FROM questions");
                    if(rs3.next()) totalQuestions = rs3.getInt(1);
                    
                    stmt.close();
                    con.close();
                } catch(Exception e) {
                    out.println("Error: " + e.getMessage());
                }
            %>
            <div class="stat-card">
                <h3><%= totalStudents %></h3>
                <p>Total Students</p>
            </div>
            <div class="stat-card">
                <h3><%= totalExams %></h3>
                <p>Exams Taken</p>
            </div>
            <div class="stat-card">
                <h3><%= totalQuestions %></h3>
                <p>Total Questions</p>
            </div>
        </div>
        
        <div class="section">
            <h3>📋 Recent Results</h3>
            <table>
                <tr>
                    <th>Student Name</th>
                    <th>Subject</th>
                    <th>Score</th>
                    <th>Total</th>
                    <th>Percentage</th>
                    <th>Date</th>
                </tr>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/examdb", "root", "");
                        
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT s.name, r.subject, r.score, r.total, r.exam_date FROM results r JOIN student s ON r.student_id = s.id ORDER BY r.exam_date DESC LIMIT 20");
                        
                        while(rs.next()) {
                            int scr = rs.getInt("score");
                            int tot = rs.getInt("total");
                            int pct = (scr * 100) / tot;
                            String subject = rs.getString("subject");
                            String badgeClass = "";
                            
                            if("CPP".equals(subject)) badgeClass = "subject-cpp";
                            else if("FODS".equals(subject)) badgeClass = "subject-fods";
                            else if("DBMS".equals(subject)) badgeClass = "subject-dbms";
                %>
                <tr>
                    <td><%= rs.getString("name") %></td>
                    <td><span class="subject-badge <%= badgeClass %>"><%= subject %></span></td>
                    <td><%= scr %></td>
                    <td><%= tot %></td>
                    <td><%= pct %>%</td>
                    <td><%= rs.getTimestamp("exam_date") %></td>
                </tr>
                <%
                        }
                        rs.close();
                        stmt.close();
                        con.close();
                    } catch(Exception e) {
                       // out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </table>
        </div>
    </div>
</body>
</html>