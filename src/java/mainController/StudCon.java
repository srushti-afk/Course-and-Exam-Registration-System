package mainController;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



import SessionFact.SessionFact;
import beans.Admin_data;
import beans.Course_reg;
import beans.Courses;
import beans.Exam_reg;
import beans.Hod_data;
import beans.Student_data;
import static java.lang.System.out;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.ListIterator;
import static mainController.HodCon.sf;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author sarvadnya
 */

public class StudCon {
    static Session session;
    static SessionFactory sf;
    static Student_data stud;
    
    public static Boolean login(String uname,String pword) 
    {
            Boolean bool=false; 
            sf=SessionFact.getSessionFact();              //sessionFactory creation
            Session session1=sf.openSession();
            System.out.println("login check student started");
            Query qr=session1.createQuery("from Student_data"); 
            if(qr!=null)
            {
                List li=qr.list();
                if( li != null)
                {
                   for(Object obj:li) 
                   {
                        Student_data stud=(Student_data)obj;
                        if(uname.equals(stud.getUsername())&&pword.equals(stud.getPassword()))
                        {
                           bool=true;
                           break;                            
                        } 
                    }   //for close  
                }   //inner if close    
            }    //outer if closed
            System.out.println("login check student performed");
            session1.close();
            //sf.close(); 
            return bool;
    }
    
    //used to register a new student 
    public static int register(Student_data sd)
    {
        int i=0;
        //Session session=new Configuration().configure().buildSessionFactory().openSession();
        sf=SessionFact.getSessionFact();
        session=sf.openSession();
        session.beginTransaction();
        i=(Integer)session.save(sd);
        session.getTransaction().commit();
        session.close();
        return i;
    }  
    
    //studRegCourse() method is for showing the student available courses for him according
    //to his programme, term and year
  public static List studRegCourse(String uname,String term,int year)  
  {
            Session s;
            Student_data stud=new Student_data();
            Query qr;
            SessionFactory sf;
            sf=SessionFact.getSessionFact();
            s=sf.openSession();
            qr=s.createQuery("from Student_data where username =:uname").setString("uname",uname);
            List li=qr.list();
            if(li.size()==1 && li!=null) 
                stud=(Student_data)li.get(0);
            String programme=stud.getProgramme();
            System.out.println("----------------------------------------"+stud.getProgramme());
            //String t,y;
            System.out.print(term);
            System.out.print(year);
            li=s.createQuery("from Courses where is_offered=:yes and programme =:programme and term=:t and year=:y").setString("programme",stud.getProgramme()).setString("t",term).setInteger("y",year).setString("yes","y").list();  
            s.close();
            //sf.close();
            return li; 
  }
  
  //This method is for retrieving the courses which are registered by student. 
  public static List getRegCourse(String uname,String term,int year)
  {
      Session session;
      SessionFactory sf=SessionFact.getSessionFact(); 
      session=sf.openSession();
      System.out.println("____________________________StudCon.getRegCourse() Retrieving all registered courses by student.");                                   
      System.out.print("_______________________________"+year);
      List list=null;       
      list=session.createQuery("from Course_reg where regno=:regno and reg_term=:term and year=:year").setString("regno", uname).setString("term", term).setInteger("year",year).list();
      //System.out.println("----------------------------------------------------------------------------------------------------------Exception e = "+e);
      session.close();
      //sf.close();
      return list;
  }
  
  //This method is for retrieving the courses which are registered for examination by student. 
  //ex_reg_date is checked in query.
  public static List getExRegCourse(String uname,String term,int year)
  {
      Session session;
      SessionFactory sf=SessionFact.getSessionFact(); 
      session=sf.openSession();
      List list=null;       
      System.out.print("^^INside getExRegCourse() method");
      list=session.createQuery("from Exam_reg where regno=:regno and ex_reg_term=:term and ex_reg_year=:year and ex_reg_date=:ex_reg_date").setString("regno", uname).setString("term", term).setInteger("year",year).setString("ex_reg_date", AdminCon.getReg_term_year()).list();
      session.close();
      //sf.close();
      return list;
  }
  
