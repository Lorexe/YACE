package net.yace.web.servlets.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.yace.entity.Yrank;
import net.yace.entity.Yuser;
import net.yace.facade.YrankFacade;
import net.yace.facade.YuserFacade;
import net.yace.web.utils.ServicesLocator;
import net.yace.web.utils.YaceUtils;

/**
 *
 * @author MaBoy <bruno.boi@student.helha.be>
 */
public class ServletUserMgmt extends HttpServlet {

    private final static String VUE_PRESENTATION = "welcome.jsp";
    private final static String VUE_GESTION_USERS = "WEB-INF/view/admin/utilisateurs.jsp";

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
            request.setAttribute("pageTitle", "Gestion des utilisateurs - Administration du site");
            request.getRequestDispatcher(VUE_GESTION_USERS).forward(request, response);
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
        /* "mode" : add, edit ou delete suivant l'opération
         * "id" : l'id de l'utilisateur (sauf pour le add)
         * "name" : nom de l'utilisateur
         * "email" : adresse email
         * "rank" : integer représentant l'id du rang
         * 
         * Attribut "error" : message d'erreur !
         */

        YaceUtils.SessionState state = YaceUtils.getSessionState(request);

        if (state == YaceUtils.SessionState.admin) {
            String mode = request.getParameter("mode");
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String rank = request.getParameter("rank");

            YuserFacade userFacade = ServicesLocator.getUserFacade();
            YrankFacade rankFacade = ServicesLocator.getRankFacade();

            if (name.length() == 0 || name.length() > 254) {
                request.setAttribute("footDebug", "User name cannot exceed 254 characters or be empty");
            } else if (email.length() == 0 || email.length() > 254) {
                request.setAttribute("footDebug", "User email cannot exceed 254 characters or be empty");
            } else if (! YaceUtils.isValidEmail(email) ){
                request.setAttribute("footDebug", "User email : Wrong format");
            } else {

                if (mode.equals("add")) {
                    //Test données uniques
                    Yuser usermail = userFacade.findUser(email);
                    Yuser userpseudo = userFacade.findUser(name);
                    if (usermail == null && userpseudo == null) {
                        Yuser user = new Yuser();
                        user.setPseudo(name);
                        user.setEmail(email);

                        Yrank entrank = rankFacade.find(Integer.parseInt(rank));
                        user.setRank(entrank);

                        userFacade.create(user);
                    } else {
                        request.setAttribute("error", "Pseudo ou e-mail déjà utilisé");
                    }
                } else if (mode.equals("edit")) {
                    Yuser user = new Yuser();
                    try {
                        int userid = Integer.parseInt(id);
                        user.setIdYUSER(userid);
                        user.setPseudo(name);
                        user.setEmail(email);

                        Yrank entrank = rankFacade.find(Integer.parseInt(rank));
                        user.setRank(entrank);

                        userFacade.edit(user);
                    } catch (NumberFormatException e) {
                        request.setAttribute("footDebug", "Wrong user ID");
                    }
                } else if (mode.equals("delete")) {
                    Yuser user = userFacade.find(Integer.parseInt(id));
                    userFacade.remove(user);
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
        return "Gestion des utilisateurs";
    }
}
