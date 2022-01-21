<%-- 
    Document   : storeAppCourse
    Created on : Sep 2, 2018, 4:29:13 PM
    Author     : sarvadnya
--%>

<%@page import="beans.Courses"%>
<%@page import="java.util.List"%>
<%@page import="mainController.CourseCon"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../assets/css/bootstrap.min.css">
        <title>Save Offer Courses</title>
    </head>
    <body>
        
        <%  //to check whether user(Student) is login or not
            String name=((String)session.getAttribute("hod_uname"));
            if(name.equals(null))
            {
               response.sendRedirect("../views/HOD/hodLoginForm.jsp");
            }
            else
           { 
            %> <%@include file="hodHeader.jsp"%>
         
          <div class="container">
          <table border="1" class="table">
            <thead>
            <th>Sr.no</th>
            <th>Course Code</th>
            <th>Course Name</th>
            </thead>
            <tbody>
            
            <h1>You have offered following subject</h1><br>
                
        <% 
        String course[]=request.getParameterValues("course[]");//getting array of course code checked by student
        if(course!= null)
        {
            int j=0;//count variable
            for(int i=0;i<course.length;i++)
            {
                //String l=CourseCon.storeAppCourses(course[i]);
               try
                {
                    List l=CourseCon.saveOfferCourses(course[i]);//Call to mainController
                    if(l!=null)
                    {
                       Courses cr=new Courses();
                       for(Object obj:l)
                       { 
                       cr=(Courses)obj;
                       %>
                       <tr>
                           <td><%= ++j %></td>
                           <td><%= cr.getCourse_code() %></td>
                           <td><%= cr.getCourse_name() %></td>
                       </tr>               
                       <%
                      }
                    }
                    else
                    {
                        response.sendRedirect("../views/HOD/offerCourseForm.jsp?result=Please select unregistered subjects");
                    }
                }
                catch(Exception e){}                              
               }
            }
          }
        %>
        </tbody>
        </table>
          </div>
         
    </body>
</html>
