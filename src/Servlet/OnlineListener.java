package Servlet;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.ArrayList;
import java.util.List;

@WebListener
public class OnlineListener implements ServletContextListener, HttpSessionAttributeListener, HttpSessionListener {
    private ServletContext application=null;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        List<String> list=new ArrayList<String>();
        application=sce.getServletContext();
        application.setAttribute("allUser",list);
    }


    @Override
    public void sessionCreated(HttpSessionEvent se) {

    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {

    }

    @Override
    public void attributeAdded(HttpSessionBindingEvent se) {
         List<String> list=(List<String>)application.getAttribute("allUser");
         String name=(String)se.getName();
         if (name.equals("uid")){
             list.add(name);
             application.setAttribute("allUser",list);
         }
    }

    @Override
    public void attributeRemoved(HttpSessionBindingEvent se) {
        List<String> list=(List<String>)application.getAttribute("allUser");
        String name=(String)se.getName();
        if (name.equals("uid")) {
            list.remove(name);
            application.setAttribute("allUser", list);
        }
    }

    @Override
    public void attributeReplaced(HttpSessionBindingEvent se) {

    }


    @Override
    public void contextDestroyed(ServletContextEvent sce) {

    }
}
