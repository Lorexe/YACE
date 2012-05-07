/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.web;

import javax.ejb.EJB;
import javax.inject.Named;
import javax.enterprise.context.SessionScoped;
import java.io.Serializable;
import java.util.List;
import net.yace.ejb.UserSessionBean;
import net.yace.entity.User;

/**
 *
 * @author MaBoy
 * @author Lorexe
 */
@Named(value = "user")
@SessionScoped
public class UserMBean implements Serializable {
    @EJB
    private UserSessionBean userSessionBean;
    private User user;

    /** Creates a new instance of UserMBean */
    public UserMBean() {
    }
    
    public List<User> getUsers()
    {
        return userSessionBean.retrieve();
    }

    public User getDetails()
    {
        return user;
    }
    
    public String showDetails(User u)
    {
        this.user = u;
        return "DETAILS";
    }

    public String update()
    {
        System.out.println("###UPDATE###");
        user = userSessionBean.update(user);
        return "SAVED";
    }

    public String list()
    {
        System.out.println("###LIST###");
        return "LIST";
    }
}
