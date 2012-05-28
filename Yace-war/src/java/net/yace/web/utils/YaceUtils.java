/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.web.utils;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.yace.entity.Ycollection;
import net.yace.entity.Yuser;

/**
 *
 * @author MaBoy <bruno.boi@student.helha.be>
 */
public class YaceUtils {
    
    private final static String ERROR_PAGE = "WEB-INF/view/user/errorpage.jsp";

    /**
     * Précondition: boxes ne contient que des clés dans [info|tip]
     * Postcondition: renvoie le contenu html de la zone contextuelle d'aide
     * 
     * @param boxes
     * @return 
     */
    public static String getAsideHelp(Map<String, List<String>> boxes) {
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
                } else if (key.equals("tip")) {
                    tipsHTML +=
                            "<div class='tipbox'>"
                            + "<img class='tipicon' title='Astuce!' src='./theme/default/img/img_trans.gif' />"
                            + "<p>" + value + "</p>"
                            + "</div>";
                }
            }
        }

        return infosHTML + tipsHTML;
    }

    /**
     * 
     * @param collection
     * @return 
     */
    public static String getAsideCollectionView(Ycollection collection) {
        return "";
    }

    /**
     * 
     * @param s
     * @return 
     */
    public static String digestMD5(String s) {

        String ret = null;
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");

            md.reset();
            md.update(s.getBytes());
            byte[] digest = md.digest();

            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < digest.length; i++) {
                sb.append(Integer.toHexString(0xFF & digest[i]));
            }

            ret = sb.toString();
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(YaceUtils.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ret;
    }
    
    public static boolean isValidEmail(String email)
    {
        String expr = "^[\\w\\-]([\\.\\w])+[\\w]+@([\\w\\-]+\\.)+[A-Z{2,4}$";
        CharSequence input = email;
        Pattern pattern = Pattern.compile(expr, Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(input);
        return matcher.matches();
    }

    public static enum SessionState {
        noauth, auth, admin
    };

    public static SessionState getSessionState(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return SessionState.noauth;
        } else {
            Yuser yuser = (Yuser) session.getAttribute("user");
            if (yuser == null) {
                return SessionState.noauth;
            } else {
                // Session ok
                // On teste si privilèges admin
                if (yuser.getRank().isAdmin()) {
                    return SessionState.admin;
                } else {
                    return SessionState.auth;
                }
            }
        }
    }

    public static void displayAdminError(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // On défini l'erreur qui s'est produite
        request.setAttribute("errorMsg",
                "Nous sommes désolé, mais vous ne pouvez pas accéder à l'administration.<br/>"
                + "Référez-vous à l'aide contextuelle pour plus d'information.<br/>"
                + "Vous n'êtes pas satisfait ? <a href='about'>Contactez-nous</a> !");

        // Aide contextuelle
        Map<String, List<String>> asideHelp = new HashMap<String, List<String>>();

        List<String> infoBoxes = new ArrayList<String>();
        List<String> tipBoxes = new ArrayList<String>();

        infoBoxes.add("Vous tentez d'accéder à l'administration sans en avoir les privilèges.");
        tipBoxes.add("Essayez de ne pas accéder à l'administration !");
        tipBoxes.add("N'hésitez pas à <a href='about'>nous contacter</a> si vous pensez qu'il s'agit d'une erreur de notre part. N'oubliez pas de détailler les actions qui vous ont mené à cette page, merci.");

        asideHelp.put("tip", tipBoxes);
        asideHelp.put("info", infoBoxes);

        request.setAttribute("asideHelp", YaceUtils.getAsideHelp(asideHelp));

        // On nomme et affiche la page
        request.setAttribute("pageTitle", "Accès non autorisé");
        request.getRequestDispatcher(ERROR_PAGE).forward(request, response);
    }
    
    public static void displayUserUnknownError(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // On défini l'erreur qui s'est produite
        request.setAttribute("errorMsg",
                "Nous sommes désolé, mais l'utilisateur que vous recherchez n'existe pas dans notre base de données.<br/>"
                + "Référez-vous à l'aide contextuelle pour plus d'information.<br/>"
                + "Vous n'êtes pas satisfait ? <a href='about'>Contactez-nous</a> !");

        // Aide contextuelle
        Map<String, List<String>> asideHelp = new HashMap<String, List<String>>();

        List<String> infoBoxes = new ArrayList<String>();
        List<String> tipBoxes = new ArrayList<String>();

        infoBoxes.add("Vous tentez d'accéder aux informations d'un utilisateur qui est inconnu de nos services.");
        tipBoxes.add("Vérifiez le lien avec lequel vous tentez d'accéder à cette page !");
        tipBoxes.add("N'hésitez pas à <a href='about'>nous contacter</a> si vous pensez qu'il s'agit d'une erreur de notre part. N'oubliez pas de détailler les actions qui vous ont mené à cette page, merci.");

        asideHelp.put("tip", tipBoxes);
        asideHelp.put("info", infoBoxes);

        request.setAttribute("asideHelp", YaceUtils.getAsideHelp(asideHelp));

        // On nomme et affiche la page
        request.setAttribute("pageTitle", "Utilisateur introuvable");
        request.getRequestDispatcher(ERROR_PAGE).forward(request, response);
    }
}
