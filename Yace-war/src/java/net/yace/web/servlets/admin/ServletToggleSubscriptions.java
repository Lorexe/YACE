/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.web.servlets.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.yace.entity.Ysetting;
import net.yace.entity.Yuser;
import net.yace.facade.YsettingFacade;
import net.yace.web.utils.ServicesLocator;
import net.yace.web.utils.YaceUtils;

/**
 *
 * @author MaBoy <bruno.boi@student.helha.be>
 */
public class ServletToggleSubscriptions extends HttpServlet {

    private final static String VUE_PRESENTATION = "welcome.jsp";
    private final static String VUE_INSCRIPTIONS_ADMIN = "WEB-INF/view/admin/inscriptions.jsp";
    private final static String ERROR_PAGE = "WEB-INF/view/user/errorpage.jsp";

    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        /*
         * Test de la session
         */
        HttpSession session = request.getSession(false);
        if (session == null) {
            request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
        } else {
            Yuser yuser = (Yuser) session.getAttribute("user");
            if (yuser == null) {
                request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
            } else {
                /*
                 * Session valide
                 */
                // On teste si privilèges admin
                if (yuser.getRank().isAdmin()) {
                    /*
                     * Administrateur connecté
                     */

                    // Aide contextuelle
                    Map<String, List<String>> asideHelp = new HashMap<String, List<String>>();

                    List<String> infoBoxes = new ArrayList<String>();
                    List<String> tipBoxes = new ArrayList<String>();

                    infoBoxes.add("En cours de rédaction");
                    tipBoxes.add("En cours de rédaction");

                    asideHelp.put("tip", tipBoxes);
                    asideHelp.put("info", infoBoxes);

                    request.setAttribute("asideHelp", YaceUtils.getAsideHelp(asideHelp));

                    // On nomme et affiche la page
                    request.setAttribute("pageTitle", "Gestion des inscriptions - Administration du site");
                    request.getRequestDispatcher(VUE_INSCRIPTIONS_ADMIN).forward(request, response);
                } else {

                    /*
                     * Erreur: l'utilisateur connecté n'est pas administrateur
                     */

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
            }
        }
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        /*
         * Test de la session
         */
        HttpSession session = request.getSession(false);
        if (session == null) {
            request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
        } else {
            Yuser yuser = (Yuser) session.getAttribute("user");
            if (yuser == null) {
                request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
            } else {
                /*
                 * Session valide
                 */
                // On teste si privilèges admin
                if (yuser.getRank().isAdmin()) {
                    /*
                     * Administrateur connecté
                     */
                    YsettingFacade settingFac = ServicesLocator.getSettingFacade();
                    Ysetting setSubscriptions = settingFac.findByName("subscribeOk");

                    if (setSubscriptions.getVal().equals("true")) {
                        setSubscriptions.setVal("false");
                    } else {
                        setSubscriptions.setVal("true");
                    }

                    settingFac.edit(setSubscriptions);

                }
            }
        }
        doGet(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "(Dés)activation des inscriptions";
    }
}