  //getBackCourse() method returns  backlog courses
  public static List getBackCourse(String uname)
  {
      Session session;
      SessionFactory sf=SessionFact.getSessionFact();
      session=sf.openSession();
      //System.out.println("000000000000000000000000000000000000000000000000000000000000000000000000000000Reached for displaying all registered courses by student\n\nAnd rollno = "+uname);
      List list=null; 
      Admin_data admin=AdminCon.getAdminInfo();
      list=session.createQuery("from Course_reg where regno=:regno and fail=:y and reg_term_year!=:term_year").setString("regno", uname).setString("y","y").setString("term_year", admin.getReg_term_year()).list();
      //System.out.println("----------------------------------------------------------------------------------------------------------Exception e = "+e);
      session.close();
      //sf.close();
      return list;
  }
  
   //getPendingCourse() method returns All offered courses
  public static List getPendingCourse(String uname)
  {
      Session session;
      Query qr;
      SessionFactory sf=SessionFact.getSessionFact();
      session=sf.openSession();
       qr=session.createQuery("from Student_data where username = "+uname);
            List li=qr.list();
            if(li.size()==1 && li!=null) 
                stud=(Student_data)li.get(0);
            String programme=stud.getProgramme();
     // System.out.println("000000000000000000000000000000000000000000000000000000000000000000000000000000Reached for displaying all registered courses by student\n\nAnd rollno = "+uname);
      List list=null; 
      list=session.createQuery("from Courses where programme=:programme and is_offered=:y").setString("programme",programme).setString("y","y").list();
      //System.out.println("----------------------------------------------------------------------------------------------------------Exception e = "+e);
      session.close();
      //sf.close();
      return list;
  }
  //confirmCourse changes reg_can from 'y' to 'n'
  public static void confirmCourse(Course_reg cr)
  {
        Boolean bool=false;
        sf=SessionFact.getSessionFact(); 
        session=sf.openSession();
        session.beginTransaction();
        cr.setReg_can("nd");
        
        session.merge(cr);  
        session.getTransaction().commit();
       
   
  }
     
//regCourse() this method is for registering the courses selected by student in courseReg table
  public static int[] regCourse(String[] course,String uname,String saveOrReg,String date,String term,String year,String user) 
  {
      List list=new ArrayList();
      String hql,cou_code;
      Session s;
      Query qr,qr1;
      SessionFactory sf;
      Course_reg cr=new Course_reg();
      sf=SessionFact.getSessionFact();
      Student_data stud=new Student_data();
      Admin_data ad=new Admin_data();
      int res[]=new int[course.length];
      Boolean flag=false;
      List<String> li5=new ArrayList<String>(),li1=new ArrayList<String>(),li2=new ArrayList<String>(),li3=new ArrayList<String>(),li4=new ArrayList<String>();
      
      try{
        //Retrieving registered courses by student.
        
        List li=getRegCourse(uname,term,(new Integer(year)));   
        //li1 is a list which holds the course_code of all registered courses.
       
        for(Object obj:li)
        {
            Course_reg creg=(Course_reg)obj;
            li1.add((creg.getCourse_code()));
        }

        //li2 is the list of all newly selected courses.
        li5=Arrays.asList(course);  //copies array course into a list li2.
        li2.addAll(li5);

        s=sf.openSession();
        System.out.println("__________________________________Now in StudCon.regCourse()");
        int j=0;
        try{
        list=s.createQuery("from Student_data where username=:username").setString("username",uname).list();
        }
        catch(Exception e){System.out.print("Sorry");}
        s.close();
        //sf.close();
        
        /*sf=SessionFact.getSessionFact();
        s=sf.openSession();
        System.out.println("____________________________________OLD COURSES ARE GETTING DELETED");
        delOldCourses(name);    //firstly all old courses are deleted
        s.close();
        //sf.close();*/ 
        
        //Getting student programme for writing it into coursereg table.
        if(list.size()==1) 
              stud=(Student_data)list.get(0);
                
        li3.addAll(li1);//li1 is the list for all registered courses.
        li4.addAll(li1);
        li4.retainAll(li2);//retainAll() returns the common elements from both lists and all common elements are placed into calling list.
        li1.removeAll(li2);
        li2.removeAll(li3); 
        System.out.print("________________________Courses to be deleted = "+li1);
        System.out.print("________________________Courses to be newly added = "+li2);
        System.out.print("________________________Courses that are common in previous and current one to be updated = "+li4);
        try{for(String str:li1)
        {
            System.out.println("*******************delete************************"+str);
        }}catch(Exception e){ System.out.println("*******************************************li1 is empty"+e);}
        try{for(String str:li2)
        {
            System.out.println("**********************add*********************"+str);
        }}catch(Exception e){ System.out.println("*******************************************li2 is empty"+e);}
        try{for(String str:li4)
        {
            System.out.println("************************update*******************"+str);
        }}catch(Exception e){ System.out.println("*******************************************li4 is empty"+e);}
        //Now li1 has its unique members which is to be deleted.
        //Now li2 has its unique members which is to be newly added.
        //li4 has common members in original li1 and li2 which is to be updated.
         
        //deleting old courses using list li1.
        try{
            if(!li1.isEmpty())
            {
                System.out.println("_____________________________________________________Calling delOldCourses() to delete old courses");
                delOldCourses(uname,li1,term,year);
            }
        }catch(Exception e){ System.out.println("***********************li1 is empty(deletion list)********************"+e);}
            //updating old courses using list li4
            try{
            if(!li4.isEmpty())
            {
                if(user.equals("student"))
                    updateOldCourses(uname,li4,"y");
                else if(user.equals("registrar")) 
                    updateOldCourses(uname,li4,"n");
            } 
            }catch(Exception e){ System.out.println("***********************li4 is empty(updation list)********************"+e);}
            //adding new courses using list li2 
            System.out.print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++Size of list to be added = "+li2.size());
            try{
            if(!li2.isEmpty())
            {
               ad=AdminCon.getAdminInfo();
                for(String coucode:li2) 
                {      
                    try
                    { 
                        System.out.println("course[] = "+coucode);
                        //reading the programme of student
                        cr.setCourse_code(coucode);
                        cr.setRegno(uname);
                        cr.setProgram(stud.getProgramme());
                        cr.setReg_date(date);
                        cr.setReg_term(term);
                        int year1=Integer.parseInt(year);
                        cr.setYear(year1);
                        cr.setReg_exmt("n"); 
                        cr.setReg_term_year(ad.getReg_term_year()); 
                        cr.setShift(stud.getShift()); 
                        //checking if save is clicked or register, and setting the reg_cancel field accordingly.
                        System.out.print("____________________________________________________course  reg_can is "+saveOrReg);
                        if(saveOrReg.equals("save"))
                        {   
                            cr.setReg_can("y");
                            cr.setFail("n");
                            cr.setPass("n");
                        }
                        else if(saveOrReg.equals("register")) 
                        {
                            cr.setReg_can("n");
                            cr.setFail("n");
                            cr.setPass("n");
                        }
                        System.out.print("_______________________Going to register_____"+cr.getCourse_code()+"________"+cr.getRegno()+"______"+cr.getProgram()+"_______"+cr.getId()+"________"+cr.getReg_can());
                        //calling method for storing courses of a student.
                        int result=CourseRegCon.Cou_register(cr);                            
                        res[j]=result;   //putting the result in result array.
                    } 
                    catch(Exception e) 
                    {
                        out.println("______________________________________________________Failed\n\n\n\n"+e);
                    }
                }//for close
            }//if close
            }catch(Exception e){ System.out.println("***********************li2 is empty(addition list)********************"+e);}
      }catch(Exception e)
      {
          out.println("***********************************************Exception "+e+" occured.");
      }
      return res;
  }//method regCourse() closed
  
