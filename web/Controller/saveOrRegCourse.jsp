
<%@page import="beans.Admin_data"%>
<%@page import="mainController.AdminCon"%>
<%@page import="beans.Student_data"%>
<%@page import="beans.Course_reg"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="mainController.StudCon"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>RegCourse Page</title>
    </head>
    <body>
       <%
            if(session.getAttribute("stud_uname")==null && session.getAttribute("registrar_uname")==null) 
            {
               response.sendRedirect("../index.jsp"); 
            }
            
            //This else if deals with the registration from student account.
            try{
                if(session.getAttribute("stud_user").equals("student") && request.getParameter("user").equals("student")) 
            { 
                //receiving courses in array of courses.
                int len1=0,len2=0,len3=0,total_len=0,r,totalCourses=0;
                String year,term;
                SimpleDateFormat f=new SimpleDateFormat("dd/MM/yyyy");
                String date=f.format(new Date());
                Student_data sd=(Student_data)StudCon.getStudentInfo((String)session.getAttribute("stud_uname"));
                String course[]=request.getParameterValues("course[]");
                String courseB[]=request.getParameterValues("courseB[]");
                String courseP[]=request.getParameterValues("courseP[]");
                
                //add regular and pending courses in one array
                try{
                    if(courseP.length!=0)
                    totalCourses=course.length+courseP.length;
                    }
                    catch(Exception e){
                    totalCourses=course.length;
                    }
                
                //create array of length equal to course+courseP
                String courses[]=new String[totalCourses]; 
                
                for(int i=0;i<course.length;i++)
                {
                    courses[i]=course[i];    //copy course array into courses
                }
                try{
                     if(courseP.length!=0)
                     {
                         r=0; //var to initialize courseP to 0
                         //merging regular and pending course codes
                          for(int i=course.length;i<courses.length;i++)
                          {
                              courses[i]=courseP[r];   //copy courseP array into courses 
                              r++;
                          }
                     }
                }
                catch(Exception e){
                 // out.print("CourseP array is empty");
                }
               
                if(course.length==0)
                {
                    out.println("You haven't selected any course.");
                }
                else
                {
                    len1=course.length;
                    try{len2=courseB.length;}catch(Exception e){}
                    try{len3=courseP.length;}catch(Exception e){}
                    total_len=len1+len3;
                    try{if(courseB.length!=0)
                    {
                        total_len=len2+len1;
                    }}catch(Exception e){}
                    try{if(courseP.length!=0)
                    {
                        total_len=len1+len3;
                    }}catch(Exception e){}
                    try{if(courseB.length!=0&&courseP.length!=0)
                    {
                        total_len=len1+len2+len3;
                    }}catch(Exception e){}
                    //calculated the total number of courses selected by student
                    //If total courses is greater than maximum allowed courses then back to the studRegistration.jsp.
                    if(total_len>AdminCon.getMaxRegCourses())  
                    {
                        response.sendRedirect("../views/Student/studRegistration.jsp?msg=You can register only "+AdminCon.getMaxRegCourses()+" courses");
                    }
                    else if(request.getParameter("flag").equals("save")) 
                    {
                         try
                        {
                            int res[]=StudCon.regCourse(courses,(String)session.getAttribute("stud_uname"),request.getParameter("flag"),date,sd.getTerm(),(new Integer(sd.getYear()).toString()),(String)session.getAttribute("stud_user"));
                        }
                        catch(Exception e){ 
                        out.print(e);
                        }
                        response.sendRedirect("../views/Student/saveCourse.jsp"); 
                    }
                } 
               
            }
            }catch(Exception e){
            //if student is not logged in
            }
            
            /*******************************************Registrar**********************************************/
            
            //This else if deals with the registration from registrar account.
            try 
            {
            if(session.getAttribute("registrar_user").equals("registrar") && request.getParameter("user").equals("registrar"))
            {
                SimpleDateFormat f=new SimpleDateFormat("dd/MM/yyyy");
                String date=f.format(new Date());
                int j=0,r,len1=0,len2=0,len3=0,total_len=0,total_reg=0;
                //receiving courses in array of courses.
                Student_data sd=(Student_data)StudCon.getStudentInfo(request.getParameter("rollno"));
                String course[]=request.getParameterValues("course[]");//regular courses
                 String courseB[]=request.getParameterValues("courseB[]");//backlog courses
                String courseP[]=request.getParameterValues("courseP[]");//pending courses
                if(course.length==0)
                {
                    out.println("You haven't selected any course.");
                }
                else
                { 
                    try{len1=course.length;}catch(Exception e){}
                try{len2=courseB.length;}catch(Exception e){}
                try{len3=courseP.length;}catch(Exception e){}
                total_len=len1+len3;
                try{if(courseB.length!=0)
                {
                    total_len=len2+len1;

                }}catch(Exception e){}
                try{if(courseP.length!=0)
                {
                    total_len=len1+len3;
                    total_reg=total_len;
                }}catch(Exception e){total_reg=course.length;}
                try{if(courseB.length!=0&&courseP.length!=0)
                {
                    total_len=len1+len2+len3;
                }}catch(Exception e){}

                    String courses[]=new String[total_len];
                    String coursesReg[]=new String[total_reg];
                    //create array of length equal to course+courseP                
                   // out.print(j);
                   for(int i=0;i<course.length;i++)
                   { j++;
                       courses[i]=course[i];    //copy course array into courses
                       coursesReg[i]=course[i];
                   }
                   try{
                   if(courseP.length!=0)
                   {
                        r=0; //var to initialize courseP to 0
                        //merging regular and pending course codes
                        for(int i=course.length;i<courses.length;i++)
                        {
                            j++;
                            courses[i]=courseP[r];   //copy courseP array into courses 
                            coursesReg[i]=courseP[r];
                            r++;
                        }
                   }
                   }
                   catch(Exception e){
                  // out.print("CourseP array is empty");
                   }

                   try{
                   if(courseB.length!=0)
                   {
                        r=0; //var to initialize courseB to 0
                        //merging regular and pending course codes
                        for(int i=j;i<courses.length;i++)
                        {
                            courses[i]=courseB[r];   //copy courseP array into courses 
                            r++;
                        }
                   }
                   }
                   catch(Exception e){
                  // out.print("CourseP array is empty");
                   }

                   //If total courses is greater than maximum allowed courses then back to the editRegistration.jsp.
                    if(courses.length>AdminCon.getMaxRegCourses())
                    {
                       response.sendRedirect("../views/Registrar/editRegistration.jsp?editBtn="+request.getParameter("rollno")+"&result=Only "+AdminCon.getMaxRegCourses()+" courses are allowed."); 
                    }

                    System.out.print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!LENGTH = "+courses.length);
                    //Confirming registration of all courses using regCourse() method.
                    StudCon.regCourse(coursesReg,request.getParameter("rollno"),request.getParameter("flag"),date,sd.getTerm(),String.valueOf(sd.getYear()),(String)session.getAttribute("registrar_user"));
                    Admin_data ad=AdminCon.getAdminInfo();
                    System.out.print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!LENGTH = "+courses.length);
                    //Examination registration of all confirmed courses
                    try{
                    //int res[]=StudCon.regExam(course,request.getParameter("rollno"),ad.getReg_term_year(),sd.getTerm(),sd.getYear(),(String)session.getAttribute("registrar_user"));                        
                    }catch(Exception e){}
                     try{
                    //int res1[]=StudCon.regExam(courseB,request.getParameter("rollno"),ad.getReg_term_year(),sd.getTerm(),sd.getYear(),(String)session.getAttribute("registrar_user"));                        
                    }catch(Exception e){}

                      try{
                    //int res2[]=StudCon.regExam(courseP,request.getParameter("rollno"),ad.getReg_term_year(),sd.getTerm(),sd.getYear(),(String)session.getAttribute("registrar_user"));                        
                    }catch(Exception e){}
                    }
                    response.sendRedirect("../views/Registrar/regExam.jsp?rollno="+request.getParameter("rollno"));
                    //response.sendRedirect("../views/Registrar/printRegistration.jsp?rollno="+request.getParameter("rollno"));
                 
            }
            }
            catch(Exception e)
            {
                //if registrar is not logged in
            }
       %>
    </body> 
</html>
