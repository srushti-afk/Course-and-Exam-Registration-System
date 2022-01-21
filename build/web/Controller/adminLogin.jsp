<%-- 
    Document   : Admin_login
    Created on : Jul 27, 2018, 2:23:47 AM
    Author     : sarvadnya
--%>

<%@page import="mainController.AdminCon"%>
<%@page import="beans.Admin_data"%>
<%@page import="java.util.*"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Login</title>
    </head>
    <body>
        <% 
            String admin_uname=request.getParameter("username");   
            String pword=request.getParameter("password");
            System.out.println("admin login check called"); 
            if(AdminCon.login(admin_uname,pword)) 
            {
                session.setAttribute("admin_uname",admin_uname);
                session.setAttribute("admin_user", "admin");
                System.out.println("admin credentials correct hence moved to admin panel");
                response.sendRedirect("../views/Admin/adminPanel.jsp");
                //login successful hence moved to admin panel
            }
            else
            {
                session.setAttribute("admin_uname", null);
                session.setAttribute("admin_user", null);  
                response.sendRedirect("../views/Admin/adminLoginForm.jsp?failResult=Enter correct credentials");
                //login unsuccessful hence moved to adminLoginForm
            } 
       %>    
    </body>
</html>