  //regExam() this method is for registering the courses selected by student in examreg table
  public static int[] regExam(String[] course,String uname,String date,String term,int year,String saveOrReg) 
  {
        int res[]=new int[course.length];
        List list=new ArrayList();
        List li=null;
        Courses cr;
        Session s;
        Query qr,qr1,qr2 = null;
        SessionFactory sf;
        Exam_reg er=new Exam_reg();
        Course_reg creg=new Course_reg();
        sf=SessionFact.getSessionFact();
        Student_data stud=new Student_data();
        s=sf.openSession();

       System.out.println("$$######################################################Reached to regExam method...");
        int j=0;
        list=s.createQuery("from Student_data where username=:username").setString("username",uname).list();
        if(saveOrReg.equals("registrar"))
        {
        s.beginTransaction();
        qr2=s.createQuery("delete Exam_reg where regno=:regno and ex_reg_term=:term and ex_reg_year=:y1 and ex_cancel=1").setString("regno", uname).setString("term",term).setInteger("y1",year);
        qr2.executeUpdate();
         s.getTransaction().commit();
        }
        //Getting student programme for writing it into coursereg table.
        if(list!=null && list.size()==1)
              stud=(Student_data)list.get(0);
        for(int i=0;i<course.length;i++)
        {   
            cr=CourseCon.getCourseObject(course[i]);//to get course object 
            try
            { 
              /* try{ 
                   if(cr.getIs_exempted().equals("Ex"))
                    {
                      li=s.createQuery("from Course_reg where regno=:regno and reg_term=:term and year=:year and cou_code=:coucode").setString("regno", uname).setString("term", term).setInteger("year",year).setString("coucode", cr.getCourse_code()).list();
                      creg=(Course_reg)li.get(0);
                       if(creg.getReg_exmt().equals("y"))er.setEx_exmt(1);else er.setEx_exmt(0);
                    }
                  }catch(Exception e){}*/
                er.setCourse_code(course[i]);
                er.setRegno(uname);
                er.setProg(stud.getProgramme()); 
                er.setEx_reg_date(date);
                er.setEx_reg_term(term);
                er.setEx_reg_year(year);
                if(cr.getCou_th_min()>0)er.setEx_th(1); else er.setEx_th(0);
                if(cr.getCou_pt_min()>0)er.setEx_pt(1); else er.setEx_pt(0);
                if(cr.getCou_pr_min()>0)er.setEx_pr(1); else er.setEx_pr(0);
                if(cr.getCou_tw_min()>0)er.setEx_tw(1); else er.setEx_tw(0);
                if(cr.getCou_or_min()>0)er.setEx_or(1); else er.setEx_or(0);
                er.setShift(stud.getShift()); 
                //checking if save is clicked or register, and setting the Ex_cancel field accordingly.
                if(saveOrReg.equals("student"))
                {   //Exam registration by student
                    er.setEx_cancel(1);
                }
                else
                {   //Exam registration by registrar
                    er.setEx_cancel(0);
                }
                //calling method for storing courses of a student for exam registration.
                int result=ExamRegCon.exRegister(er);                            
                res[i]=result;   //putting the result in result array.
            } 
            catch(Exception e)
            {
                out.println("______________________________________________________Failed"+e);
            }
        }
        
        s.close();
        //sf.close();
      return res;
  }//method regCourse() closed
   private static Boolean updateOldCourses(String uname,List list,String reg_can)
  {
      System.out.println("*****************************************************************************************************");
      for(Object o:list)
      {
          System.out.println("\n^^^^^^^^^^      ^^^^^^^^^^^^       ^^^^^^^^^^^^^^"+String.valueOf(o));
      }
      Session session;
      SessionFactory sf=SessionFact.getSessionFact();
      session=sf.openSession();
      session.beginTransaction();
      for(Object str:list)
      {
            System.out.print("______________________________________________Updation of course "+str+" is started.");
            List li=session.createQuery("from Course_reg where regno= :regNo and course_code= :course_code").setString("regNo", uname).setString("course_code",String.valueOf(str)).list();
            
            Course_reg cr=(Course_reg)li.get(0);
            System.out.print("____________Student tuple for course-reg = "+cr.getCourse_code()+"    "+cr.getReg_can());
            if(cr.getReg_exmt().trim().equals("y"))   //If course is 
            {              
                      cr.setFail("n");
                      cr.setPass("n");
                      cr.setReg_can(reg_can);
                      cr.setReg_exmt("n");
            }
            else
                cr.setReg_can(reg_can);
            Object o=session.merge(cr);
            System.out.print("After updation "+((Course_reg)o).getReg_can());
            
            //Query qr=session.createQuery("update Course_reg set reg_can = :regCan"+" where regno= :regNo and cou_code=:course_code")/*.setString("regno", uname)*/;
            /*qr.setParameter("regCan", reg_can);
            qr.setParameter("regNo",uname );
            qr.setParameter("course_code",str ); */ 
            
            //System.out.print("____________________Updation RESULT = "+qr.executeUpdate()+" for course "+str+" reg_can = "+reg_can); 
      }
      System.out.println(".........................................EXITING UPDATE OLD COURSE......................");
      session.getTransaction().commit();
      session.close();
      //sf.close();
      return true;
  }
 //delOldCourse() method is used for deleting older courses for a student from course_reg.
  private static Boolean delOldCourses(String uname,List<String> list,String term,String year)
  {
      Boolean flag=false;
      Session session;
      SessionFactory sf=SessionFact.getSessionFact();
      session=sf.openSession();
      session.beginTransaction();
      System.out.print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Now in StudCon.delOldCourses() to delete previous but currently unselected courses by student.");
      for(String str:list) 
      { 
            Query qr=session.createQuery("delete Course_reg where regno=:regno and course_code=:course_code and reg_term=:term and year=:y1").setString("regno", uname).setString("term",term).setString("y1",year);
            qr.setParameter("course_code",str); 
            qr.executeUpdate();
            
      }
      session.getTransaction().commit();
      session.close();
      //sf.close();
      return flag;
  }
  
