<%-- 
    Document   : registerStudent
    Created on : Jul 25, 2019, 7:24:48 PM
    Author     : User
--%>

<%@page import="java.util.List"%>
<%@page import="mainController.AdminCon"%>
<%@page import="beans.Student_data"%>
<%@page import="mainController.StudCon"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Student</title>
    </head>
    <body>
      <%
          String roll_no=request.getParameter("rollno");
        List list=AdminCon.studentDetails(roll_no);
        Student_data stud=new Student_data();
        if(list!=null)
        {
            stud=(Student_data)list.get(0);
            int i=StudCon.registerStudent(stud);
            if(i>0)
            {
                response.sendRedirect("../views/Student/registerStudentForm.jsp?result=Student registered sucessfully");
            }
            else
            {
                response.sendRedirect("../views/Student/registerStudentForm.jsp?result=Student registered unsucessfully");
            }
        }
        else
        {
            response.sendRedirect("../views/Student/registerStudentForm.jsp?failResult=Record is not found");
        }
        
        
         
          
      
      %>
      
    </body>
</html>
