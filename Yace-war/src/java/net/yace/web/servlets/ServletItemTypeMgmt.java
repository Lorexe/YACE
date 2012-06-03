/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.web.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.yace.web.utils.YaceUtils;
import net.yace.web.utils.YaceUtils.SessionState;

/**
 *
 * @author biddaputzese <biddaputzese@gmail.com>
 */
public class ServletItemTypeMgmt extends HttpServlet {
    
    private final static String VUE_PRESENTATION = "welcome.jsp";
    private final static String VUE_MGMT_ITEMTYPE = "WEB-INF/view/user/about.jsp"; //TODO à modif
    
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
        SessionState state = YaceUtils.getSessionState(request);
        if(state == YaceUtils.SessionState.noauth) {
            request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
        } else {
            // Aide contextuelle
            Map<String, List<String>> asideHelp = new HashMap<String, List<String>>();

            List<String> infoBoxes = new ArrayList<String>();
            List<String> tipBoxes = new ArrayList<String>();

            infoBoxes.add("En cours de rédaction.");
            tipBoxes.add("En cours de rédaction.");

            asideHelp.put("tip", tipBoxes);
            asideHelp.put("info", infoBoxes);

            request.setAttribute("asideHelp", YaceUtils.getAsideHelp(asideHelp));

            // On nomme et affiche la page
            request.setAttribute("pageTitle", "Gestion des types d'objet de la collection : ");
            request.getRequestDispatcher(VUE_MGMT_ITEMTYPE).forward(request, response);
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
        doGet(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Ajout/suppression d'un itemtype à une collection";
    }
}