  public static Boolean changeStudPwd(String uname,String oldPwd,String newPwd)
    {
            SessionFactory sf=SessionFact.getSessionFact();
            session=sf.openSession(); 
            session.beginTransaction();
            List list=session.createQuery("from Student_data where username=:username").setString("username",uname).list();
            Student_data sd=(Student_data)list.get(0);
            
              /*ListIterator listIter=list.listIterator();
            while(listIter.hasNext()) 
            {
                Student_data sd=(Student_data)listIter.next();
                if(sd.getUsername().equals(uname) && sd.getPassword().equals(oldPwd))
                {*/
                    sd.setPassword(newPwd);
                    session.merge(sd);
                    System.out.println("Password updation done successfully in stu account");
                    session.getTransaction().commit();
                    
                   
              /*  }
            } */
            return true;
    }
  
  
  //to fetch old details of student & display them in form
  public static List editStudProfile(String uname)
  {
      List li =new ArrayList();
      List li1 =new ArrayList();
      Session s;
      SessionFactory sf;
      Query qr;
      Student_data sd = new Student_data();
      sf=SessionFact.getSessionFact();
      s=sf.openSession();
      qr=s.createQuery("from Student_data");
      if(qr!=null)
      {
       
          li = qr.list();
          if(li!=null)
          {
              ListIterator lit=li.listIterator();
              while(lit.hasNext())
              {
                  sd=(Student_data) lit.next();
                  if(uname.equals(sd.getUsername()))
                  {
                      li1.add(sd);
                      break;
                  }//end if 
              }//while
          }//inner if
      
      }//outer if
      
    
      return li1;
    }//end of method
  
  
 //to save modified details of a student  
  public static int saveStudentProfile(Student_data sd,String uname)
  {
        int i=0;
        sf=SessionFact.getSessionFact(); 
        session=sf.openSession();
        session.beginTransaction();
        List list=session.createQuery("from Student_data where username=:username").setString("username",uname).list();
        Student_data sd1=(Student_data)list.get(0);
        sd1.setPhone_no(sd.getPhone_no());
        sd1.setS_email(sd.getS_email()); 
        session.merge(sd1);
        i=1;
        session.getTransaction().commit();
        return i;
  }
  //to get individual student information by username
  public static Object getStudentInfo(String uname)
  { 
      out.println("..................getStudentInfo..............."+uname+".................................");
      sf=SessionFact.getSessionFact();
      session=sf.openSession();
      List li=session.createQuery("from Student_data where rollno=:roll_no").setString("roll_no", uname).list();
      for(Object ob:li)
      {
          System.out.println("000000000000000000000000000000000000000"+ob);
      }
      session.close();
      //sf.close();
      if(li.size()!=0) 
        return li.get(0);
      else
          return null;
  }
  
