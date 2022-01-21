<%-- 
    Document   : demo2
    Created on : May 12, 2019, 5:52:44 PM
    Author     : Shubham Nehe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body> 
        <h1>Hello World!</h1>
        <%
        String a[]={"h","k"};
            try{
                    a=request.getParameterValues("ch[]");
            }catch(Exception e){out.println("Exception "+e);}
            
           
        for(String s:a){ 
            try{
                out.println("__________"+s); 
            }catch(Exception e){out.println("Exception "+e);}
        }
        
        %>
    </body>
</html>
