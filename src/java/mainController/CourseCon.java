/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mainController;

import SessionFact.SessionFact;
import beans.Courses;
import beans.Hod_data;
import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author sarvadnya
 */
public class CourseCon {
    static Session session;
    static SessionFactory sf;
    public static int register(Courses c) 
    {
        int i=0;
        //Session session=new Configuration().configure().buildSessionFactory().openSession();
        c.setIs_validated("n"); 
        sf=SessionFact.getSessionFact();
        session=sf.openSession();
        session.beginTransaction();
        i=(Integer)session.save(c); 
        System.out.print(c.getTotal_Marks()+">>>>>>\n\n\n\n\n\n\n\n\n\n\n\n");
        session.getTransaction().commit();
        session.close();
        return i;
    } 
    
    public static List getCourses(String year,String uname,String term)
    {
            String hql,hql1,br=null;
            Query qr,qr1;
            Hod_data hod = null;
            sf=SessionFact.getSessionFact();
            session=sf.openSession();
            List li1=session.createQuery("from Hod_data where username=:uname1").setString("uname1",uname).list();
            if(li1.size()==1 && li1!=null) 
            hod=(Hod_data)li1.get(0);
            br=hod.getProgramme();
            List li = session.createQuery("from Courses where is_validated=:yes and is_offered=:no and programme=:programme and term=:t and year=:y").setString("yes","y").setString("no","n").setString("programme",br).setString("t",term).setString("y",year).list();
           return li;
    }
   public static List saveOfferCourses(String course1)
    {
            sf=SessionFact.getSessionFact();
            session=sf.openSession();  
            List l=new ArrayList();
            List li=session.createQuery("from Courses where course_code=:courseCode").setString("courseCode",course1).list();
            Courses c=(Courses)li.get(0);                        
            c.setIs_offered("y");
            System.out.println(c.getIs_offered());
            session.beginTransaction();
            session.merge(c);
            session.getTransaction().commit();
            session.close();
            l.add(c);
            //sf.close();
            return l;
    }
    
    //getCourseName() is used to retrieve the name of course,whose code is passed as parameter to it.
    public static String getCourseName(String courseCode)
    {
        
        System.out.print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!Cou_code ="+courseCode);
        List li;
        sf=SessionFact.getSessionFact();
        session=sf.openSession();        
        li=session.createQuery("select course_name from Courses where course_code=:coursecode").setString("coursecode", courseCode.trim()).list();
        
        session.close();
        //sf.close();
        
        if(li.size()!=0)
             return (String)li.get(0);
        else
            return null;
    }
    //to return the object of course by course code
    public static Courses getCourseObject(String courseCode)
    {
        
        Courses c=null;
        System.out.print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!Cou_code ="+courseCode);
        List li;
        try{
        sf=SessionFact.getSessionFact();
        session=sf.openSession();        
        li=session.createQuery("from Courses where course_code=:coursecode").setString("coursecode", courseCode.trim()).list();
        
        session.close();
        //sf.close();
        
        
        if(li.size()!=0)
        {
            c=(Courses)li.get(0);
            //return c;
        }
        }catch(Exception e){ System.out.print("!!!!!!!!!!!!!!!!!!!!! getCourseObject exception!!!!!!!!!!!!!!!!!!!!!!!!! ="+e);}
        //else
            return c;
        
    }
    public static Courses getCourseObjectByName(String courseName)
    {
        Courses c;
        System.out.print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!Cou_code ="+courseName);
        List li;
        sf=SessionFact.getSessionFact();
        session=sf.openSession();        
        li=session.createQuery("from Courses where course_name=:courseName").setString("courseName", courseName.trim()).list();
        
        session.close();
        //sf.close();
        
        if(li.size()!=0)
        {
            c=(Courses)li.get(0);
            return c;
        }
        else
            return null;
    }
    public static List getAllProgrammes()
    {
        sf=SessionFact.getSessionFact();
        session=sf.openSession();   
        List li=session.createQuery("select programme from Courses group by programme").list();
        session.close();
        //sf.close();
        return li;
    }
    public static int deleteCourse(String couCode)
    {
        Courses c=null;
        Query qr;
        int i=0;
        c=CourseCon.getCourseObject(couCode);
        sf=SessionFact.getSessionFact();
        session=sf.openSession();
        
        if(c!=null)
        {
            session.beginTransaction();
            qr=session.createQuery("delete FROM Courses WHERE course_code =:couCode").setString("couCode",couCode);
            i=qr.executeUpdate();
            session.getTransaction().commit();
            session.close();
            //sf.close();       
            return i;
        }
        else
        {
            session.close();
            //sf.close(); 
            return -1;
        }
        
     }
    
    public static int getDepartment(String programme)
    {
        int dept=0;
        switch(programme)
        {
            case "CE":dept=11;break;
            case "ME":dept=21;break;
            case "PS":dept=31;break;
            case "EE":dept=41;break;
            case "IF":dept=51;break;
            case "CM":dept=61;break;
            case "EL":dept=71;break;
            case "AE":dept=81;break;
            case "DDGM":dept=91;break;
            case "IDD":dept=01;break;
        }
        return dept;
    }
}
