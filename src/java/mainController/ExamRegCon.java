/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mainController;

import beans.Exam_reg;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author sarvadnya
 */
public class ExamRegCon {
    static Session session;
    static SessionFactory sf;
    static Exam_reg er;
    
    public static int exRegister(Exam_reg exreg)
    {
        int i=0;
        //Session session=new Configuration().configure().buildSessionFactory().openSession();
        try
        {
        sf=SessionFact.SessionFact.getSessionFact();
        session=sf.openSession();
        //System.out.print("_______________________________________________________________________________Reached to Cou_register method");
        //System.out.print("_______________________________________________________________________________Cou_code = "+creg.getCou_code());
        System.out.print("Going to register(in Ex_register method) _____"+exreg.getId()+"_________"+exreg.getCourse_code()+"________"+exreg.getRegno()+"______"+exreg.getProg());
        session.beginTransaction();
        i=(Integer)session.save(exreg);
        session.getTransaction().commit();
        session.close();
        //sf.close();
        System.out.print(i);
        }
        catch(Exception e){System.out.print("_________________________ex__register exception-------------------------------------"+e);}
        return i;
    }
     public static int examRegReset(String roll_no)
    {
       
            Query qr;
         
            List list1=new ArrayList();
            sf=SessionFact.SessionFact.getSessionFact();
            session=sf.openSession();
             session.beginTransaction();
            qr=session.createQuery("delete FROM Exam_reg WHERE regno =:rollnumber");
             qr.setString("rollnumber", roll_no);
             System.out.println("-----------------------------------------------------------"+roll_no);
             
           int result=qr.executeUpdate();
            session.getTransaction().commit();
        session.close();
        //sf.close();
           return result;
           
    }
}
