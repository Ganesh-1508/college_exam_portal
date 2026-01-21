<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("studentUser") == null) {
        response.sendRedirect("studentLogin.jsp");
        return;
    }
    String studentName = (String) session.getAttribute("studentName");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif; }
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; display: flex; justify-content: center; align-items: center; padding: 20px; }
        .container { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 15px 35px rgba(0,0,0,0.2); width: 600px; text-align: center; }
        h2 { color: #333; margin-bottom: 10px; }
        p { color: #666; margin-bottom: 20px; }
        .info-box { background: #f5f5f5; padding: 20px; border-radius: 5px; margin: 20px 0; text-align: left; }
        .info-box h3 { color: #667eea; margin-bottom: 15px; font-size: 18px; }
        .info-box ul { margin-left: 20px; color: #555; }
        .info-box li { margin: 8px 0; }
        .subject-selection { margin: 30px 0; }
        .subject-selection h3 { color: #333; margin-bottom: 15px; }
        .subject-btn { display: block; width: 100%; padding: 15px; margin: 10px 0; background: #667eea; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; text-decoration: none; transition: all 0.3s; }
        .subject-btn:hover { background: #5a6fd6; transform: translateY(-2px); }
        .subject-btn.cpp { background: #e74c3c; }
        .subject-btn.cpp:hover { background: #c0392b; }
        .subject-btn.fods { background: #27ae60; }
        .subject-btn.fods:hover { background: #229954; }
        .subject-btn.dbms { background: #3498db; }
        .subject-btn.dbms:hover { background: #2980b9; }
        .btn-logout { display: inline-block; padding: 12px 25px; background: #dc3545; color: white; border: none; border-radius: 5px; font-size: 14px; cursor: pointer; text-decoration: none; margin-top: 20px; }
        .btn-logout:hover { background: #c82333; }
        .subject-icon { font-size: 24px; margin-right: 10px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>👋 Welcome, <%= studentName %>!</h2>
        <p>Student Dashboard</p>
        
        <div class="info-box">
            <h3>📋 Exam Instructions</h3>
            <ul>
                <li><strong>Choose Your Subject:</strong> Select from C++, FODS, or DBMS</li>
                <li><strong>Total Questions:</strong> 10 per subject</li>
                <li><strong>Time Limit:</strong> 15 Minutes per exam</li>
                <li>Each question has 4 options - select one answer</li>
                <li>Click Submit when done or exam will auto-submit when time expires</li>
                <li>Results will be displayed immediately after submission</li>
            </ul>
        </div>
        
        <div class="subject-selection">
            <h3>Select Subject for Exam:</h3>
            <a href="exam.jsp?subject=CPP" class="subject-btn cpp">
                <span class="subject-icon">💻</span> C++ Exam
            </a>
            <a href="exam.jsp?subject=FODS" class="subject-btn fods">
                <span class="subject-icon">📊</span> FODS Exam
            </a>
            <a href="exam.jsp?subject=DBMS" class="subject-btn dbms">
                <span class="subject-icon">🗄️</span> DBMS Exam
            </a>
        </div>
        
        <a href="logout.jsp" class="btn-logout">Logout</a>
    </div>
</body>
</html>