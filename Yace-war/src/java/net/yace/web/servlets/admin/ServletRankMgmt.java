package net.yace.web.servlets.admin;

import java.io.IOException;
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
            // On nomme et affiche la page
            request.setAttribute("pageTitle", "Gestion des niveaux d'utilisateurs - Administration du site");
            request.getRequestDispatcher(VUE_GESTION_RANKS).forward(request, response);
        } else if (state == YaceUtils.SessionState.noauth) {
            request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
        } else {
            YaceUtils.DisplayAdminError(request, response);
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
                } else {
                    boolean isadmin = false;
                    if (admin != null) {
                        isadmin = true;
                    }

                    if (rankname.length() >= 254) {
                        request.setAttribute("footDebug", "Length of rank description cannot exceed 254 characters");
                    } else {

                        YrankFacade facade = ServicesLocator.getRankFacade();

                        if (id.equals("new")) {
                            Yrank rank = new Yrank(rankname, inbmax, isadmin);
                            facade.create(rank);
                        } else {
                            try {
                                int idrank = Integer.parseInt(id);
                                Yrank rank = new Yrank(idrank, rankname, inbmax, isadmin);
                                facade.edit(rank);
                            } catch (NumberFormatException e) {
                                request.setAttribute("footDebug", "Invalid Rank ID");
                            }
                        }
                    }
                }
            } catch (NumberFormatException e) {
                request.setAttribute("footDebug", "Max number of items must be an integer value");
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
