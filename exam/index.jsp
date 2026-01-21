<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Online Exam System</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, sans-serif; }
        body { 

            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
            min-height: 100vh; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
        }
        .container { 
            background: white; 
            padding: 40px; 
            border-radius: 10px; 
            box-shadow: 0 15px 35px rgba(0,0,0,0.2); 
            text-align: center; 
            width: 400px; 
        }
        .logo {
            width: 100px;
            height: 100px;
            margin-bottom: 20px;
            border-radius: 50%;
            object-fit: cover;
        }
        h1 { color: #333; margin-bottom: 30px; }
        .btn { 
            display: block; 
            width: 100%; 
            padding: 15px; 
            margin: 10px 0; 
            border: none; 
            border-radius: 5px; 
            font-size: 16px; 
            cursor: pointer; 
            text-decoration: none; 
        }
        .btn-student { background: #667eea; color: white; }
        .btn-admin { background: #764ba2; color: white; }
        .btn:hover { opacity: 0.9; }
        .register-link { margin-top: 20px; color: #666; }
        .register-link a { color: #667eea; }
    </style>
</head>
<body>
    <div class="container">
        <img src="images/logo.png" alt="Exam System Logo" class="logo">
        
        <h1> Online Exam System</h1>
        <a href="studentLogin.jsp" class="btn btn-student">Student Login</a>
        <a href="adminLogin.jsp" class="btn btn-admin">Admin Login</a>
        <p class="register-link">New Student? <a href="register.jsp">Register Here</a></p>
    </div>
</body>
</html>