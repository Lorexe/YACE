/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.web.utils;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

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
        String html = "";
        Iterator<String> itKeys = boxes.keySet().iterator();
        
        while (itKeys.hasNext()) {
            String key = itKeys.next();
            Iterator<String> values = boxes.get(key).iterator();
            while (values.hasNext()) {
                String value = values.next();
                if (key.equals("info")) {
                    html +=
                        "<div class='infobox'>"
                        + "<img class='infoicon32' title='Que dois-je faire?' src='./theme/default/img/img_trans.gif' />"
                        + "<p>" + value + "</p>"
                        + "</div>";
                }
                else if (key.equals("tip")) {
                    html +=
                        "<div class='tipbox'>"
                        + "<img class='tipicon' title='Astuce!' src='./theme/default/img/img_trans.gif' />"
                        + "<p>" + value + "</p>"
                        + "</div>";
                }
            }
        }
        
        return html;
    }
}
