<%-- 
    Document   : viewStud
    Created on : Aug 26, 2018, 9:00:49 PM
    Author     : sarvadnya
--%>
<%response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");%>
<%@page import="mainController.HodCon"%>
<%@page import="mainController.StudCon"%>
<%@page import="beans.Hod_data"%>
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
         <link rel="stylesheet" type="text/css" href="../assets/css/bootstrap.min.css">
        <title>View Student</title>
    </head>
    <body>
        <%  
            String uname=((String)session.getAttribute("hod_uname"));
            if(uname.equals(null))
            {
               response.sendRedirect("../../index.jsp");
            }
            else
           { 
          %>
         <%@include file="hodHeader.jsp"%>
          <div class="container">
              
        <%
            try
           { 
              Hod_data hod=HodCon.getHODInfo((String)session.getAttribute("hod_uname"));
              Student_data stud=(Student_data)StudCon.getStudentInfo(request.getParameter("stud_rol_no"));
          
        if(hod.getProgramme().equals(stud.getProgramme()) && hod.getShift()==stud.getShift())
              {
                                 
        %>
               <h1>Student Details</h1><hr>
               <h4><label>Rollno : </label> <%= stud.getRollno() %><br><br>
               <label>Name : </label> <%= stud.getS_name() %><br><br>
               <label>Programme : </label> <%= stud.getProgramme() %><br><br>
               <label>Year : </label> <%= stud.getYear()%> <br><br>
               <label>Term : </label> <%=stud.getTerm() %> <br><br>
               <label>Email : </label> <%= stud.getS_email() %><br><br>
               <label>Phone Number : </label> <%= stud.getPhone_no() %><br><br></h4>
                      <%
                       }
                    else
                    {
                       response.sendRedirect("viewStudForm.jsp?failResult=Hod can view only his students of his department and shift.");
                    }
            }catch(Exception e){response.sendRedirect("viewStudForm.jsp?failResult=Roll number is invalid");}    
            } //Session check                
%>   <%@include file="../../footer.jsp" %>
          </div>
    </body>   
</html>
