<%-- 
    Document   : courseRegReset
    Created on : Nov 30, 2018, 11:57:04 AM
    Author     : User
--%>

<%@page import="beans.Student_data"%>
<%@page import="java.util.ListIterator"%>
<%@page import="mainController.AdminCon"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Course Registration Reset</title>
         <link rel="stylesheet" type="text/css" href="../assets/css/bootstrap.min.css">
         
    </head>
    
    <body>
        <% String uname=((String)session.getAttribute("admin_uname"));
            if(uname.equals(null))
            {
               response.sendRedirect("../index.jsp");
            }
            else
           { 
          %>
           <%@include file="commonHeader.jsp"%>
        <%
        
          String roll_no=request.getParameter("rollno");
          List list=AdminCon.studentDetails(roll_no);
          
           if(list!=null) 
           {
                ListIterator lit=list.listIterator();
               Student_data c;
                while(lit.hasNext()) {
                c=(Student_data)lit.next();
          %>
          <div class="container">
              <h1>Student Information</h1><br>
              
              <h4><label>Roll number:</label><%= c.getRollno()%><br><br>
        
                  <label>Name:</label><%= c.getS_name()%><br><br>
                  <label>Branch:</label><%= c.getProgramme()%><br><br>
                  <label>Phone number:</label><%= c.getPhone_no()%><br><br></h4>
    
          

             <% }
             String path="./reset.jsp?roll_no="+request.getParameter("rollno");%>
            
             
          
          <form action="./reset.jsp" method="POST">
               <button type="submit" class="btn btn-danger" formaction="<%=path%>">Reset</button>
           </form>
          </div>
           <%}
            else
                {
                     response.sendRedirect("../views/Admin/courseRegReset.jsp?failResult=Record is not present");
                }
        }
           %>
  
    </body>
</html>
