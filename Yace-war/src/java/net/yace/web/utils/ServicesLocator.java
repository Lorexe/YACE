package net.yace.web.utils;

import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import net.yace.entity.Yattribute;
import net.yace.entity.Yattributevalue;
import net.yace.entity.Ycollection;
import net.yace.entity.Yitem;
import net.yace.entity.Yitemtype;
import net.yace.entity.Yrank;
import net.yace.facade.YuserFacade;

/**
 *
 * @author Scohy Jérôme
 */
public abstract class ServicesLocator {
    private ServicesLocator() {
    }
    
    public static YuserFacade getUserFacade() {
        try {
            Context context = new InitialContext();
            return (YuserFacade) context.lookup("java:global/Yace/Yace-ejb/YuserFacade");
        } catch (NamingException ex) {
            Logger.getLogger(ServicesLocator.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public static Yattribute getAttributeFacade() {
        try {
            Context context = new InitialContext();
            return (Yattribute) context.lookup("java:global/Yace/Yace-ejb/Yattribute");
        } catch (NamingException ex) {
            Logger.getLogger(ServicesLocator.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public static Yattributevalue getAttributeValueFacade() {
        try {
            Context context = new InitialContext();
            return (Yattributevalue) context.lookup("java:global/Yace/Yace-ejb/Yattributevalue");
        } catch (NamingException ex) {
            Logger.getLogger(ServicesLocator.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public static Ycollection getCollectionFacade() {
        try {
            Context context = new InitialContext();
            return (Ycollection) context.lookup("java:global/Yace/Yace-ejb/Ycollection");
        } catch (NamingException ex) {
            Logger.getLogger(ServicesLocator.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public static Yitem getItemFacade() {
        try {
            Context context = new InitialContext();
            return (Yitem) context.lookup("java:global/Yace/Yace-ejb/Yitem");
        } catch (NamingException ex) {
            Logger.getLogger(ServicesLocator.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public static Yitemtype getItemTypeFacade() {
        try {
            Context context = new InitialContext();
            return (Yitemtype) context.lookup("java:global/Yace/Yace-ejb/Yitemtype");
        } catch (NamingException ex) {
            Logger.getLogger(ServicesLocator.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public static Yrank getRankFacade() {
        try {
            Context context = new InitialContext();
            return (Yrank) context.lookup("java:global/Yace/Yace-ejb/Yrank");
        } catch (NamingException ex) {
            Logger.getLogger(ServicesLocator.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
}
