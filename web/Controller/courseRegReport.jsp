<%-- 
    Document   : courseReg
    Created on : Sep 7, 2018, 9:22:51 AM
    Author     : User
--%>


<%@page import="beans.Admin_data"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.Session"%>
<%@page import="beans.Course_reg"%>
<%@page import="java.util.ListIterator"%>
<%@page import="mainController.AdminCon"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Course Registration Report</title>
        <link rel="stylesheet" type="text/css" href="../assets/css/bootstrap.min.css">
    </head>
    
        <%
            String homePath="";
            String uname=((String)session.getAttribute("admin_uname"));
            if(uname.equals(null))
            {
               response.sendRedirect("../index.jsp");
            }
            else
           { 
          %>
           <%@include file="commonHeader.jsp"%>
        <%
            Session s;
            Query qr;
            SessionFactory sf;
            List list1=new ArrayList();
            List list2=new ArrayList();
            Admin_data ad=AdminCon.getAdminInfo();
            sf=SessionFact.SessionFact.getSessionFact();
            s=sf.openSession();
            String programme=request.getParameter("branch");
            int year=Integer.parseInt(request.getParameter("year"));
            int shift=Integer.parseInt(request.getParameter("shift"));
            String term_year=ad.getReg_term_year();
            
            List list=AdminCon.courseRegReport(programme, shift, year, ad.getReg_term_year());
            if(list.size()!=0)
            { 
            %>
             <center> <h1><u>GOVERNMENT POLYTECHNIC NASHIK</u></h1>
                 <p><i><font size="4">(An Autonomous Institute of Government of Maharashtra)</font></i></p>
        
        <%
             out.print("<h3>"+"FINAL COURSE REGISTRATION LIST FOR  "+term_year+"</h3>");
             %>
             </center>
            <% out.print("__________________________________________________________________________________________________________________________________________________");%>
        <h3>         
           <% out.print("<b>"+"Program :- "+"</b>"+programme);
             %>
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             &nbsp;&nbsp;
        <%out.println("<b>"+"Year :- "+"</b>"+year);
         %>         
        </h3>
          <% out.print("__________________________________________________________________________________________________________________________________________________");%>
          <br>
          <br>
        <center>
             <table border="2" class="table">
            <thead>
            
            <th>Sr.no</th> 
            <th>Roll_No</th>
            <th>Name</th>
            
            <th colspan="<%=ad.getMax_reg_courses()%>">Course Code</th>
          
            
            </thead>
            <%
                    int j=1;
                     for(int i=0;i<list.size();i++)
                    {
                    Query query = s.createQuery("SELECT course_code FROM Course_reg WHERE regno =:rollno and year =:year and reg_term_year=:reg_term_year and reg_exmt='n' and reg_can='n'");
                    query.setInteger("year", year);
                    query.setString("reg_term_year", ad.getReg_term_year());
                    query.setString("rollno",(String)list.get(i));
                    //query.list() will give all course code that are registered of that roll number.
                    list1=query.list();
                    Query query1 = s.createQuery("SELECT s_name FROM Student_data WHERE rollno =:rollno and year =:year");
                    query1.setInteger("year", year);
                    query1.setString("rollno",(String)list.get(i));
                    list2=query1.list();
            %>
                
                <tr> 
                
                <td><%= j++%></td>
               
                <td><%=list.get(i)%></td>
                <td><%=list2.get(0)%></td>
                <%for( int j1=0;j1<list1.size();j1++)
                {
                %>
                
                  <td><%=list1.get(j1)%></td> 
                
                <%}%>
   
                </tr> 
             
                <%}%>

         </table> 
                <div class="row">                         
                       <form method="post">  
                           <div class="col-sm-2">      
                                <input type="button" id="printBtn" value="Print" onClick="printpage()" class="btn btn-lg btn-primary pull-left"> 
                           </div> 
                           
                       </form> 
                </div> 
    <%}
    
   

    else
    {
        response.sendRedirect("../views/Admin/courseRegReport.jsp?failResult=Records not found.");
    }}
    %>
    </center>
            
   <script type="text/javascript">
        function printpage() 
        {
            var btn=document.getElementById('printBtn'); 
            btn.style.visibility='hidden';
            
            window.print();   
            btn.style.visibility='visible';
            btn1.style.visibility='visible';
        } 
    </script>
      
        
        
    
</html>
