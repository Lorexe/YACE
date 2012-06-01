/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.web.servlets;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.yace.entity.Ycollection;
import net.yace.entity.Yuser;
import net.yace.facade.YcollectionFacade;
import net.yace.web.utils.ServicesLocator;
import net.yace.web.utils.YaceUtils;
import net.yace.web.utils.YaceUtils.SessionState;

/**
 *
 * @author MaBoy <bruno.boi@student.helha.be>
 */
public class ServletCollectionsList extends HttpServlet {

    private final static String VUE_PRESENTATION = "welcome.jsp";
    private final static String VUE_COLL_LIST = "WEB-INF/view/user/collections-list.jsp";

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
        String idUser = request.getParameter("u");
        Yuser user = (Yuser) request.getSession().getAttribute("user");

        YcollectionFacade collFac = ServicesLocator.getCollectionFacade();
        List<Ycollection> collections = null;
        if (idUser == null || idUser.isEmpty()) {
            if (state == YaceUtils.SessionState.noauth) {
                request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
            } else {
                collections = collFac.findAllFromUser(user.getIdYUSER()); // lister ses propres collections
                request.setAttribute("pageTitle", "Liste de mes collections");
            }
        } else {
            Yuser u = ServicesLocator.getUserFacade().find(Integer.parseInt(idUser));
            if (u == null) {
                YaceUtils.displayUnknownUserError(request, response);
            } else {
                collections = collFac.findAllPublicFromUser(Integer.parseInt(idUser)); // lister les collections publiques d'un autre user
                request.setAttribute("pageTitle", "Liste des collections de " + u.getPseudo());
            }
        }

        request.setAttribute("collections", collections);

        request.getRequestDispatcher(VUE_COLL_LIST).forward(request, response);
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
        return "Lister ses collections ou les publiques d'un autre user";
    }
}
