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
import javax.servlet.http.HttpSession;
import net.yace.entity.Yitemtype;
import net.yace.entity.Yuser;
import net.yace.facade.YitemtypeFacade;
import net.yace.web.utils.ServicesLocator;
import net.yace.web.utils.YaceUtils;

/**
 *
 * @author Mikhail Pitchugin <mikael.pitchugin.isat@gmail.com>
 */
public class ServletItemTypeResume extends HttpServlet {

    private final static String VUE_TYPE = "WEB-INF/view/user/itemtype-details.jsp";
    private final static String VUE_HOME = "WEB-INF/view/user/home.jsp";

    //url pattern : /typedetails
    //ce servlet fournit une desctiption d'un itemtype
    //liste de ses attributs et leur type
    
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
        
        YitemtypeFacade typeFac = ServicesLocator.getItemTypeFacade();
        String idType = "";
        idType = request.getParameter("type");
        if(idType == null || idType.isEmpty())
        {
            //rediriger l'user à l'accueil
            request.getRequestDispatcher(VUE_HOME).forward(request, response);
        }
        else
        {
            int idIt = Integer.parseInt(idType);
            Yitemtype ytype = typeFac.find(idIt);

            HttpSession session = request.getSession(false);
            Yuser yuser = null;
            if (session != null) {
                yuser = (Yuser) session.getAttribute("user");
            }
            
            if(YaceUtils.canConsultItemType(ytype, yuser))
            {
                Map<String, List<String>> asideHelp = new HashMap<String, List<String>>();
                List<String> infoBoxes = new ArrayList<String>();
                List<String> tipBoxes = new ArrayList<String>();

                infoBoxes.add("Les détails d'un type d'objet.");
                tipBoxes.add("Un type d'objet peut être public ou appartenir à une collection précise");

                asideHelp.put("tip", tipBoxes);
                asideHelp.put("info", infoBoxes);

                request.setAttribute("asideHelp", YaceUtils.getAsideHelp(asideHelp));
                
                //request.setAttribute("canEdit", YaceUtils.canEditItemType(ytype, yuser));
                request.setAttribute("ytypedet", ytype);
                request.setAttribute("pageTitle", "Détails du type d'objet " + ytype.getName());
                request.getRequestDispatcher(VUE_TYPE).forward(request, response);
            }
            
            //rediriger l'user à l'accueil
            request.getRequestDispatcher(VUE_HOME).forward(request, response);
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
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
