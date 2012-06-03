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
import javax.servlet.http.HttpSession;
import net.yace.entity.Yattributevalue;
import net.yace.entity.Yitem;
import net.yace.entity.Yuser;
import net.yace.facade.YitemFacade;
import net.yace.web.utils.ServicesLocator;
import net.yace.web.utils.YaceUtils;

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
        
        //droits d'acces de l'utilisateur à l'item
        //cas user proprietaire item privé
        //cas consultation item publique
        
        YitemFacade itemFac = ServicesLocator.getItemFacade();
        String idItem = "";
        idItem = request.getParameter("item");
        if(idItem == null || idItem.isEmpty())
        {
         //param invalide
         //afficher message d'erreur ou rediriger l'user à l'accueil?
        }
        else
        {
            
            int idIt = Integer.parseInt(idItem);
            
            //gestion permission : public ou privé
            //savoir deja si l'item existe
            Yitem item = itemFac.find(idIt);
            
            YaceUtils.SessionState state = YaceUtils.getSessionState(request);
            
            HttpSession session = request.getSession(false);
            Yuser yuser = null;
            if(session != null)
                yuser = (Yuser)session.getAttribute("user");
             
            if(YaceUtils.CanDisplayItem(item, yuser))
            {
                //liste des attributs de l'item
                List<Yattributevalue> valList = itemFac.getItemsAttrValues(idIt);
                if(valList !=null)
                {
                    request.setAttribute("curItem", item);
                    request.setAttribute("attributevalues", valList);
                    request.setAttribute("prevIt", YaceUtils.getPrevItemId(item));
                    request.setAttribute("nextIt", YaceUtils.getNextItemId(item));
                }
                else
                {
                    //error liste vide
                    //afficher message d'erreur
                }
            }
            else
            {
                //error item non disponible
            }
        }
        
        request.setAttribute("pageTitle", "Les Détails de l'objet");//look for a title  
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
    }
}
