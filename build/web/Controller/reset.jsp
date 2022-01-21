<%-- 
    Document   : reset
    Created on : Nov 30, 2018, 12:15:58 PM
    Author     : User
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.Session"%>
<%@page import="mainController.AdminCon"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset</title>
    </head>
    <body>
        <%
            String user=((String)session.getAttribute("admin_user"));
            if(!user.equals("admin"))
            {
               response.sendRedirect("../index.jsp");
            }
            else
           { 
           String rollno=request.getParameter("roll_no");
          int r=AdminCon.courseRegReset(rollno);
         
          if(r>0)
          {
             response.sendRedirect("../views/Admin/courseRegReset.jsp?result=Record deleted successfully");
              
              
          }
          else
          {
              response.sendRedirect("../views/Admin/courseRegReset.jsp?result=Record deleted unsuccessfully");
          }
           }
            %>
    </body>
</html>
