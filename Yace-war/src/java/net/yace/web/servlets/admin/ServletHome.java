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
import net.yace.web.utils.YaceUtils;

public class ServletHome extends HttpServlet {

    private final static String VUE_PRESENTATION = "welcome.jsp";
    private final static String VUE_HOME_ADMIN = "WEB-INF/view/admin/index.jsp";

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
        doPost(request, response);
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
        } else if (state == YaceUtils.SessionState.admin) {
            // Aide contextuelle
            Map<String, List<String>> asideHelp = new HashMap<String, List<String>>();

            List<String> infoBoxes = new ArrayList<String>();
            List<String> tipBoxes = new ArrayList<String>();

            infoBoxes.add("Dans cette section du site, vous avez accès à divers outils vous permettant d'administrer Ya<em class='CE'>ce</em>.");
            infoBoxes.add("Vous pouvez (dés)activer les inscriptions au site, ajouter/modifier des grades utilisateurs, éditer/supprimer les utilisateurs du site.");
            tipBoxes.add("Utilisez vos pouvoirs avec parcimonie.");
            tipBoxes.add("N'hésitez pas à changer les informations de connexion d'un utilisateur s'il ne respecte pas les règles d'éthique en société.");
            tipBoxes.add("N'hésitez pas à supprimer un utilisateur qui partage de manière publique des collections choquantes. Les objets qu'il a enregistré sur le site seront automatiquement oubliés.");
            tipBoxes.add("N'hésitez pas à <a href='about'>nous contacter</a> si vous avez une suggestion à nous transmettre.");

            asideHelp.put("tip", tipBoxes);
            asideHelp.put("info", infoBoxes);

            request.setAttribute("asideHelp", YaceUtils.getAsideHelp(asideHelp));

            // On nomme et affiche la page
            request.setAttribute("pageTitle", "Administration du site");
            request.getRequestDispatcher(VUE_HOME_ADMIN).forward(request, response);
        } else {
            YaceUtils.displayAdminError(request, response);
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Affiche la page d'administration";
    }
}
