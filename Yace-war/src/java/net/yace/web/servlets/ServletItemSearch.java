/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.web.servlets;

import java.io.IOException;
import java.io.PrintWriter;
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
import net.yace.entity.Yuser;
import net.yace.facade.YcollectionFacade;
import net.yace.facade.YitemFacade;
import net.yace.web.utils.ServicesLocator;
import net.yace.web.utils.YaceUtils;

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
        
        YitemFacade itemFac = ServicesLocator.getItemFacade();
        YcollectionFacade collFac = ServicesLocator.getCollectionFacade();
        
        String domain = request.getParameter("searchdomain");
        String search = request.getParameter("searchword");
        
        String nextpage = request.getParameter("searchnext");
        String prevpage = request.getParameter("searchprev");
        
        //vérification des paramètres
        if(search == null)
            search = "";
        
        search = search.trim();
        int firstres = 0;
        try
        {
            firstres = Integer.parseInt(request.getParameter("firstres"));
        }catch(NumberFormatException e){
            //
        }
        
        int resultsnumber = 6;//nombre des resultats à afficher sur une page
        int totalsize = 0;
        String totsize = request.getParameter("totalsize");
        if(totsize != null)
            totalsize = Integer.parseInt(totsize);//obtenir la taille totale
        
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
        
        if(search != null && search.length() > 1)//limitation taille du search
        {
            request.setAttribute("searched", search);
            request.setAttribute("searchtype", domain);
            
            if(domain.equals("all"))
            {
                //obtenir la taile totale lors du premier appel
                if(totalsize == 0)
                {
                    totalsize = itemFac.getItemsByAttrValues(search,0,0).size();
                    if(totalsize%resultsnumber ==0)
                        totalsize = (totalsize/resultsnumber);
                    else
                        totalsize = (totalsize/resultsnumber)+1;
                }
                //recherche dans les collections publiques
                resultlist = itemFac.getItemsByAttrValues(search,resultsnumber,firstres);
                
                request.setAttribute("resultlist", resultlist);
            }
            else if(yuser != null && domain.equals("mycolls"))
            {
                //obtenir la taile totale lors du premier appel
                if(totalsize == 0)
                {
                    totalsize = itemFac.getItemsSearchFromUser(search, yuser,0,0).size();
                    if(totalsize%resultsnumber ==0)
                        totalsize = (totalsize/resultsnumber);
                    else
                        totalsize = (totalsize/resultsnumber)+1;
                }
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
                //obtenir la taile totale lors du premier appel
                if(totalsize == 0)
                {
                    totalsize = itemFac.getItemsInColl(search, coll, yuser,0,0).size();
                    if(totalsize%resultsnumber ==0)
                        totalsize = (totalsize/resultsnumber);
                    else
                        totalsize = (totalsize/resultsnumber)+1;
                }
                //methode de recherche des items d'une collection donée
                resultlist = itemFac.getItemsInColl(search, coll, yuser,resultsnumber,firstres);
                
                request.setAttribute("resultlist", resultlist);
                // id de collection dans la quelle on effectue la recherche
                request.setAttribute("searchcoll", colid);
                
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
            request.setAttribute("totalsize", totalsize);
            request.setAttribute("searchpagenumber", (firstres/resultsnumber)+1);//numéro de page
            request.setAttribute("firstres", firstres);//valeur pour le formulaire dynamique
            request.setAttribute("resultsnumber", resultsnumber);
            
            Map<String, List<String>> asideHelp = new HashMap<String, List<String>>();

            List<String> infoBoxes = new ArrayList<String>();
            List<String> tipBoxes = new ArrayList<String>();

            infoBoxes.add("Chercher des objets.");
            tipBoxes.add("Les objets sont affichés par collection");
            tipBoxes.add("Cliquez sur le lien Details, les mots correspondants à votre recherche seront surlignés");
            tipBoxes.add("Vous pouvez naviguer sur les autres pages de résultats via les liens en bas de page");

            asideHelp.put("tip", tipBoxes);
            asideHelp.put("info", infoBoxes);

            request.setAttribute("asideHelp", YaceUtils.getAsideHelp(asideHelp));
        }
        else
        {
            //erreur  : terme a rechercher trop court
            YaceUtils.displaySearchError(request, response);
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
