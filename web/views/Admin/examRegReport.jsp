<%-- 
    Document   : examRegReport
    Created on : Mar 2, 2019, 7:52:15 PM
    Author     : User
--%>
<%response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Exam Registration Report</title>
     <link rel="stylesheet" type="text/css" href="../../assets/css/bootstrap.min.css">
     <script src="../../assets/js/jquery1.min.js"></script>
     <script src="../../assets/js/bootstrap1.min.js"></script>
     
          <style>
            p{ 
                text-height: 20;
                
            }
        </style>
        
    </head>
    <body>
          <%
            if(session.getAttribute("admin_uname").equals(null))
            {
               response.sendRedirect("adminLoginForm.jsp");
            }
            else if(session.getAttribute("admin_user").equals("admin"))
           {  %>
           <%@include file="adminHeader.jsp"%>
           <br><div class="container"><%
             String result=request.getParameter("result");
            try{
            if(!result.equals(null)){%>
            <div class="row"><div class="col-lg-8"> <p class="alert alert-success"><a href="#" class="close" data-dismiss="alert">&times;</a><%out.print(result);%></p></div></div>
            <%}
                }catch(Exception e){}
              try{
            if(!(request.getParameter("failResult").equals(null))){%>
            <div class="row"><div class="col-lg-8"> <p class="alert alert-danger"><a href="#" class="close" data-dismiss="alert">&times;</a><%out.print(request.getParameter("failResult"));%></p></div></div>
            <%}
                }catch(Exception e){}
                
        %></div>
    <center> <h1><u>Exam Registration Report</u></h1>
  

    <form action="../../Controller/examRegReport.jsp" method="post">
        
        <div class="row">
                <div class="col-lg-5"></div>
                    <div class="col-lg-4">
                        <div class="col-lg-2">
                                <label> Branch:  </label>
                        </div>
                            <div class="col-lg-2">
                                <select name="branch">
                                    <option value="CE">CE</option>
                                    <option value="CM">CM</option>
                                    <option value="Ddgm">DDGM</option>
                                    <option value="EE">EE</option>
                                    <option value="E&TC">E&TC</option>
                                    <option value="IF">IF</option>
                                    <option value="IDD">IDD</option>
                                    <option value="ME">ME</option>
                                    <option value="PE">PE</option>
                                    <option value="AE">AE</option>
                                </select>
                            </div>
                    </div>
                <div class="col-lg-3"></div>
            </div>
            <br>
            
        
       
        <div class="row">
                <div class="col-lg-5"></div>
                    <div class="col-lg-4">
                        <div class="col-lg-2">
                                <label> Year:  </label>
                        </div>
                        <div class="col-lg-2">
                                <select name="year">
                                    <option>1</option>
                                    <option>2</option>
                                    <option>3</option>
                                </select>
                        </div>
                    </div>
                <div class="col-lg-3"></div>
        </div>
            <br>
            
            
        <div class="row">
                <div class="col-lg-5"></div>
                    <div class="col-lg-4">
                        <div class="col-lg-2">
                                <label> Shift:  </label>
                        </div>
                        <div class="col-lg-2">
                                <select name="shift">
                                    <option value="1">1</option>
                                    <option value="2">2</option> 
                                </select>
                        </div>
                    </div>
                <div class="col-lg-3"></div>
        </div>
        <br>
        
         <button class="btn btn-primary">Submit</button>
    </form>
        </center>
    <%}%>
    </body>
    
</html>
