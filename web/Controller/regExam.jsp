<%-- 
    Document   : regExam
    Created on : Dec 28, 2018, 11:19:05 PM
    Author     : sarvadnya
--%>


<%@page import="mainController.StudentCoursesCon"%>
<%@page import="beans.StudentCourses"%>
<%@page import="beans.Courses"%>
<%@page import="mainController.ExamRegCon"%>
<%@page import="mainController.CourseCon"%>
<%@page import="beans.Exam_reg"%>
<%@page import="mainController.AdminCon"%>
<%@page import="beans.Admin_data"%>
<%@page import="beans.Course_reg"%>
<%@page import="beans.Student_data"%>
<%@page import="java.util.List"%>
<%@page import="mainController.StudCon"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html> 
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration of Examination</title>
    </head>
    <body>
        <%
            //session checking
            if(session.getAttribute("stud_uname")==null || session.getAttribute("stud_user")==null)
            { 
               response.sendRedirect("../../index.jsp");
            }
            else if(session.getAttribute("stud_user").equals("student")) 
           {  
               System.out.print("________________________________________________________&&&&&&&&&&&&&&&&&&&&&&&&&&&&regExam.jsp(Controller)&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"); 
                Student_data stud=(Student_data)StudCon.getStudentInfo((String)session.getAttribute("stud_uname"));
                //list1 gives courses which are registered by student.
               List list1=StudCon.getRegCourse((String)session.getAttribute("stud_uname"),stud.getTerm(),stud.getYear());

               String courses[]=new String[list1.size()];
               Courses course=null;
               int i=0;
               
               //Copying regular course codes into string array.
               for(Object obj1:list1)
               {
                    Course_reg c1=(Course_reg)obj1;
                    courses[i++]=c1.getCourse_code();
               }
               
               Admin_data ad=(Admin_data)AdminCon.getAdminInfo();
               /*System.out.print("_______________________courses");
               for(String s:courses)
               {
                  System.out.print("_______________________course____________"+s);            
               }*/
               
                //Exam registration of regular courses.
               int res[]=StudCon.regExam(courses,(String)session.getAttribute("stud_uname"),ad.getReg_term_year(),stud.getTerm(),stud.getYear(),(String)session.getAttribute("stud_user"));
               try{
               System.out.println("\n*\n*\n*\n*\n\n*\n*\n*\n*\n\n*\n*\n*\n*\n\n*\n*\n*\n*\n\n*\n*\n*\n*\n\n*\n*\n*\n*\n\n*\n*\n*\n*\n\n*\n*\n*\n*\n\n*\n*\n*\n*\n\n*\n*\n*\n*\n\n*\n*\n*\n*\n\n*\n*\n*\n*\n\n*\n*\n*\n*\n\n*\n*\n*\n*\n\n*\n*\n*\n*\n\n*\n*\n*\n*\n\n*\n*\n*\n*\n\n*\n*\n*\n*\n\n*\n*\n*\n*\n");
               System.out.println("zxcvb");
               String courseB[]=request.getParameterValues("courseB[]");
               System.out.print("_______________________BACKLOG courses");
               for(String s: courseB)
               { 
                  System.out.println(s);            
               } 
               
               Exam_reg er=new Exam_reg();
               StudentCourses backCourseResult=new StudentCourses();
               
               //Exam registration of backlog courses.
               if(courseB.length>0)
               {
                   System.out.print("@@@@@@@@@@@@@@@@@@@@@@  courseB  array size greater than zero @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"); 
                   for(int k=0;k<courseB.length;k++)
                    { 
                        System.out.print("@@@@@@@@@@@@@@@@@@@@@@  courseB  "+courseB[k]+" @@@@@@@@@@@@@@@@@@"); 
                         course=CourseCon.getCourseObject(courseB[k]);
                         System.out.print("_______________(in regExam.jsp_____controller file) calling getStudCourseResult()");
                         backCourseResult=StudentCoursesCon.getStudCourseResult((String)session.getAttribute("stud_uname"), courseB[k]);
                         System.out.print("_______________(in regExam.jsp_____controller file)getStudCourseResult() called success__________");
                         //Setting Ex_th field
                         try{course.getCou_th_max();}catch(Exception e){System.out.print("______theory max_________"+e);}
                         
                         try{System.out.print("________________VALUE_______________"+backCourseResult.isTheoryIsPass());}catch(Exception e){System.out.print("______theory pass_________"+e);}
 ////////////////////////////////////////////////                   EXCEPTION                       //////
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         if(course.getCou_th_max()>0)
                         {
                             if(backCourseResult.isTheoryIsPass())//If PASS
                                 er.setEx_th(0);
                             else //IF BACK
                                 er.setEx_th(1);
                         } 
                         else
                             er.setEx_th(0);
                         System.out.print("_______________th set__________");
                         //Setting Ex_pt field
                         er.setEx_pt(0);
                         System.out.print("_______________pt set__________");
                         //As the course is backlog, so setting ex_back field to 1.
                         er.setEx_back(1);
                         //Setting Ex_pr field
                         if(course.getCou_pr_max()>0)
                         {
                             if(backCourseResult.isPracticalIsPass())//If PASS
                                 er.setEx_pr(0);
                             else //IF BACK
                                 er.setEx_pr(1);
                         }
                         else
                             er.setEx_pr(0);
                         System.out.print("_______________pr set__________");
                         
                         //Setting Ex_or field
                         if(course.getCou_or_max()>0)
                         {
                             if(backCourseResult.isOralIsPass())//If PASS
                                 er.setEx_or(0);
                             else //IF BACK
                                 er.setEx_or(1);
                         }
                         else
                             er.setEx_or(0);
                         System.out.print("_______________or set__________");
                         
                         //Setting Ex_tw field
                         if(course.getCou_tw_max()>0)
                         {
                             if(backCourseResult.isTermworkIsPass())//If PASS
                                 er.setEx_tw(0);
                             else //IF BACK
                                 er.setEx_tw(1);
                         }
                         else
                             er.setEx_tw(0);
                         System.out.print("_______________tw set__________");
                         
                         er.setCourse_code(courseB[k].trim());
                         er.setProg(stud.getProgramme());
                         er.setEx_reg_date(ad.getReg_term_year());
                         er.setEx_reg_term(stud.getTerm());
                         er.setEx_reg_year(stud.getYear());
                                                  
                         er.setShift(stud.getShift()); 
                         System.out.print("_______________shift set__________");
                         if((String)session.getAttribute("registrar_uname")!=null)
                         {   
                             //Exam registration by registrar
                             er.setEx_cancel(0);
                         }
                         else
                         {   
                             //Exam registration by student
                             er.setEx_cancel(1);
                         }
                         
                         System.out.print("_______________setting regno __________");
                         er.setRegno((String)session.getAttribute("stud_uname"));
                         
                         System.out.print("_______________Calling");
                         ExamRegCon.exRegister(er);  //putting the result in result array.
                         System.out.print("__________"+courseB[k]+"_________Success");
                    
                    }//for loop close
               }//Outer if close.
            }
            catch(Exception e) 
            { 
                System.out.print("______________________Exception in regExam.jsp(Controller)____________________"+e);
            }
            response.sendRedirect("../views/Student/printRegForStud.jsp");
        } //if close for session check
            %>
    </body>
</html> 
