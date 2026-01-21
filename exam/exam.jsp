<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    if(session.getAttribute("studentUser") == null) {
        response.sendRedirect("studentLogin.jsp");
        return;
    }
    
    // Get selected subject
    String selectedSubject = request.getParameter("subject");
    if(selectedSubject == null || selectedSubject.trim().isEmpty()) {
        response.sendRedirect("studentDashboard.jsp");
        return;
    }
    
    // Store subject in session for result page
    session.setAttribute("examSubject", selectedSubject);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Online Exam - <%= selectedSubject %></title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif; }
        body { background: #f0f2f5; min-height: 100vh; padding: 20px; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px 30px; border-radius: 10px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; }
        .header-left { display: flex; align-items: center; }
        .subject-badge { background: white; color: #667eea; padding: 8px 20px; border-radius: 20px; font-weight: bold; margin-right: 20px; font-size: 16px; }
        .timer { font-size: 24px; font-weight: bold; background: white; color: #667eea; padding: 10px 20px; border-radius: 5px; }
        .timer.warning { color: #dc3545; animation: pulse 1s infinite; }
        @keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.7; } }
        .question-card { background: white; padding: 25px; border-radius: 10px; margin-bottom: 15px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .question-num { color: #667eea; font-weight: bold; margin-bottom: 10px; font-size: 14px; }
        .question-text { font-size: 18px; color: #333; margin-bottom: 15px; font-weight: 500; }
        .options label { display: block; padding: 12px 15px; margin: 8px 0; background: #f5f5f5; border-radius: 5px; cursor: pointer; transition: all 0.3s; border: 2px solid transparent; }
        .options label:hover { background: #e0e0e0; border-color: #667eea; }
        .options input[type="radio"] { margin-right: 10px; }
        .options input[type="radio"]:checked + span { color: #667eea; font-weight: bold; }
        .options label:has(input:checked) { background: #e8f0fe; border-color: #667eea; }
        .btn-submit { display: block; width: 100%; max-width: 300px; margin: 30px auto; padding: 15px; background: #667eea; color: white; border: none; border-radius: 5px; font-size: 18px; cursor: pointer; font-weight: bold; }
        .btn-submit:hover { background: #5a6fd6; }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-left">
            <div class="subject-badge"><%= selectedSubject %> EXAM</div>
            <h2>Online Examination</h2>
        </div>
        <div class="timer" id="timer">15:00</div>
    </div>
    
    <form action="result.jsp" method="post" id="examForm">
        <input type="hidden" name="subject" value="<%= selectedSubject %>">
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/examdb", "root", "");
            
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM questions WHERE subject = ? LIMIT 10");
            stmt.setString(1, selectedSubject);
            ResultSet rs = stmt.executeQuery();
            
            int qNum = 1;
            while(rs.next()) {
    %>
        <div class="question-card">
            <div class="question-num">Question <%= qNum %> of 10</div>
            <div class="question-text"><%= rs.getString("question") %></div>
            <div class="options">
                <label>
                    <input type="radio" name="q<%= rs.getInt("id") %>" value="<%= rs.getString("option1") %>">
                    <span><%= rs.getString("option1") %></span>
                </label>
                <label>
                    <input type="radio" name="q<%= rs.getInt("id") %>" value="<%= rs.getString("option2") %>">
                    <span><%= rs.getString("option2") %></span>
                </label>
                <label>
                    <input type="radio" name="q<%= rs.getInt("id") %>" value="<%= rs.getString("option3") %>">
                    <span><%= rs.getString("option3") %></span>
                </label>
                <label>
                    <input type="radio" name="q<%= rs.getInt("id") %>" value="<%= rs.getString("option4") %>">
                    <span><%= rs.getString("option4") %></span>
                </label>
            </div>
        </div>
    <%
                qNum++;
            }
            rs.close();
            stmt.close();
            con.close();
        } catch(Exception e) {
            out.println("<p style='color:red; text-align:center;'>Error: " + e.getMessage() + "</p>");
        }
    %>
        <button type="submit" class="btn-submit">✅ Submit Exam</button>
    </form>
    
    <script>
        // 15 minute timer (900 seconds)
        var timeLeft = 15 * 60;
        var timerElement = document.getElementById('timer');
        
        var countdown = setInterval(function() {
            var minutes = Math.floor(timeLeft / 60);
            var seconds = timeLeft % 60;
            
            timerElement.textContent = minutes + ':' + (seconds < 10 ? '0' : '') + seconds;
            
            if(timeLeft <= 60) {
                timerElement.classList.add('warning');
            }
            
            if(timeLeft <= 0) {
                clearInterval(countdown);
                alert('Time is up! Submitting your exam...');
                document.getElementById('examForm').submit();
            }
            
            timeLeft--;
        }, 1000);
    </script>
</body>
</html>