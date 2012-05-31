/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.web.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.yace.entity.Yattributevalue;
import net.yace.facade.YitemFacade;
import net.yace.web.utils.ServicesLocator;

/**
 *
 * @author Scohy Jérôme
 */
public class ServletItemDetails extends HttpServlet {
    
    private final static String VUE_ITEM = "WEB-INF/view/user/item-attributevalues.jsp";

    //url pattern : /details
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
        idItem = request.getParameter("it");
        if(idItem == null || idItem.isEmpty())
        {
         //param invalide
         //afficher message d'erreur ou rediriger l'user à l'accueil?
        }
        else
        {
            
            int idIt = Integer.parseInt(idItem);
            List<Yattributevalue> valList = itemFac.getItemsAttrValues(idIt);
            if(valList !=null)
            {
                request.setAttribute("attributevalues", valList);
            }
            else
            {
                //error liste vide
                //afficher message d'erreur
            }
        }
        
        request.setAttribute("pageTitle", "Les Attributs");//look for a title  
        request.getRequestDispatcher(VUE_ITEM).forward(request, response);// GO jsp
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //actions : update un item, delete l'item ?
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
