package net.yace.web.utils;

import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import net.yace.facade.YattributeFacade;
import net.yace.facade.YattributevalueFacade;
import net.yace.facade.YcollectionFacade;
import net.yace.facade.YitemFacade;
import net.yace.facade.YitemtypeFacade;
import net.yace.facade.YrankFacade;
import net.yace.facade.YsettingFacade;
import net.yace.facade.YuserFacade;

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
    
    public static YattributeFacade getAttributeFacade() {
        try {
            Context context = new InitialContext();
            return (YattributeFacade) context.lookup("java:global/Yace/Yace-ejb/YattributeFacade");
        } catch (NamingException ex) {
            Logger.getLogger(ServicesLocator.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public static YattributevalueFacade getAttributeValueFacade() {
        try {
            Context context = new InitialContext();
            return (YattributevalueFacade) context.lookup("java:global/Yace/Yace-ejb/YattributevalueFacade");
        } catch (NamingException ex) {
            Logger.getLogger(ServicesLocator.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public static YcollectionFacade getCollectionFacade() {
        try {
            Context context = new InitialContext();
            return (YcollectionFacade) context.lookup("java:global/Yace/Yace-ejb/YcollectionFacade");
        } catch (NamingException ex) {
            Logger.getLogger(ServicesLocator.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public static YitemFacade getItemFacade() {
        try {
            Context context = new InitialContext();
            return (YitemFacade) context.lookup("java:global/Yace/Yace-ejb/YitemFacade");
        } catch (NamingException ex) {
            Logger.getLogger(ServicesLocator.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public static YitemtypeFacade getItemTypeFacade() {
        try {
            Context context = new InitialContext();
            return (YitemtypeFacade) context.lookup("java:global/Yace/Yace-ejb/YitemtypeFacade");
        } catch (NamingException ex) {
            Logger.getLogger(ServicesLocator.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public static YrankFacade getRankFacade() {
        try {
            Context context = new InitialContext();
            return (YrankFacade) context.lookup("java:global/Yace/Yace-ejb/YrankFacade");
        } catch (NamingException ex) {
            Logger.getLogger(ServicesLocator.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public static YsettingFacade getSettingFacade() {
        try {
            Context context = new InitialContext();
            return (YsettingFacade) context.lookup("java:global/Yace/Yace-ejb/YsettingFacade");
        } catch (NamingException ex) {
            Logger.getLogger(ServicesLocator.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
}
