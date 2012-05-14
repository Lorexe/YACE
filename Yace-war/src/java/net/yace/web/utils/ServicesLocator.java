package net.yace.web.utils;

import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
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
}
