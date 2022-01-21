<%-- 
    Document   : registrarLoginForm
    Created on : 27 Aug, 2018, 10:59:15 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../../assets/css/bootstrap.min.css">
        
        <script src="../../assets/css/font-awesome.min.css"></script>
        <script src="../../assets/js/jquery1.min.js"></script>
        <script src="../../assets/js/bootstrap1.min.js"></script>
     
          <style>
            p{
                text-height: 20;               
            }
            .field-icon
            {
                float:right;
                margin-left:-5px;
                margin-right:5px;
                margin-top:-16px;
                position:relative;
                z-index: 2;
                height:30px; 
                width:30px;
                
            }
        </style>
        <title>Registrar Login</title>
    </head>
    <body>
        <% try{
                if(session.getAttribute("regiatrar_user").equals("registrar"))
                    response.sendRedirect("registrarPanel.jsp");
                }catch(Exception e){} 
        %>
        <%@include file="../header.jsp" %>
         <br><div class="container"><%
           
            try{
            if(!(request.getParameter("failResult")).equals(null)){%>
            <div class="row"><div class="col-lg-8"> <p class="alert alert-danger"><a href="#" class="close" data-dismiss="alert">&times;</a><%out.print(request.getParameter("failResult"));%></p></div></div>
            <%}
                }catch(Exception e){}%>
         </div>
         
        <h1> Registrar Login </h1>
         <form action="../../Controller/registrarLogin.jsp" method="post">
            <div class="form-group">
                <div class="row">
                    <div class="col-sm-3">
                        <label>Username :</label>
                        <input type="text" name="username" class="form-control" required oninvalid="this.setCustomValidity('Username is required.')"
                                  oninput="this.setCustomValidity('')" > 
                    </div>
               </div>
            </div>
            
           
            <div class="form-group">
                <div class="row">
                    <div class="col-sm-3">
                        <label>Password :</label>
                        <input type="password" name="password" id="password-field" class="form-control" required pattern=".{6,}" oninvalid="this.setCustomValidity('Password must be of 6 characters.')" oninput="this.setCustomValidity('')">
                        <span toggle="#password-field" class="field-icon toggle-password"><img class="field-icon" src="../../Images/passwordEye.png"></span>
                    </div>
                </div>
             </div>
             
             <input type="submit" class="btn btn-primary" value="Login">
        </form>
         
                <%@include file="../../footer.jsp" %>
                <script type="text/javascript">
            $(".toggle-password").click(function(){
                $(this).toggleClass("fa-eye fa-eye-slash");
                var input=$($(this).attr("toggle"));
                if(input.attr("type")=="password"){
                    input.attr("type","text");
                }else
                {
                    input.attr("type","password");
                }
                
            });
        </script>
    </body>
</html>
