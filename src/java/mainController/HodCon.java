/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mainController;

import SessionFact.SessionFact;
import beans.Admin_data;
import beans.Course_reg;
import beans.Exam_reg;
import beans.Hod_data;
import beans.Student_data;
import java.util.List;
import java.util.ListIterator;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author sarvadnya
 */
public class HodCon {
    static Session session;
    static SessionFactory sf;
    static Query qr;
    public static Boolean hodLogin(String uname,String pword) 
    {
            sf=SessionFact.getSessionFact();              //sessionFactory creation
            session=sf.openSession();
            System.out.println("login check hod started");
            List li=session.createQuery("from Hod_data where username=:uname and password=:pword and user='hod'").setString("uname",uname).setString("pword", pword).list(); 
            System.out.println("login check hod performed");
            session.close();
            //sf.close(); 
            if(li.size()!=0)
            return true;
            else
            return false;
    }
    
    //for registering registrar.
    public static int addRegistrar(Hod_data hd) 
    {
        int i=0;
        //Session session=new Configuration().configure().buildSessionFactory().openSession();
        sf=SessionFact.getSessionFact();
        session=sf.openSession();
        session.beginTransaction();
        hd.setIs_reg_started("n"); 
        i=(Integer)session.save(hd);
        session.getTransaction().commit();
        session.close();
        return i;
    }
    
    //for registering Hod.
    public static int registerHOD(Hod_data hd) 
    {
        int i=0;
        //Session session=new Configuration().configure().buildSessionFactory().openSession();
        sf=SessionFact.getSessionFact();
        session=sf.openSession();
        session.beginTransaction();
        hd.setUser("hod");
        hd.setIs_reg_started("n"); 
        i=(Integer)session.save(hd);
        session.getTransaction().commit();
        session.close();
        return i;
    }
    //method for registrar Login.s
    public static int registrarLogin(String uname,String pword)
    {
        int i=0;
            sf=SessionFact.getSessionFact();              //sessionFactory creation
            session=sf.openSession();
            System.out.println("login check hod started");
            List li=session.createQuery("from Hod_data where username=:uname and password=:pword and user=:registrar").setString("uname",uname).setString("pword", pword).setString("registrar","registrar").list(); 
            System.out.println("login check hod performed");
            session.close();
            //sf.close(); 
            if(li.size()!=0)
            {
                i=1;
                return i;
            }
            else
            return i;
    }
    
    public static Boolean changeStudPwd(String rollno,String newPwd,String Programme,int shift)
    {
            Boolean bool=false; 
            sf=SessionFact.getSessionFact();              //sessionFactory creation
            session=sf.openSession();
            session.beginTransaction();
            List li=session.createQuery("from Student_data where rollno=:rollno").setString("rollno",rollno).list();
            if(li.size()!=0)
            {
                Student_data sd=(Student_data)li.get(0);
                if(sd.getProgramme().equals(Programme) && sd.getShift()==shift)
                {
                sd.setPassword(newPwd);
                session.merge(sd);
                bool=true;
                }
            }
            else
            {
            bool=false;
            }
            session.getTransaction().commit();
            session.close();
            //sf.close();
            return bool;
    }        
    public static Boolean changeHodPwd(String oldPwd,String newPwd)
    {
            Boolean bool=false; 
            SessionFactory sf=SessionFact.getSessionFact();
            session=sf.openSession(); 
            session.beginTransaction();
            List list=session.createQuery("from Hod_data where password=:oldPwd and user=:hod").setString("oldPwd", oldPwd.trim()).setString("hod","hod").list();
            try{
            Hod_data hd=(Hod_data)list.get(0);
            hd.setPassword(newPwd);
            session.merge(hd);
            bool=true;
            // System.out.println("Password updation done successfully in stu account");
            }catch(Exception e){System.out.println("------"+e);bool=false;}
            session.getTransaction().commit();
            session.close();
            //sf.close();
            return bool;
    }        
    //change Hod password by Admin
    public static String changeHodPwdByAdmin(String newHodPwd,String programme,int shift,String user)
    {
             String result=null;
            SessionFactory sf=SessionFact.getSessionFact();
            session=sf.openSession(); 
            session.beginTransaction();
            List list=session.createQuery("from Hod_data where programme=:programme and shift=:shift and user=:hod").setString("programme",programme).setInteger("shift", shift) .setString("hod","hod").list();
            try{
            if(list.size()!=0)
            {
                Hod_data hd=(Hod_data)list.get(0);
                hd.setPassword(newHodPwd);// use to insert data
                Hod_data hd2=(Hod_data)session.merge(hd); // use to check whether data is changed successfully or not
                if(hd2.getPassword().equals(newHodPwd))
                    result="success";
                else
                    result="fail";
            }
            else
                result="hodUnavailable";
            // System.out.println("Password updation done successfully in stu account");
            }catch(Exception e){System.out.println("------in changeHodPwdByAdmin "+e);}
            session.getTransaction().commit();
            session.close();
            //sf.close();
            return result;
    }        
    
