<%-- 
    Document   : Header
    Created on : Aug 17, 2018, 2:23:51 PM
    Author     : sarvadnya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../../assets/css/bootstrap.min.css">
        <title>Header</title> 
        <style>
            .navbar{
                padding:3px;
            }
        </style> 
    </head>
    <body>      
<nav class="navbar navbar-inverse">  
    <div class="navbar-collapse">
        <div class="container-fluid"> 
            <div class="row"> 
                    <div class="navbar-header pull-right">
                        <a class="navbar-brand" href="../Admin/adminLoginForm.jsp">Admin Login</a>
                    </div>
                
                    <div class="navbar-header pull-right">
                        <a class="navbar-brand" href="../Registrar/registrarLoginForm.jsp">Registrar Login</a>
                    </div>
                
                    <div class="navbar-header pull-right">
                        <a class="navbar-brand" href="../HOD/hodLoginForm.jsp">Hod Login</a>
                    </div>
                
                    <div class="navbar-header pull-right">
                        <a class="navbar-brand" href="../Student/studLoginForm.jsp">Student Login</a>
                    </div> 
                
                    <div class="navbar-header pull-right">
                        <a class="navbar-brand" href="../../index.jsp">Home</a>
                    </div>
            </div> 
        </div>
    </div>
</nav> 
<div class="container">