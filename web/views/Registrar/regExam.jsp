<%-- 
    Document   : regExam
    Created on : May 9, 2019, 10:06:17 AM
    Author     : Shubham Nehe
--%>

<%@page import="mainController.StudentCoursesCon"%>
<%@page import="beans.StudentCourses"%>
<%@page import="mainController.CourseCon"%>
<%@page import="beans.Courses"%>
<%@page import="beans.Course_reg"%>
<%@page import="beans.Student_data"%>
<%@page import="mainController.StudCon"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Exam Registration</title>
        <link rel="stylesheet" href="../../assets/css/bootstrap.min.css">
        <script>
           function onBtn(ch) 
            {
                    var courses=new Array();
                    var ischecked=false; 
                    courses=document.getElementsByName("courseB[]");
                    for(var i=0;i<courses.length;i++)
                    {
                        if(courses[i].checked)
                            {
                                    ischecked=true;
                                    break;
                            }
                    }
                    document.getElementById('register').disabled=!ischecked;
                    
            }
       </script>
    </head>
    <body>
    <% if(session.getAttribute("registrar_uname")==null || session.getAttribute("registrar_user")==null)
        {
           response.sendRedirect("../../index.jsp");
        }
        else if(session.getAttribute("registrar_user").equals("registrar")) 
       { 
           response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
           String rollNo=request.getParameter("rollno");
           %>
           <%@include file="registrarHeader.jsp"%>
           <form method="POST" action="courseRegPrint.jsp?rollno=<%=rollNo%>">
               <button class="btn btn-primary pull-right">Course Registration Print</button>
           </form><br> 
           <form action="../../Controller/regExamByRegistrar.jsp?rollno=<%=rollNo%>" method="POST">   
               <h1><center><u>Exam Registration</u></center></h1><hr>
               <%  
           Student_data stud=(Student_data)StudCon.getStudentInfo(rollNo);
           //list2 gives courses which are registered by student.
            List list2=StudCon.getRegCourse(rollNo,stud.getTerm(),stud.getYear());
            //List3 gives backlog courses
            List list3=StudCon.getBackCourse(rollNo);
           
            Courses course=null;
            Course_reg coursereg;
            StudentCourses studCourses;
            StudentCourses backCourseResult;
            //Dispalying regular registered courses.
            if(list2.size()!=0)
            {
                %>
              <center><h2>Registered courses</h2><br>
             <table border="1" class="table">
                 <thead>
                 <th>Sr.no</th> 
                 <th>Course Code</th>
                 <th>Course Name</th>
                 <th>Credits</th>
                 <th>TH</th>
                 <th>PT</th>
                 <th>PR</th>
                 <th>TW</th>
                 <th>OR</th>
                 </thead>
                 <%
                //Using for each loop for showing available courses.
                
                int j=1;
                if(list2!=null) 
                {
                    for(Object obj:list2)
                    { 
                        coursereg=(Course_reg)obj;
                        course=CourseCon.getCourseObject(coursereg.getCourse_code());                      
                %>
                    <tr> 
                    <td><%=j++%></td> 
                    <td><%=course.getCourse_code()%></td> 
                    <td><%=course.getCourse_name()%></td>  
                    <td><%=course.getCou_credit() %></td>  
                    <td><%if(course.getCou_th_min()>0)out.print("Y"); else out.print("--"); %></td>  
                    <td><%if(course.getCou_pt_min()>0)out.print("Y"); else out.print("--"); %></td>  
                    <td><%if(course.getCou_pr_min()>0)out.print("Y"); else out.print("--"); %></td>  
                    <td><%if(course.getCou_tw_min()>0)out.print("Y"); else out.print("--"); %></td>  
                    <td><%if(course.getCou_or_min()>0)out.print("Y"); else out.print("--"); %></td>
                    </tr> 
              <%   }//for closing
                 
                }//if closing
            }//outer if closing
             %>         
        </table>
        
        <%    //Dispalying backlog courses. 
             if(list3.size()==0)
             {}
             else 
             { %>
              <h2>Backlog courses</h2>
             <table border="1" class="table"> 
            <thead>
            <th>Sr.no</th> 
            <th>Select Course</th>
            <th>Course Code</th>
            <th>Course Name</th>
            <th>Credits</th> 
            <th>TH</th>
            <th>PT</th>
            <th>PR</th> 
            <th>TW</th>
            <th>OR</th>
            </thead>
            
             <% 
                int j=1;
                //for(Object obj:list3)
                for(int i=0;i<list3.size();i++)
                {
                    coursereg=(Course_reg)list3.get(i);
                    course=CourseCon.getCourseObject(coursereg.getCourse_code().trim());
                    backCourseResult=StudentCoursesCon.getStudCourseResult(rollNo, course.getCourse_code());
                    System.out.print("****************************************************************************************************************************************************************************************************************************************************************************************************************************");
                    System.out.println("_________________Theory"+backCourseResult.isTheoryIsPass());
                    System.out.println("_________________ Oral"+backCourseResult.isOralIsPass());
                    System.out.println("_________________ Termwork"+backCourseResult.isTermworkIsPass());
                    System.out.println("_________________ Practical"+backCourseResult.isPracticalIsPass());
                    
                     %>
                    <tr> 
                        <td><%=j++%></td> 
                        <td><input type="checkbox" name="courseB[]" value="<%=course.getCourse_code()%>" checked onchange="onBtn()"></td>
                        <td><%=course.getCourse_code()%></td> 
                        <td><%=course.getCourse_name()%></td> 
                        <td><%=course.getCou_credit() %></td> 
                        
                        
                        <%
                            /*if(course.getCou_th_min()>0)
                            {
                                //either this one is back or pass
                                if back
                                    state="checked";//back
                                else
                                    state="checked disabled"//passed
                            }
                            else state="disabled"; //This means that this thing cannot be registered by student(it is unavailable).
                        */
                        %> 
                        <td><%if(course.getCou_th_min()>0 && course.getCou_th_max()>0){ if(backCourseResult.isTheoryIsPass())out.print("PASS"); else {%><input type="checkbox" name="courseTH[]" checked onclick="return false;"><%}} else out.print("--");%> </td>  
                        <td><%if(course.getCou_pt_min()>0 && course.getCou_pt_max()>0){ out.print("PASS");} else out.print("--");%> </td>  
                        <td><%if(course.getCou_pr_min()>0 && course.getCou_pr_max()>0){ if(backCourseResult.isPracticalIsPass())out.print("PASS"); else {%><input type="checkbox" name="coursePR[]" checked onclick="return false;"><%}} else out.print("--");%> </td>  
                        <td><%if(course.getCou_tw_min()>0 && course.getCou_tw_max()>0){ if(backCourseResult.isTermworkIsPass())out.print("PASS"); else {%><input type="checkbox" name="courseTW[]" checked onclick="return false;"><%}} else out.print("--");%> </td>  
                        <td><%if(course.getCou_or_min()>0 && course.getCou_or_max()>0){ if(backCourseResult.isOralIsPass())out.print("PASS"); else {%><input type="checkbox" name="courseOR[]" checked onclick="return false;"><%}} else out.print("--");%> </td>                        
                    </tr> 
                    <%  
                }//for close
             %> 
             </table>
                    <%
              }//outer if close%>
        <button class="btn btn-primary" id="register">Register for Exam</button> 
             </center>
           </form>
       <%}//session checing if closed %>
       
       
    </body>
</html>
