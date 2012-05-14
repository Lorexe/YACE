
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
import net.yace.ejb.YuserSessionBean;
import net.yace.entity.Yuser;


/**
 *
 * @author Developpeur
 */
@Named(value = "yuser")
@SessionScoped
public class YuserMBean implements Serializable {
    @EJB
    private YuserSessionBean yuserSessionBean = new YuserSessionBean();
    private Yuser yuser;

    /** Creates a new instance of YuserMBean */
    public YuserMBean() {
    }
    
    public List<Yuser> getYusers()
    {
        return yuserSessionBean.retrieve();
    }

    public Yuser getYuser(String pseudo) {
        return yuserSessionBean.getYuser(pseudo);
    }
    
    public String update()
    {
        System.out.println("###UPDATE###");
        yuser = yuserSessionBean.update(yuser);
        return "SAVED";
    }
    
    public void addYuser(Yuser u) {
        try {
            yuserSessionBean.insert(u);
        }
        catch(EntityExistsException e) {
            e.printStackTrace();
        }
        catch(IllegalArgumentException e) {
            e.printStackTrace();
        }
    }
    
    public void setYuser(Yuser u) {
        this.yuser = u;
    }
}
