/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mainController;

import beans.Course_reg;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author sarvadnya
 */
public class CourseRegCon {
    static Session session;
    static SessionFactory sf;
    static Course_reg cr;
    
    public static int Cou_register(Course_reg creg)
    {
        int i=0;
        //Session session=new Configuration().configure().buildSessionFactory().openSession();
        sf=SessionFact.SessionFact.getSessionFact();
        session=sf.openSession();
        System.out.print("_______________________________________________________________________________Reached to Cou_register method");
        //System.out.print("_______________________________________________________________________________Cou_code = "+creg.getCou_code());
        System.out.print("Going to register(in Cou_register method) _____"+creg.getId()+"_________"+creg.getCourse_code()+"________"+creg.getRegno()+"______"+creg.getProgram());
        session.beginTransaction();
        i=(Integer)session.save(creg);
        session.getTransaction().commit();
        session.close();
        //sf.close();
        return i;
    }
}
