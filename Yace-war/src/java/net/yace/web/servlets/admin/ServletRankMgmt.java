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
import net.yace.entity.Yrank;
import net.yace.facade.YrankFacade;
import net.yace.web.utils.ServicesLocator;
import net.yace.web.utils.YaceUtils;

/**
 *
 * @author MaBoy <bruno.boi@student.helha.be>
 */
public class ServletRankMgmt extends HttpServlet {

    private final static String VUE_PRESENTATION = "welcome.jsp";
    private final static String VUE_GESTION_RANKS = "WEB-INF/view/admin/niveaux.jsp";

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
            // Aide contextuelle
            Map<String, List<String>> asideHelp = new HashMap<String, List<String>>();

            List<String> infoBoxes = new ArrayList<String>();
            List<String> tipBoxes = new ArrayList<String>();

            infoBoxes.add("Sur cette page, vous pouvez éditer les grades des utilisateurs de Ya<em class='CE'>ce</em>, à l'exception du premier rang, qui doit conserver les privilèges administrateur dans tous les cas.");
            infoBoxes.add("Vous pouvez aussi ajouter de nouveaux grades, afin de limiter le nombre d'objets autorisés.");
            tipBoxes.add("Si vous voulez, provisoirement, empêcher tout un groupe d'utilisateurs d'ajouter de nouveaux objets, mettez le nombre d'objets max correspondant à 0.");
            tipBoxes.add("Un nombre d'objets maximum de -1 équivaut à un nombre illimité d'objets autorisés.");
            tipBoxes.add("N'hésitez pas à <a href='about'>nous contacter</a> si vous avez une suggestion à nous transmettre.");

            asideHelp.put("tip", tipBoxes);
            asideHelp.put("info", infoBoxes);

            request.setAttribute("asideHelp", YaceUtils.getAsideHelp(asideHelp));
            
            // On nomme et affiche la page
            request.setAttribute("pageTitle", "Gestion des niveaux d'utilisateurs - Administration du site");
            request.getRequestDispatcher(VUE_GESTION_RANKS).forward(request, response);
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

        if (state == YaceUtils.SessionState.admin) {
            String rankname = request.getParameter("name");
            String nbmax = request.getParameter("nbMax");
            String[] admin = request.getParameterValues("isAdmin");
            String id = request.getParameter("idYRANK");

            try {
                int inbmax = Integer.parseInt(nbmax);
                if (inbmax < -1) {
                    request.setAttribute("footDebug", "Max number of items must be positive or equal to -1");
                    request.setAttribute("info","Pour permettre à un grade d'avoir un nombre illimité d'objets, mettez le nombre d'objets max à -1.");
                } else {
                    boolean isadmin = false;
                    if (admin != null) {
                        isadmin = true;
                    }

                    if (rankname == null || rankname.isEmpty()) {
                        request.setAttribute("footDebug", "Length of rank description cannot be empty");
                        request.setAttribute("error","Le nom du rang ne peut pas être vide");
                    } else if (rankname.length() > 254) {
                        request.setAttribute("footDebug", "Length of rank description cannot exceed 254 characters");
                        request.setAttribute("error","Le nom du rang est trop long (Max: 254 caractères)");
                    } else {

                        YrankFacade facade = ServicesLocator.getRankFacade();

                        if (id.equals("new")) {
                            Yrank rank = new Yrank(rankname, inbmax, isadmin);
                            facade.create(rank);
                        } else {
                            try {
                                int idrank = Integer.parseInt(id);
                                if (idrank == 1 && !isadmin) {
                                    request.setAttribute("footDebug", "The first rank must keep admin privileges");
                                    request.setAttribute("info","Le premier rang doit conserver les privilèges administrateur");
                                    isadmin=true;
                                } else if (idrank == 2 && isadmin) {
                                    request.setAttribute("footDebug", "The second rank must keep simple user privileges");
                                    request.setAttribute("info","Le deuxième rang doit conserver les privilèges d'un simple utilisateur");
                                    isadmin=false;
                                }
                                Yrank rank = new Yrank(idrank, rankname, inbmax, isadmin);
                                facade.edit(rank);
                            } catch (NumberFormatException e) {
                                request.setAttribute("footDebug", "Invalid Rank ID");
                                request.setAttribute("error","ID du rang invalide");
                            }
                        }
                    }
                }
            } catch (NumberFormatException e) {
                request.setAttribute("footDebug", "Max number of items must be an integer value");
                request.setAttribute("error","Le nombre d'objets maximum doit être un nombre entier");
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
        return "Gestion des rangs d'utilisation";
    }
}
