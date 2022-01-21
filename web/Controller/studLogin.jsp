<%-- 
    Document   : student_login
    Created on : Jul 28, 2018, 9:27:32 PM
    Author     : sarvadnya
--%>

<%@page import="beans.Course_reg"%>
<%@page import="mainController.StudCon"%>
<%@page import="java.sql.SQLException"%>
<%@page import="beans.Student_data"%>
<%@page import="java.util.*"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student login</title>
    </head>
    <body>
        
      <% 
        String stud_uname=request.getParameter("username");
        String pword=request.getParameter("password");
        int isYes=0,isNo=0;//used for checking if registration is confirmed by student or not
        System.out.println("student login check called"); 
            if(StudCon.login(stud_uname,pword)) 
            {
                session.setAttribute("stud_uname",stud_uname);
                session.setAttribute("stud_user", "student"); 
                try{
                        response.sendRedirect("../views/Student/studPanel.jsp");
                   
                }catch(Exception e){out.println(e);} 
            }
            else
            {
                System.out.println("student login check failed"); 
                session.setAttribute("stud_uname", null);
                session.setAttribute("stud_user", null);  
                response.sendRedirect("../views/Student/studLoginForm.jsp?failResult=Enter correct credential");
                //login unsuccessful hence moved to studLoginForm
            }        
      %>
    </body>
</html> 
