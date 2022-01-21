<%-- 
    Document   : editRegistration
    Created on : Dec 2, 2018, 5:38:12 PM
    Author     : Shubham Nehe
--%>

<%@page import="beans.Exam_reg"%>
<%@page import="mainController.StudentCoursesCon"%>
<%@page import="beans.StudentCourses"%>
<%@page import="mainController.CourseCon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.Student_data"%>
<%@page import="mainController.StudCon"%>
<%@page import="java.util.List"%>
<%@page import="beans.Course_reg"%>
<%@page import="beans.Courses"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="../../assets/css/bootstrap-select.min.css">
        <script src="../../assets/js/jquery.min.js"></script>
        <script src="../../assets/js/bootstrap.min.js"></script>
        <script src="../../assets/js/bootstrap-select.min.js"></script>
        <script src="ajax"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Registration</title> 
        <link rel="stylesheet" type="text/css" href="../../assets/css/bootstrap.min.css">
        <script type="text/javascript">
                var courses=new Array();
                var ischecked=false;
                courses=document.getElementsByName("course[]");
                
                //Checking if any checkbox is checked to enable the save and register buttons.
                for(var i=0;i<courses.length;i++)
                {
                        if(courses[i].checked)
                        {
                                ischecked=true;
                                break;
                        }
                }
                
                document.getElementById('register').disabled=!ischecked;
            function onBtn(ch) 
            {
                    var courses=new Array();
                    var ischecked=false; 
                    courses=document.getElementsByName("course[]");
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
            
            function checkAll() 
            {
                var count=0,flag=false;        
                for(var i=0;i<courses.length;i++)
                {
                    if(courses[i].checked==true) 
                        count++;
                }
                if(count==courses.length)
                    flag=false;
                else
                    flag=true;
                for(var i=0;i<courses.length;i++)
                {
                    courses[i].checked=flag; 
                }
                onBtn();
            } 
        </script>
    </head>
    <body>
        
        <% //checking if user is login or not.
            if(session.getAttribute("registrar_uname")==null || session.getAttribute("registrar_user")==null)
            {
               response.sendRedirect("../../index.jsp");
            }
            else if(session.getAttribute("registrar_user").equals("registrar")) 
           {
               %><%@include file="registrarHeader.jsp"%> <%
               //Retrieving student information
               //edit button is set with rollno of corresponding user.
               try{
                   
               Student_data stud=(Student_data)StudCon.getStudentInfo(request.getParameter("editBtn"));
          %> 
          
        <div class="container">
            <%//Displaying flash data.
               try{
                   if(!request.getParameter("result").equals(null)) %>
                   <p class="alert alert-danger"><a href="#" class="close" data-dismiss="alert">&times;</a><% out.print(request.getParameter("result"));%></p>
              <% }catch(Exception e){} %>
            <div class="row">
                <center><h2><u>Course Registration</u></h2></center>
                <div class="col-sm-10">
                    
                    <h3> <u>Student details </u></h3><br>
                    <h4> 
                        Roll No. : <%=request.getParameter("editBtn")%><br><br>
                        Name : <%=stud.getS_name()%><br><br>
                        Mobile No. : <%=stud.getPhone_no()%><br><br>
                        Email Id : <%=stud.getS_email()%>
                    </h4> 
                </div>
            </div>
        </div> 
        <center> 
        <form method="POST" action="../../Controller/saveOrRegCourse.jsp" name="courses"> 
        <div class="container">
        <div class="row">
            <div class="col-lg-1"></div>
            <div class="col-lg-10"> 
                <center><h2>Regular Courses</h2></center>      
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
              if(stud.getS_regular().equals("d") && stud.getYear()==2)
              {  
                  StudCon.regDsyFirstYearCourses(stud.getRollno(),stud.getProgramme(),stud.getTerm());
                 
              }
             
                 int j=1; 
                //list1 gives available courses for student.
                List list1=StudCon.studRegCourse(request.getParameter("editBtn"),request.getParameter("term"),new Integer(request.getParameter("year")));
                
                //list2 gives courses which are registered by student.
                List list2=StudCon.getRegCourse(request.getParameter("editBtn"),request.getParameter("term"),new Integer(request.getParameter("year")));
                
                //list3 gives backlog courses of student
                List list3=StudCon.getBackCourse(request.getParameter("editBtn"));
                
                //List4 gives pending courses
                List list4=StudCon.getPendingCourse(request.getParameter("editBtn"));
                
                //Using for each loop for showing available courses.
                String statusChk="unchecked",statusBtn="false";
                /*
                if(stud.getS_regular().equals("d") && stud.getYear()==2)
                {  
                    int s=StudCon.getDsyFirstYearCourse(stud.getProgramme(),1,(String)session.getAttribute("uname"));
                }
              */
                //Showing already saved courses checked and others unchecked.
                int num=0;
                System.out.print("^^@@Calling getExRegCourse() method");
                List exCourses=StudCon.getExRegCourse(request.getParameter("editBtn"),request.getParameter("term"),new Integer(request.getParameter("year")));
                try{for(Object o: exCourses)
                {
                    Exam_reg examReg=(Exam_reg)o;
                    if(examReg.getEx_cancel()==0)
                        num++;
                }}catch(Exception e){}
                //Redirecting to printRegistration.jsp if exam registartion has been completed.
                if(num==exCourses.size() && exCourses.size()>0)
                    response.sendRedirect("printRegistration.jsp?rollno="+request.getParameter("editBtn"));
                
                num=0;
                for(Object o:list2)
                {
                    Course_reg coursereg=(Course_reg)o;
                    if(coursereg.getReg_can().equals("n"))
                    num++;
                }
                
                //Redirecting to regExam.jsp if course registartion has been completed.
                if(num==list2.size() && list2.size()>0)
                    response.sendRedirect("regExam.jsp?rollno="+request.getParameter("editBtn"));
                
                for(Object obj1:list1) 
                {
                    Courses course=(Courses)obj1; 
                    
                    if(list2!=null) 
                    {
                        for(Object obj2:list2)
                        { 
                            Course_reg coursereg=(Course_reg)obj2;
                            
                            if((course.getCourse_code()).equals(coursereg.getCourse_code().trim()))
                            { 
                                statusChk="checked";
                                statusBtn="false";
                                break;
                            } 
                            else
                            {
                                statusChk="unchecked";
                                statusBtn="true";
                            }
                       
                    } 
              %>  
                <tr> 
                    <td><%=j++%></td> 
                    <td><input type="checkbox" name="course[]" value="<%=course.getCourse_code()%>" <%=statusChk%> onchange="onBtn()"></td>
                    <td><%=course.getCourse_code()%></td> 
                    <td><%=course.getCourse_name()%></td>  
                    <td><%=course.getCou_credit() %></td>  
                    <td><%if(course.getCou_th_min()>0)out.print("Y"); else out.print("--"); %></td>  
                    <td><%if(course.getCou_pt_min()>0)out.print("Y"); else out.print("--"); %></td>  
                    <td><%if(course.getCou_pr_min()>0)out.print("Y"); else out.print("--"); %></td>  
                    <td><%if(course.getCou_tw_min()>0)out.print("Y"); else out.print("--"); %></td>  
                    <td><%if(course.getCou_or_min()>0)out.print("Y"); else out.print("--"); %></td>
                </tr> 
             <%}
            }//for closing%>  
             
        </table>
                <a name="checkAll" class="btn btn-primary"  onclick="checkAll()">Check All</a> 
       <%
             if(list3.size()!=0)
             { 
                StudentCourses backCourseResult;
       %>
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
             <h2>Backlog Courses</h2>
             <% 
                for(Object obj4:list4)
                {
                    Courses course=(Courses)obj4; 
                        
                        for(Object obj:list3)
                        {
                            Course_reg coursereg=(Course_reg)obj;
                            if((course.getCourse_code()).equals(coursereg.getCourse_code().trim()))
                            {
                               backCourseResult=StudentCoursesCon.getStudCourseResult(request.getParameter("editBtn"), course.getCourse_code()); 
                               statusChk="checked";
                    %>
                <tr> 
                    <td><%=j++%></td>                 
                    <td><%=course.getCourse_code()%></td> 
                    <td><%=course.getCourse_name()%></td> 
                    <td><%=course.getCou_credit() %></td>  
                    <td><%if(course.getCou_th_min()>0 && course.getCou_th_max()>0){ if(backCourseResult.isTheoryIsPass())out.print("PASS"); else { out.print("Y");}} else out.print("--");%> </td>  
                    <td><%if(course.getCou_pt_min()>0 && course.getCou_pt_max()>0){ out.print("PASS");} else out.print("--");%> </td>  
                    <td><%if(course.getCou_pr_min()>0 && course.getCou_pr_max()>0){ if(backCourseResult.isPracticalIsPass())out.print("PASS"); else { out.print("Y"); }} else out.print("--");%> </td>  
                    <td><%if(course.getCou_tw_min()>0 && course.getCou_tw_max()>0){ if(backCourseResult.isTermworkIsPass())out.print("PASS"); else { out.print("Y"); }} else out.print("--");%> </td>  
                    <td><%if(course.getCou_or_min()>0 && course.getCou_or_max()>0){ if(backCourseResult.isOralIsPass())out.print("PASS"); else { out.print("Y"); }} else out.print("--");%> </td>                        
                </tr> 
                
             <%  }//if close
                }//for close
              }//outer for close
            }//outer if close
            %>
             </table>
             <h2>Pending Courses</h2><hr>
             <select class="selectpicker" data-live-search="true" name="cname">
                
             <%
               for(Object obj1:list4)
                {
                    Courses course=(Courses)obj1;  
               %>    
             <option value="<%=course.getCourse_name()%>|<%=course.getCourse_code()%>|<%=course.getCou_credit()%>|<%if(course.getCou_th_min()>0)out.print("Y"); else out.print("--");%>|<%if(course.getCou_pt_min()>0)out.print("Y"); else out.print("--");%>|<%if(course.getCou_pr_min()>0)out.print("Y"); else out.print("--");%>|<%if(course.getCou_tw_min()>0)out.print("Y"); else out.print("--"); %>|<%if(course.getCou_or_min()>0)out.print("Y"); else out.print("--"); %>"><%=course.getCourse_name()%><%out.print("("+course.getCourse_code()+")"); %></option>
             <%
                }
                 %>
             </select>
             <button type="button" class="btn btn-success" id="btn-add" onclick="addCourse();">Add Course</button>
             
             
             <!--Pending course table trial-->
             <center><br><br>
             <table id="ptable" class="table" border="1">
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
            <th>Delete</th>
             </thead>
             <tbody>
                 
             </tbody>
             </table>
                 <script src="ajax"></script>
             </center>
            
             <!--trial end -->
        <!--Hidden attribute rollno is used in saveOrRegCourse.jsp for course registration of that student. -->
        <input type="hidden" name="rollno" value="<%=request.getParameter("editBtn")%>">  
        <input type="hidden" name="term" value="<%=request.getParameter("term")%>">
        <input type="hidden" name="year" value="<%=request.getParameter("year")%>">        
        
        </div>
        </div>
        </div> 
        <center>
            
            <button class="btn btn-primary" formaction="../../Controller/saveOrRegCourse.jsp?flag=register&user=registrar" name="confirmBtn" id="register" value="<%=request.getParameter("editBtn")%>">Confirm</button> 
        </center>
        </form>
               
            
    </center> 
        <%}
          catch(Exception e) 
          {%>
          <h2><center><% out.println("Exception occured : "+e);%></center></h2>
          <%}
            }//else closing used for session checking.%> 
          
    <!--############################## JAVASCRIPT ####################################-->    
   
    <script type="text/javascript">
        var j=0;
        
    function addCourse()
    { 
        var v=document.courses.cname.value; 
        var x=v.split("|",8);
        
        var tr = document.createElement('tr');
        
        var td1 = tr.appendChild(document.createElement('td'));
        var td2 = tr.appendChild(document.createElement('td'));
        var td3 = tr.appendChild(document.createElement('td'));
        var td4 = tr.appendChild(document.createElement('td'));
        var td5 = tr.appendChild(document.createElement('td'));
        var td6 = tr.appendChild(document.createElement('td'));
        var td7 = tr.appendChild(document.createElement('td'));
        var td8 = tr.appendChild(document.createElement('td'));
        var td9 = tr.appendChild(document.createElement('td'));
        var td10 = tr.appendChild(document.createElement('td'));
        var td11 = tr.appendChild(document.createElement('td'));
        td1.height="40";
        td1.innerHTML =++j;
        td2.innerHTML="<input type='checkbox' name='courseP[]' value='"+x[1]+"' onchange='onBtn()'>";
        td3.innerHTML=x[1];
        td4.innerHTML=x[0];
        td5.innerHTML=x[2];
        td6.innerHTML=x[3];
        td7.innerHTML=x[4];
        td8.innerHTML=x[5];
        td9.innerHTML=x[6];
        td10.innerHTML=x[7];
        td11.innerHTML="<input type='button' value='Delete' onclick='delCourse(this)' class='btn btn-danger'>";
        document.getElementById("ptable").appendChild(tr);
    }
    function delCourse(course)
    {
        var cou=course.parentNode.parentNode;
        cou.parentNode.removeChild(cou);
    }
    
    </script>
    <%@include file="../../footer.jsp" %> 
                            
    </body>
</html>