  //Check exam registration status of student
    static public Boolean getExRegStatus(String rollno,String term_year,int year)
    {
        int result=0;
        sf=SessionFact.getSessionFact();
        session=sf.openSession();
        List li=session.createQuery("from Exam_reg where regno=:reg_no and ex_reg_date=:term_year and ex_reg_year=:year").setInteger("year", year).setString("reg_no", rollno).setString("term_year", term_year).list();
        if(li.size()>0) 
        {
            for(Object o:li)
            {
                Exam_reg examreg=(Exam_reg)o;
                if(examreg.getEx_cancel()==0)
                    result++;
            }
        }
        if(result==li.size() && result>0) 
            return true;
        else
            return false;
    }
    
  //returns the examination registration status of student
  /*public static boolean getExamRegStatus(String uname,String term,int year)
  { 
      int result=0; 
      sf=SessionFact.getSessionFact();
      session=sf.openSession();
      List li=session.createQuery("from Exam_reg where regno=:regno and ex_reg_term=:term and ex_reg_year=:y1").setString("regno", uname).setString("term",term).setInteger("y1",year).list();
      session.close();
      //sf.close();
      if(li.size()>0)
        {
            for(Object o:li)
            {
                Exam_reg examreg=(Exam_reg)o;
                if(examreg.getEx_cancel()==0)
                    result++;
            }
        }
        if(result==li.size() && result>0) 
            return true;
        else
            return false;
  }*/
  public static void regDsyFirstYearCourses(String uname,String programme,String term)
  {  
      try
      {
      System.out.print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>reached to getDsyFirstYearCourse");
      Admin_data ad=AdminCon.getAdminInfo();
      Student_data sd=(Student_data)StudCon.getStudentInfo(uname);
      sf=SessionFact.getSessionFact();
      session=sf.openSession();
      session.beginTransaction();
      List li1=session.createQuery("from Courses where programme=:programme and year=1 and term=:term").setString("programme", programme).setString("term", term).list();   
      out.print("++++++++++++++++++++++++++++++++++++++++++++++++getDsyFirstYearCourse+++++++++++++++++++++++++++++++++++++++++++"+li1.size());
      SimpleDateFormat f=new SimpleDateFormat("dd/MM/yyyy");
      String date=f.format(new Date());
      Courses c;
      Course_reg cr;
     
      for(Object obj:li1) 
        {
            try
            {
          c=(Courses)obj;
           cr=new Course_reg();
           out.print("+___________________________++++++++getDsyFirstYearCourse______________________________________"+c.getCourse_code());
            cr.setCourse_code(c.getCourse_code());               
            cr.setFail("n");
            cr.setPass("y");
            cr.setProgram(programme);
            cr.setReg_date(date);
            cr.setReg_can("n");
            cr.setReg_exmt("y");
            cr.setRegno(uname);
            cr.setYear(1);
            cr.setReg_term(term); 
            cr.setReg_term_year(ad.getReg_term_year());
            cr.setShift(sd.getShift());
            session.save(cr);
             out.print("___________________________saved course code_____________________________________"+c.getCourse_code());
            }
            catch(Exception e){out.print("+_________________________exception : __________________________________"+e);}
        }  
      session.getTransaction().commit();
      
      }
      catch(Exception e){} 
      session.close();
      //sf.close();
  }
  
  public static int getStudTerm(String term,int year)
  {
      if(term.equals("ODD") && year==1)
      {
          return 1;
      }
      else if(term.equals("EVEN") && year==1)
      {
          return 2;
      }
      else if(term.equals("ODD") && year==2)
      {
          return 3;
      }
      else if(term.equals("EVEN") && year==2)
      {
          return 4;
      } 
      else if(term.equals("ODD") && year==3)
      {
          return 5;
      } 
      else if(term.equals("EVEN") && year==3)
      {
          return 6;
      } 
      else
      return 0;
  }
  
  public static int registerStudent(Student_data stud)
  {
      int i=0;
        sf=SessionFact.getSessionFact(); 
        session=sf.openSession();
        session.beginTransaction();
       
        stud.setPassword(stud.getRollno());
        session.merge(stud);
        i=1;
        session.getTransaction().commit();
        return i;
  }
  
  
}//class closed