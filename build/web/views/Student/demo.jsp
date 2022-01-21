<%-- 
    Document   : demo
    Created on : May 12, 2019, 5:06:45 PM
    Author     : Shubham Nehe
--%>

<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Session"%>
<%@page import="mainController.StudentCoursesCon"%>
<%@page import="beans.StudentCourses"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .disable{
                pointer-events: none;
                opacity: 0.5;
            } 
        </style> 
        <script>
            function show(j)
            {
                ch[j]=1000;
                document.write("aaaaaaaaaaaaaa");
            } 
        </script>
    </head> 
    <body> 
        
        
        <%
                /*StudentCourses studCourses=StudentCoursesCon.getStudCourseResult("166126","CM6798");
                studCourses.setPracticalIsPass(true);
                out.print("OLD THEROy"+studCourses.isTheoryIsPass());
                studCourses.setTheoryIsPass(true);
                out.print("NEW THEROy"+studCourses.isTheoryIsPass());*/
                //out.print("_____________isPracticalIsPass__________________"+studCourses.isPracticalIsPass());
        %>
        
        <%
        Session s;
        SessionFactory sf;
        String rollNo="166126";String courseCode="CM6798";
    
        List li=null;
        try
        {
            sf=SessionFact.SessionFact.getSessionFact();
            s=sf.openSession();
            //System.out.print("__________________Reached to getStudCourseResult method \nRoll no. = "+rollNo+"\nCourseCode = "+courseCode);
            //li=s.createQuery("from StudentCourses where studentId=:rollNo and courseCode=:courseCode").setString("rollNo",rollNo).setString("courseCode", courseCode).list(); 
            li=s.createQuery("from StudentCourses where studentId='166126' and courseCode='CM6798'").list();//.setString("rollNo",rollNo).setString("courseCode", courseCode).list(); 
            s.close();
            //sf.close();
            
        }
        catch(Exception e){out.print("__________________getStudCourseResult() exception"+e);}
        //System.out.print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nn\n\n\n\n\n\n\n________returning from getStudCourseResult()________________");
        /*if(li.size()>0)
            return (StudentCourses)li.get(0);
        else 
            return null;*/
        try{out.print("SIZE________"+li.size());}catch(Exception e){out.println("EX__________"+e);}
        //StudentCourses a=(StudentCourses)li.get(0);
        //out.print(a.getStudentId()+"   ___________________    "+a.getCourseCode());
        //return new StudentCourses();
        %>
        
    </body>
</html>
