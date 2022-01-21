<%@page import="mainController.AdminCon"%>
<%//response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");%>
<%@page import="mainController.HodCon"%>
<%@page import="beans.Student_data"%>
<%@page import="mainController.StudCon"%>
<%@page import="java.util.List"%>
<%@page import="mainController.CourseRegCon"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student List</title>
        <link rel="stylesheet" type="text/css" href="../../assets/css/bootstrap.min.css">
        <style>
            .align{
                text-align: center;
            }
        </style>
    </head>
    <body>
    <%
        if(session.getAttribute("registrar_uname")==null || session.getAttribute("registrar_user")==null)
        {
           response.sendRedirect("../../index.jsp");
        }
        else if(session.getAttribute("registrar_user").equals("registrar")) 
       {
           %> <%@include file="registrarHeader.jsp"%> </div><%
            try{                
                //Retrieving students for registration using term and year.
                List li=HodCon.getStudForReg(HodCon.getRegistrarBranch(session.getAttribute("registrar_uname").toString()),Integer.parseInt(request.getParameter("year")),request.getParameter("term"),Integer.parseInt(request.getParameter("shift")));
                //Checking if li is not empty.
                if(li.size()!=0){ 
                int cnt=1;//Used for printing serial no.
            %>
                <center><h2>Registration</h2></center><br>
                <div class="container">
                    <div class="row center-block">
                        <div class="col-sm-2"></div>
                        <div class="col-sm-8">
                <form method="POST">
                    <table class="table" border="1">
                        <thead>
                        <th class="align" style="width:10%">Course Registration</th> 
                            <th class="align" style="width:10%">Exam Registration</th>
                            <th class="align" style="width:10%">Sr.No</th> 
                            <th class="align" style="width:13%">Roll No.</th>
                            <th>Name</th> 
                            <th class="align">Edit</th>
                           
                        </thead>  
                        <%
                            for(Object student:li) 
                            { 
                                //Retrieving student info usin rollno for printing.
                                Student_data stud=(Student_data)student;
                        %> 
                            
                            <input type="hidden" name="term" value="<%=stud.getTerm()%>">
                            <input type="hidden" name="year" value="<%=stud.getYear()%>">
                        <tr> 
                            <td align="center">
                                <%
                                    boolean regStatus=HodCon.checkRegStatus(stud.getUsername(),stud.getYear(),stud.getTerm());
                                    if(regStatus){ %>
                                    <img src="../../Images/green-tick1.png" height="15" width="15"> 
                                    <%}else{%>
                                    <img src="../../Images/red-cross1.png" height="15" width="15"> 
                                <%}%>
                            </td> 
                            <td align="center">
                                <%
                                    regStatus=StudCon.getExRegStatus(stud.getUsername(),AdminCon.getReg_term_year(),stud.getYear());
                                    if(regStatus){ %>
                                    <img src="../../Images/green-tick1.png" height="15" width="15"> 
                                    <%}else{%>
                                    <img src="../../Images/red-cross1.png" height="15" width="15"> 
                                <%}%>
                            </td> 
                            <td align="center"><%=cnt++%></td>
                            <td align="center"><%=stud.getUsername() %></td>
                            <td><%=stud.getS_name()%></td>
                            <td class="align">
                                <button class="btn btn-md btn-danger" name="editBtn" value="<%=stud.getUsername() %>" formaction="editRegistration.jsp">Edit</button>
                            </td>                             
                        </tr> 
                            <%}//for close
                        %>
                </table>
                </form>
                        </div>
                </div> 
                <%}
                else
                {
                    response.sendRedirect("registrarPanel.jsp?failResult=Sorry, but there are no students for registration");
                }//Used for checking if students are there for registration.
            }
            catch(Exception e)
            {
                out.println("Exception occured : "+e);
            } 
        }//if close used for session check%>
    </body>
</html>
