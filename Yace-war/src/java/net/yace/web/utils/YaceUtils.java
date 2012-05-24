/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.web.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author MaBoy <bruno.boi@student.helha.be>
 */
public class YaceUtils {
    
    /**
     * Précondition: boxes ne contient que des clés dans [info|tip]
     * Postcondition: renvoie le contenu html de la zone contextuelle d'aide
     * 
     * @param boxes
     * @return 
     */
    public static String getAsideHelp(Map<String, List<String>> boxes){
        String tipsHTML = "";
        String infosHTML = "";
        Iterator<String> itKeys = boxes.keySet().iterator();
        
        while (itKeys.hasNext()) {
            String key = itKeys.next();
            Iterator<String> values = boxes.get(key).iterator();
            while (values.hasNext()) {
                String value = values.next();
                if (key.equals("info")) {
                    infosHTML +=
                        "<div class='infobox'>"
                        + "<img class='infoicon32' title='Que dois-je faire?' src='./theme/default/img/img_trans.gif' />"
                        + "<p>" + value + "</p>"
                        + "</div>";
                }
                else if (key.equals("tip")) {
                    tipsHTML +=
                        "<div class='tipbox'>"
                        + "<img class='tipicon' title='Astuce!' src='./theme/default/img/img_trans.gif' />"
                        + "<p>" + value + "</p>"
                        + "</div>";
                }
            }
        }
        
        return infosHTML+tipsHTML;
    }
    
    public static String digestMD5(String s) {
        
        String ret = null;
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            
            md.reset();
            md.update(s.getBytes());
            byte[] digest = md.digest();
            
            StringBuilder sb = new StringBuilder();
            for(int i=0; i<digest.length; i++) {
                sb.append(Integer.toHexString(0xFF & digest[i]));
            }
            
            ret = sb.toString();
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(YaceUtils.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return ret;
    }
}
