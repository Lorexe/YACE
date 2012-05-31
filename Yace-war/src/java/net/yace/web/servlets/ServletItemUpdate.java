/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.web.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.yace.entity.Ycollection;
import net.yace.entity.Yuser;
import net.yace.facade.YcollectionFacade;
import net.yace.web.utils.ServicesLocator;
import net.yace.web.utils.YaceUtils;

/**
 *
 * @author MaBoy <bruno.boi@student.helha.be>
 */
public class ServletItemUpdate extends HttpServlet {

    private final static String VUE_PRESENTATION = "welcome.jsp";
    //TODO mettre ta fucking jsp ici mec :p
    private final static String VUE_ITEMS = "";

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
        YaceUtils.SessionState state = YaceUtils.getSessionState(request);

        if (state == YaceUtils.SessionState.admin) {
            // On nomme et affiche la page
            request.setAttribute("pageTitle", "Édition des objets d'une collection");
            request.getRequestDispatcher(VUE_ITEMS).forward(request, response);
        } else if (state == YaceUtils.SessionState.noauth) {
            request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
        } else {
            YaceUtils.displayAdminError(request, response);
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
        YaceUtils.SessionState state = YaceUtils.getSessionState(request);
        if (state == YaceUtils.SessionState.noauth) {
            request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
        } else {
            HttpSession session = request.getSession(false);
            Yuser yuser = (Yuser) session.getAttribute("user");
            /*
             * Session valide: utilisateur connecté
             */

            YcollectionFacade facColl = ServicesLocator.getCollectionFacade();

            String idCollection = request.getParameter("idCollection");

            if (idCollection != null && !idCollection.isEmpty()) {
                //check collection owner and edit.
                Ycollection collection = facColl.find(Integer.parseInt(idCollection));
                if (collection.getOwner().getIdYUSER() == yuser.getIdYUSER()) {
                    //Tout est ok
                } else {
                    //Error
                    request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
                }
            } else {
                request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
            }
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Ajout et édition d'un objet";
    }// </editor-fold>
}