    public static Boolean changeRegistrarPwd(String registrar_pwd,String uname)
    {
            Boolean bool=false; 
            String programme=null;
            sf=SessionFact.getSessionFact();
            session=sf.openSession(); 
            session.beginTransaction();
            List li=session.createQuery("from Hod_data where username=:uname and user=:hod").setString("uname", uname).setString("hod","hod").list();
            if(li.size()!=0)
            {
                Hod_data hd=(Hod_data)li.get(0);
                programme=hd.getProgramme();
                List li1=session.createQuery("from Hod_data where programme=:programme and user=:user").setString("programme",programme).setString("user","registrar").list();
                if(li1.size()!=0)
                {
                    Hod_data hd1=(Hod_data)li1.get(0);
                    hd1.setPassword(registrar_pwd);
                    session.merge(hd1);
                    bool=true;
                    session.getTransaction().commit();
                }
            }
            
            session.close();
            //sf.close();
            return bool;
    }
    
    public static String getRegistrarBranch(String uname)
    {
        sf=SessionFact.getSessionFact();
        session=sf.openSession();
        qr=session.createQuery("select programme from Hod_data where username=:uname and user=:user");
        qr.setString("uname", uname);
        qr.setString("user","registrar");
        List li=qr.list();
        session.close();
        //sf.close();
        System.out.print("+++++++++++++++++++++++++++++++++Registrar programme = "+(String)li.get(0));
        return (String)li.get(0); 
    }
    
    //getStudForReg() is used by registrar for retrieving students of particular year and term for registration.
    public static List getStudForReg(String program,int year,String term,int shift)
    { 
        List li=null;
        
        sf=SessionFact.getSessionFact();
        session=sf.openSession();
        Query qr=session.createQuery("from Student_data where year=:year and term=:term and programme=:program and shift=:shift");
        qr.setInteger("year", year);
        qr.setString("term",term);
        qr.setString("program",program);
        qr.setInteger("shift", shift);
        li=qr.list();
        
        /*System.out.print("Students = ");
        for(Object o:li)
        {
            System.out.print("     "+((Student_data)o).getUsername());
        }*/
        session.close();
        //sf.close();
        
        return li;
    }
    
