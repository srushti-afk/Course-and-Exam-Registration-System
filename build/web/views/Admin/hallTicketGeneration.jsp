<%-- 
    Document   : hallTicketGeneration
    Created on : Feb 7, 2019, 7:52:42 PM
    Author     : User
--%>
<%response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");%>
<%@page import="org.hibernate.Session"%>
<%@page import="mainController.AdminCon"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Query"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hall ticket generation</title>
        <link rel="stylesheet" type="text/css" href="../../assets/css/bootstrap.min.css">

    </head>
    <body>
         <%
            if(session.getAttribute("admin_uname").equals(null))
            {
               response.sendRedirect("adminLoginForm.jsp");
            }
            else if(session.getAttribute("admin_user").equals("admin"))
            {    %>
        <%@include file="adminHeader.jsp"%>
        <div class="container">
           
            <%
            try{
                if(!request.getParameter("failResult").equals(null)){%>
            <div class="row"><div class="col-lg-8"> <p class="alert alert-danger"><%= request.getParameter("failResult") %></p></div></div>
            <%} }catch(Exception e){}

            try{
            if(!request.getParameter("result").equals(null)){%>
            <div class="row"><div class="col-lg-8"> <p class="alert alert-success"><%= request.getParameter("result") %></p></div></div>
            <%} }catch(Exception e){}
               
                
        %><br>
            <h2>Generate Hall Ticket</h2>
         <!--form action="../../Controller/generateIndivitualHallTicket.jsp" method="POST"-->
         <!--HallTicketType parameter specifies if the hallticket is for final or pt-->
          <form  method="POST">
               <!--h3>Generate Hall Ticket for all students</h3><br>
               <div class="panel panel-info">
                   <div class="panel-body">
               <label>First PT Date</label> : <input type="date" name="firstPTDate"/><br><br>
               <label>Second PT Date</label> : <input type="date" name="secondPTDate"/><br><br>
               <label>OR/PR/TW Exam Date</label> : <input type="date" name="or_pr_tw"/><br><br>
               <label>Final Exam Date</label> : <input type="date" name="finalExDate"/><br><br>
               <label>End of Term</label> : <input type="date" name="endOfTerm"/><br><br>
               PT:&nbsp;&nbsp;<button type="submit" formaction="../../Controller/generateAllHallTicket.jsp?hallTicketType=pt" class="btn btn-primary">Generate All PT HallTicket</button>
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               </div>
               </div>
               FINAL:&nbsp;&nbsp;<button type="submit" formaction="../../Controller/generateAllHallTicket.jsp?hallTicketType=final" class="btn btn-primary">Generate All Final HallTicket</button>
           
              <h3>Individual Hall Ticket Generation</h3><br>
               Roll number:<input type="text" name="rollnumber"><br><br>
               PT:&nbsp;&nbsp;<button type="submit" formaction="../../Controller/generateIndividualHallTicket.jsp?hallTicketType=pt" class="btn btn-primary">Generate Individual PT HallTicket</button>
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               FINAL:&nbsp;&nbsp;<button type="submit" formaction="../../Controller/generateIndividualHallTicket.jsp?hallTicketType=final" class="btn btn-primary">Generate Individual Final HallTicket</button>
               <br><br><hr-->
               <div class="row">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                        PT Hall Ticket generation
                        </div>
                    </div>
                    <div class="col-lg-6">
                       <div class="panel panel-info">
                        <div class="panel-body">
                            <p>Generate PT Hall Ticket For all Students</p><br>
                            <label>Examination Registration Date </label> : <input type="date" name="exRegDate"/><br><br>
                            <label>First PT Date</label> : <input type="date" name="firstPTDate"/><br><br>
                            <label>Second PT Date</label> : <input type="date" name="secondPTDate"/><br><br>
                            <label>End of Term</label> : <input type="date" name="endOfTerm"/><br><br>
                            <label>OR/PR/TW Exam Date</label> : <input type="text" name="or_pr_tw" placeholder="Before TH Exam"/><br><br>
                            <label>Final Exam Date</label> : <input type="date" name="finalExDate"/><br><br>
                            
                            <center><button type="submit" formaction="../../Controller/generateAllHallTicket.jsp?hallTicketType=pt" class="btn btn-primary">Generate All PT HallTicket</button></center>
                        </div>
                       </div>
                    </div>
                   <div class="col-lg-6">
                       <div class="panel panel-info">
                        <div class="panel-body">
                            <p>Generate PT Hall Ticket For Individual Students</p><br>
                            <label>Roll number:</label> <input type="text" name="rollnumber"><br><br>
                            <center><button type="submit" formaction="../../Controller/generateIndividualHallTicket.jsp?hallTicketType=pt" class="btn btn-primary">Generate Individual PT HallTicket</button></center>
                        </div>
                       </div>
                   </div>
               </div>
                   <div class="row">
                            <div class="panel panel-info">
                            <div class="panel-heading">
                            Final Hall Ticket generation
                            </div>
                            </div>
                       <div class="col-lg-6">
                           <div class="panel panel-info">
                        <div class="panel-body">
                            <p>Generate Final Hall Ticket For All Students
                            <br><br>
                            <center><button type="submit" formaction="../../Controller/generateAllHallTicket.jsp?hallTicketType=final" class="btn btn-primary">Generate All Final HallTicket</button></center>
                        </div>
                       </div>
                        </div>
                       <div class="col-lg-6">
                           <div class="panel panel-info">
                        <div class="panel-body">
                            <p>Generate Final Hall Ticket For Individual Student</p><br>
                            <label>Roll number:</label> <input type="text" name="roll_number"/><br><br>
                            <center><button type="submit" formaction="../../Controller/generateIndividualHallTicket.jsp?hallTicketType=final" class="btn btn-primary">Generate Individual Final HallTicket</button></center>
                        </div>
                       </div>
                        </div>
                    </div>
              </form> 
        </div>
        <!--form action="../../Controller/generateAllHallTicket.jsp" method="POST">
               <button type="submit" class="btn btn-primary">Generate All HallTicket</button>
        </form-->
             

          
       
             <%}%>
    </body>
</html>
