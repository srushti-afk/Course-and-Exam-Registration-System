<%-- 
    Document   : registrarLogin
    Created on : 27 Aug, 2018, 11:17:01 PM
    Author     : ADMIN
--%>

<%@page import="mainController.HodCon"%>
<%@page import="beans.Hod_data"%>
<%@page import="java.util.*"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../../assets/css/bootstrap.min.css">
        <title>Registrar Login</title>
    </head>
    
    <body>
      
        <%
         String registrar_uname=request.getParameter("username");
         String pword=request.getParameter("password");       
         int i=HodCon.registrarLogin(registrar_uname, pword);
         if(i==1)
         {
            session.setAttribute("registrar_uname", registrar_uname);
            session.setAttribute("registrar_user", "registrar");
            response.sendRedirect("../views/Registrar/registrarPanel.jsp?result=successfull..");
         }
         else
         {
             response.sendRedirect("../views/Registrar/registrarLoginForm.jsp?failResult=Enter correct credentials"); 
         }
         %>
        
    </body>
</html>
