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
import net.yace.entity.Ycollection;
import net.yace.entity.Yitem;
import net.yace.entity.Yitemtype;
import net.yace.entity.Yuser;
import net.yace.facade.YitemFacade;
import net.yace.facade.YitemtypeFacade;
import net.yace.web.utils.ServicesLocator;
import net.yace.web.utils.YaceUtils;

/**
 *
 * @author Mikhail Pitchugin <mikael.pitchugin.isat@gmail.com>
 */
public class ServletDeleteItem extends HttpServlet {

    private final static String VUE_TYPE = "WEB-INF/view/user/item-deletion.jsp";
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
        
        YitemFacade itemFac = ServicesLocator.getItemFacade();
        String idItem = "";
        idItem = request.getParameter("del");
        if(idItem == null || idItem.isEmpty())
        {
            //rediriger l'user à l'accueil
            request.getRequestDispatcher(VUE_HOME).forward(request, response);
        }
        else
        {
            int idIt = Integer.parseInt(idItem);
            Yitem yitem = itemFac.find(idIt);

            HttpSession session = request.getSession(false);
            Yuser yuser = null;
            if (session != null) {
                yuser = (Yuser) session.getAttribute("user");
            }
            
            if(YaceUtils.canDeleteItem(yitem, yuser))
            {
                Ycollection coll = yitem.getCollection();
                itemFac.remove(yitem);//suppression de l'item
                
                Map<String, List<String>> asideHelp = new HashMap<String, List<String>>();
                List<String> infoBoxes = new ArrayList<String>();
                List<String> tipBoxes = new ArrayList<String>();

                infoBoxes.add("Objet Supprimé");
                tipBoxes.add("Vous avez supprimé un objet de la collection ");

                asideHelp.put("tip", tipBoxes);
                asideHelp.put("info", infoBoxes);

                request.setAttribute("asideHelp", YaceUtils.getAsideHelp(asideHelp));
                
                request.setAttribute("collitem", coll);
                request.setAttribute("pageTitle", "Suppression d'un objet");
                request.getRequestDispatcher(VUE_TYPE).forward(request, response);
            }
            else
            {
            //rediriger l'user à l'accueil
            request.getRequestDispatcher(VUE_HOME).forward(request, response);
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
        //do get
        doGet(request, response);
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
