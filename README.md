# College_Exam_Portal
# 🎯 Online Exam System

## 📌 Project Overview  
The **Online Exam System** is a full-stack web application that enables educational institutions to conduct digital examinations efficiently.  

Students can:  
- Register and log in securely  
- Select from multiple subjects  
- Take timed exams  
- Receive instant results  

Administrators can:  
- Monitor student performance  
- View analytics  
- Manage exam data through a dashboard  

---

## 🌟 Key Features  

### 👨‍🎓 Student Module  
- ✅ User Registration – New students can create accounts with secure credentials  
- ✅ Secure Login – Session-based authentication system  
- ✅ Subject Selection – Choose from C++, FODS (Fundamentals of Data Science), or DBMS  
- ✅ Multi-Subject Exams – 10 questions per subject (30 total questions)  
- ✅ Timer Functionality – 15-minute countdown with visual warnings  
- ✅ Auto-Submit – Automatic submission when time expires  
- ✅ Instant Results – Immediate score, percentage, and grade display  
- ✅ Performance Tracking – View detailed exam statistics  

---

### 🛠️ Admin Module  
- ✅ Admin Dashboard – Comprehensive overview of system statistics  
- ✅ Student Management – View all registered students  
- ✅ Results Monitoring – Track student performance across all subjects  
- ✅ Analytics – Total students, exams taken, and question count  
- ✅ Subject-wise Reports – Color-coded subject badges for easy identification  

---

### ⚙️ Technical Features  
- ✅ Secure Database Connectivity – JDBC with PreparedStatement (SQL injection prevention)  
- ✅ Session Management – Secure user authentication and authorization  
- ✅ Responsive Design – Modern, gradient-based UI  
- ✅ Real-time Timer – JavaScript-based countdown with auto-submit  
- ✅ Automated Grading – Instant score calculation and result generation  

---

## 🛠️ Technologies Used  

| Technology | Purpose |
|------------|--------|
| Java Server Pages (JSP) | Server-side logic and dynamic content |
| MySQL | Database management and data persistence |
| JDBC | Database connectivity |
| Apache Tomcat 10 | Web server and servlet container |
| HTML5 & CSS3 | Frontend structure and styling |
| JavaScript | Client-side interactivity and timer |
| XAMPP | Local development environment |

---

## 🚀 Installation & Setup  

### 🔧 Prerequisites  
- JDK 17 or higher  
- Apache Tomcat 10.1 or higher  
- MySQL 8.0 or higher (via XAMPP or standalone)  
- Web Browser (Chrome, Firefox, Edge)  

---

### ⚙️ Setup Steps  

1. Install **XAMPP** and start **Apache** & **MySQL**  
2. Open **phpMyAdmin** → Create database `examdb`  
3. Import `database/examdb.sql`  
4. Copy the `exam` folder into Tomcat's `webapps` directory  
5. Start **Apache Tomcat 10**  
6. Open browser and go to:

---

## 📂 Project Structure  
```online-exam-system/
│
├── exam/                          # Main application folder
│   ├── index.jsp                  # Landing page
│   ├── register.jsp               # Student registration form
│   ├── registerProcess.jsp        # Registration logic
│   ├── studentLogin.jsp           # Student login page
│   ├── studentLoginProcess.jsp    # Login authentication
│   ├── studentDashboard.jsp       # Subject selection dashboard
│   ├── exam.jsp                   # Examination interface
│   ├── result.jsp                 # Results display
│   ├── adminLogin.jsp             # Admin login page
│   ├── adminLoginProcess.jsp      # Admin authentication
│   ├── adminDashboard.jsp         # Admin control panel
│   ├── logout.jsp                 # Session termination
│   │
│   ├── images/                    # Image assets
│   │   ├── logo.png
│   │   └── background.jpeg
│   │
│   └── WEB-INF/
│       ├── web.xml                # Deployment descriptor
│       └── lib/
│           └── mysql-connector-j-9.5.0.jar
│
├── database/
│   └── examdb.sql                 # Database schema and sample data
│
└── README.md
```

## 🚀 How to Run the Project  

1. Install **XAMPP** and start Apache & MySQL  
2. Import the database into **phpMyAdmin**  
3. Deploy the project in **Apache Tomcat 10**  
4. Open browser → `http://localhost:8080/college_exam_portal`  
5. Register as a student or login as admin  

---

## 📌 Future Enhancements  

- 🔒 Online proctoring  
- 📱 Mobile app version  
- 🧠 AI-based performance analysis  
- 📊 Advanced analytics dashboard  

---

## 🤝 Contributing  
Feel free to fork this repository and submit pull requests.

---

## 📄 License  
This project is for educational purposes.


