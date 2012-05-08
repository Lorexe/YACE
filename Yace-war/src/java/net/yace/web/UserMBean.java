
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
import javax.persistence.EntityExistsException;
import net.yace.ejb.UserSessionBean;
import net.yace.entity.User;


/**
 *
 * @author Developpeur
 */
@Named(value = "user")
@SessionScoped
public class UserMBean implements Serializable {
    @EJB
    private UserSessionBean userSessionBean = new UserSessionBean();
    private User user;

    /** Creates a new instance of UserMBean */
    public UserMBean() {
    }
    
    public List<User> getUsers()
    {
        return userSessionBean.retrieve();
    }

    public User getUser(String pseudo) {
        return userSessionBean.getUser(pseudo);
    }
    
    public String update()
    {
        System.out.println("###UPDATE###");
        user = userSessionBean.update(user);
        return "SAVED";
    }
    
    public void addUser(User u) {
        try {
            userSessionBean.insert(u);
        }
        catch(EntityExistsException e) {
            e.printStackTrace();
        }
        catch(IllegalArgumentException e) {
            e.printStackTrace();
        }
    }
    
    public void setUser(User u) {
        this.user = u;
    }
}