    //Check course registration status of student
    static public Boolean checkRegStatus(String rollno,int year,String term)
    {
        int result=0;
        sf=SessionFact.getSessionFact();
        session=sf.openSession();
        List li=session.createQuery("from Course_reg where regno=:reg_no and year=:year and reg_term=:term").setString("reg_no", rollno).setInteger("year", year).setString("term", term).list();
        if(li.size()>0) 
        {
            for(Object o:li)
            {
                Course_reg coursereg=(Course_reg)o;
                if(coursereg.getReg_can().equals("n")||coursereg.getReg_can().equals("Ex")) 
                    result++;
            }
        }
        if(result==li.size() && result>0) 
            return true;
        else
            return false;
    }
    
    
    public static Hod_data startReg(String uname) 
    {
    
        Boolean bool=false;
        sf=SessionFact.getSessionFact(); 
        session=sf.openSession();
         List li=session.createQuery("from Hod_data where username=:uname").setString("uname", uname).list();
         Hod_data hd=(Hod_data)li.get(0);
        session.beginTransaction();
            hd.setIs_reg_started("y"); 
        hd=(Hod_data)session.merge(hd);  
        session.getTransaction().commit();
        session.close();
        //sf.close();
       return hd;
  } 
   /* //this method returns HOD registration status for HOD
    public static boolean getRegStatus(String uname)
    {  
        sf=SessionFact.getSessionFact(); 
        session=sf.openSession();
         List li=session.createQuery("from Hod_data where username=:uname").setString("uname",uname).list();
         Hod_data hd=(Hod_data)li.get(0);
        session.close();
        //sf.close();
        if(hd.getIs_reg_started().equals("y"))
            return true;
        else
           return false; 
  } */
    //this method returns HOD registration status for Student
    public static boolean getRegStatusForStud(String uname)
    {  
        sf=SessionFact.getSessionFact(); 
        session=sf.openSession();System.out.print("hi");
         List li=session.createQuery("from Student_data where username=:uname").setString("uname",uname).list();
         Student_data sd=(Student_data)li.get(0);
         String programme=sd.getProgramme();System.out.println("----1--------------------"+programme);
         List li1=session.createQuery("from Hod_data where programme=:programme and user=:user").setString("programme",programme).setString("user","hod").list();
         Hod_data hd=(Hod_data)li1.get(0);
         System.out.println("------------------------"+hd.getUsername());
        session.close();
        //sf.close();
        if(hd.getIs_reg_started().equals("y"))
            return true;
        else
           return false; 
  } 
    //this method returns HOD registration status for registrar
    public static boolean getRegStatusForRegistrar(String uname,String user)
    {  
        System.out.println("----1--------------------"+uname+"--------------------------------------------------------------");
        System.out.println("----1--------------------"+user+"--------------------------------------------------------------");
        sf=SessionFact.getSessionFact(); 
        session=sf.openSession();
         List li=session.createQuery("from Hod_data where username=:uname and user=:user").setString("uname",uname).setString("user",user).list();
         Hod_data hd1=(Hod_data)li.get(0);
         String programme=hd1.getProgramme();
         System.out.println("----1--------------------"+programme+"--------------------------------------------------------------");
         List li1=session.createQuery("from Hod_data where programme=:programme and user=:user").setString("programme",programme).setString("user","hod").list();
         Hod_data hd=(Hod_data)li1.get(0);
         System.out.println("------------------------"+hd.getUsername());
        session.close();
        //sf.close();
        if(hd.getIs_reg_started().equals("y"))
            return true;
        else
           return false; 
  } 
    
    //Returns true if registrar is available for that department otherwise false.
     public static boolean isRegistrarAvailable(String uname)
    {
        System.out.print("++++++++++++++++++++++++++++++++++++++++++++++++"+uname);
        Hod_data hod=getHODInfo(uname);
        sf=SessionFact.getSessionFact();
        session=sf.openSession();
        List li=session.createQuery("from Hod_data where programme=:programme and user='registrar'").setString("programme", hod.getProgramme()).list();
        System.out.print("++++++++++++++++++++++++++++++++++++++++++++++++"+li.size());
        session.close();
        //sf.close();
        System.out.print("++++++++++++++++++++++++++++++++++++++++++++++++"+li.size());
        if(li.size()>0)
            return true;
        else
            return false;         
    }
     
    //Returns object of Hod_data of specified username.
     public static Hod_data getHODInfo(String uname)
     {
        try{
            sf=SessionFact.getSessionFact();
            session=sf.openSession();
            List li=session.createQuery("from Hod_data where username=:uname").setString("uname",uname).list();
            Hod_data hod=(Hod_data)li.get(0);
            session.close();
            //sf.close(); 
            return hod;
        }catch(Exception e){
            System.out.print("______________Exception in getHODInfo()________________"+e);
            return null;}
     }
     
     public static boolean checkStudAndHodData(String hodUname,String studUname)
     {
        Student_data stud=null;
         try{
            sf=SessionFact.getSessionFact();
            session=sf.openSession();
            List li=session.createQuery("from Hod_data where username=:uname").setString("uname",hodUname).list();
            Hod_data hod=(Hod_data)li.get(0);
            li=session.createQuery("from Student_data where username=:uname").setString("uname",studUname).list();
            stud=(Student_data)li.get(0);
            session.close();
            //sf.close(); 
            
        }catch(Exception e){
            System.out.print("______________Exception in checkStudAndHodData()________________"+e);
            return false;
            }
        if(stud==null)
                return false;
            else
                return true;
     }
     
     //for fetching already offered courses by hod 
     public static List getOfferedCouses(String program)
    { 
        List li=null;
        sf=SessionFact.getSessionFact();
        session=sf.openSession();
        li=session.createQuery("from Courses where programme=:program and is_offered='y' order by year").setString("program",program).list();
        System.out.println("list size is "+li.size());
        session.close();
        //sf.close();
        return li;
    }
}
