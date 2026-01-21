<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    if(session.getAttribute("studentUser") == null) {
        response.sendRedirect("studentLogin.jsp");
        return;
    }
    
    String examSubject = request.getParameter("subject");
    if(examSubject == null) {
        examSubject = (String) session.getAttribute("examSubject");
    }
    
    int score = 0;
    int total = 0;
    String grade = "";
    String gradeColor = "";
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/examdb", "root", "");
        
        PreparedStatement stmt = con.prepareStatement("SELECT * FROM questions WHERE subject = ? LIMIT 10");
        stmt.setString(1, examSubject);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()) {
            total++;
            String userAnswer = request.getParameter("q" + rs.getInt("id"));
            String correctAnswer = rs.getString("answer");
            
            if(userAnswer != null && userAnswer.equals(correctAnswer)) {
                score++;
            }
        }
        
        // Save result with subject
        Integer studentId = (Integer) session.getAttribute("studentId");
        if(studentId != null) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO results (student_id, score, total, subject) VALUES (?, ?, ?, ?)");
            ps.setInt(1, studentId);
            ps.setInt(2, score);
            ps.setInt(3, total);
            ps.setString(4, examSubject);
            ps.executeUpdate();
            ps.close();
        }
        
        rs.close();
        stmt.close();
        con.close();
        
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    }
    
    int percentage = 0;
    if(total > 0) {
        percentage = (score * 100) / total;
    }
    
    if(percentage >= 80) { 
        grade = "Excellent"; 
        gradeColor = "#28a745"; 
    } else if(percentage >= 60) { 
        grade = "Good"; 
        gradeColor = "#17a2b8"; 
    } else if(percentage >= 40) { 
        grade = "Average"; 
        gradeColor = "#ffc107"; 
    } else { 
        grade = "Need Improvement"; 
        gradeColor = "#dc3545"; 
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Exam Result - <%= examSubject %></title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif; }
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; display: flex; justify-content: center; align-items: center; padding: 20px; }
        .container { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 15px 35px rgba(0,0,0,0.2); width: 450px; text-align: center; }
        .subject-badge { display: inline-block; background: #667eea; color: white; padding: 8px 20px; border-radius: 20px; font-weight: bold; margin-bottom: 20px; font-size: 14px; }
        h2 { color: #333; margin-bottom: 20px; }
        .score-circle { width: 150px; height: 150px; border-radius: 50%; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); margin: 20px auto; display: flex; flex-direction: column; justify-content: center; align-items: center; color: white; }
        .score-num { font-size: 36px; font-weight: bold; }
        .score-text { font-size: 14px; }
        .grade { font-size: 24px; margin: 20px 0; font-weight: bold; }
        .details { background: #f5f5f5; padding: 15px; border-radius: 5px; margin: 20px 0; }
        .details p { margin: 8px 0; color: #555; font-size: 16px; }
        .details p strong { color: #333; }
        .btn { display: inline-block; padding: 12px 25px; background: #667eea; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; text-decoration: none; margin: 5px; }
        .btn:hover { background: #5a6fd6; }
        .btn-logout { background: #dc3545; }
        .btn-logout:hover { background: #c82333; }
    </style>
</head>
<body>
    <div class="container">
        <div class="subject-badge"><%= examSubject %> EXAM</div>
        <h2>📊 Exam Result</h2>
        
        <div class="score-circle">
            <span class="score-num"><%=score%>/<%=total%></span>
            <span class="score-text">Score</span>
        </div>
        
        <div class="grade" style="color: black"><%=grade%></div>
        
        <div class="details">
            <p><strong>Subject:</strong> <%= examSubject %></p>
            <p><strong>Correct Answers:</strong> <%= score %></p>
            <p><strong>Wrong Answers:</strong> <%= total - score %></p>
            <p><strong>Percentage:</strong> <%= percentage %>%</p>
        </div>

        <a href="studentDashboard.jsp" class="btn">📚 Take Another Exam</a>
        <a href="logout.jsp" class="btn btn-logout">Logout</a>
    </div>
</body>
</html>