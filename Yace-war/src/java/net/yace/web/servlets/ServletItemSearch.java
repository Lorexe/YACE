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
import javax.servlet.http.HttpSession;
import net.yace.entity.Ycollection;
import net.yace.entity.Yitem;
import net.yace.entity.Yuser;
import net.yace.facade.YcollectionFacade;
import net.yace.facade.YitemFacade;
import net.yace.web.utils.ServicesLocator;

/**
 *
 * @author Mikhail Pitchugin <mikael.pitchugin.isat@gmail.com>
 */
public class ServletItemSearch extends HttpServlet {

    private final static String VUE_SEARCH = "WEB-INF/view/user/item-search.jsp";
    private final static String VUE_HOME = "WEB-INF/view/user/home.jsp";
    
    // chemin /search
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
        //redirection accueil
        //page accessible en post
        
        request.getRequestDispatcher(VUE_HOME).forward(request, response);
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
        
        YitemFacade itemFac = ServicesLocator.getItemFacade();
        YcollectionFacade collFac = ServicesLocator.getCollectionFacade();
        
        String domain = request.getParameter("searchdomain");
        String search = request.getParameter("searchword");
        
        String nextpage = request.getParameter("searchnext");
        String prevpage = request.getParameter("searchprev");
        
        int firstres = Integer.parseInt(request.getParameter("firstres"));
        int resultsnumber = 3;//nombre des resultats à afficher sur une page
        
        //determiner le debut de la recherche
        if(prevpage != null)
        {
            firstres = firstres-resultsnumber;
        }
        else if(nextpage != null)
        {
            firstres+=resultsnumber;
        }
        
        List<Yitem> resultlist = null;
        
        HttpSession session = request.getSession(false);
            Yuser yuser = null;
            if(session != null)
                yuser = (Yuser)session.getAttribute("user");
        
        if(search != null || !search.equals(""))//changer || à && , ajouter limitation taille du search
        {
            request.setAttribute("searched", search);
            request.setAttribute("searchtype", domain);
            
            if(domain.equals("all"))
            {
                //recherche dans les collections publiques
                resultlist = itemFac.getItemsByAttrValues(search,resultsnumber,firstres);
                
                request.setAttribute("resultlist", resultlist);
            }
            else if(yuser != null && domain.equals("mycolls"))
            {
                //recherche dans mes collections
                resultlist = itemFac.getItemsSearchFromUser(search, yuser,resultsnumber,firstres);
                
                request.setAttribute("resultlist", resultlist);
            }
            else//if (domain.equals("thiscoll"))
            {
                //recherche dans une collection donnée
                //recuperer l'id de collection
                String colid = request.getParameter("searchcoll");
                
                Ycollection coll = collFac.find(Integer.parseInt(colid));
                        
                //methode de recherche des items d'une collection donée
                resultlist = itemFac.getItemsInColl(search, coll, yuser,resultsnumber,firstres);
                
                request.setAttribute("resultlist", resultlist);
                
            }
            //encode des elements à afficher?
            //si le nombre des results < taille de selection, non
            if(resultsnumber > resultlist.size())
            {
                request.setAttribute("sizeres", -1);
            }
            else
            {
                request.setAttribute("sizeres", resultsnumber);
            }
            
            request.setAttribute("searchpagenumber", (firstres/resultsnumber)+1);//numéro de page
            request.setAttribute("firstres", firstres);//valeur pour le formulaire dynamique
            request.setAttribute("resultsnumber", resultsnumber);
        }
        
        
        request.setAttribute("pageTitle", "Recherche");
        request.getRequestDispatcher(VUE_SEARCH).forward(request, response);// GO jsp
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Search servlet";
    }
}