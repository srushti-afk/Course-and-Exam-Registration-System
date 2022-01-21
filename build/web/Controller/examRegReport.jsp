<%-- 
    Document   : examRegReport
    Created on : Mar 2, 2019, 7:56:03 PM
    Author     : User
--%>

<%@page import="mainController.AdminCon"%>
<%@page import="beans.Admin_data"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Exam Registration Report</title>
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
            Session s;
            Query qr;
            SessionFactory sf;
            List list1=new ArrayList();
            Admin_data ad=AdminCon.getAdminInfo();
            sf=SessionFact.SessionFact.getSessionFact();
            s=sf.openSession();
            String programme=request.getParameter("branch");
            int year=Integer.parseInt(request.getParameter("year"));
            int shift=Integer.parseInt(request.getParameter("shift"));
            
            List list=AdminCon.examRegReport(programme, shift, year, ad.getReg_term_year());
            if(list.size()!=0)
            {
            %>
             <center> <h1><u>Exam Registration Report</u></h1>
        <br><h2>
            <%
             out.println("Program is "+programme);
             %>
             <br>
             <%
             out.println("Year is "+year);
         %>
        </h2>
        <div class="container">
             <table border="2" class="table">
            <thead>
            
            <th>Sr.no</th> 
            <th>Roll_No</th>
            <th colspan="<%=ad.getMax_reg_courses()%>">Course Code</th>
          
            
            </thead>
            <%  int j=1;
     
                     for(int i=0;i<list.size();i++)
                    {
                    Query query = s.createQuery("SELECT course_code FROM Exam_reg WHERE regno =:rollno and ex_reg_year =:year and ex_reg_date=:reg_term_year and ex_exmt=:ex_exmt and ex_cancel=:ex_cancel");
                    query.setInteger("ex_exmt", 0);
                    query.setInteger("ex_cancel", 0);
                    query.setInteger("year", year);
                    query.setString("rollno",(String)list.get(i));
                    query.setString("reg_term_year", ad.getReg_term_year());
                    
                    //query.list() will give all course code that are registered of that roll number.
                    list1=query.list();
                  
            %>
                
                <tr> 
                
                <td><%= j++%></td>
               
                <td><%=list.get(i)%></td>
                <%for( int j1=0;j1<list1.size();j1++)
                {
                %>
                  <td><%=list1.get(j1)%></td> 
                
                <%}%>
   
                </tr> 
             
                <%}%>

        </table> 
        </div>
    <%}
    else
    {
        response.sendRedirect("../views/Admin/examRegReport.jsp?failResult=record not found");
    }}
    %>
    </center>
            
           
       
   
