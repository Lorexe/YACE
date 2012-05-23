/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.web.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.yace.entity.Ycollection;
import net.yace.entity.Yuser;
import net.yace.facade.YcollectionFacade;
import net.yace.web.utils.YaceUtils;
import net.yace.web.utils.ServicesLocator;

/**
 *
 * @author MaBoy <bruno.boi@student.helha.be>
 */
public class ServletWizard extends HttpServlet {
    
    private final static String VUE_PRESENTATION = "welcome.jsp";
    private final static String VUE_WIZARD = "WEB-INF/view/user/wizard.jsp";
    private final static String ERROR_PAGE = "WEB-INF/view/user/errorpage.jsp";
    
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
        /*
         * Test de la session
         */
        HttpSession session = request.getSession(false);
        if(session==null) {
            request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
        } else {
            Yuser yuser = (Yuser)session.getAttribute("user");
            if(yuser==null) {
                request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
            } else {
                /*
                 * Session valide: utilisateur connecté
                 */
                
                String idCollection = request.getParameter("idCollection");
                
                if (idCollection != null && !idCollection.isEmpty()) {
                    /*
                     * On demande la modification d'une collection existante
                     */
                    YcollectionFacade facColl = ServicesLocator.getCollectionFacade();
                    Ycollection collection = facColl.find(Integer.parseInt(idCollection));
                    
                    if(collection==null || collection.getOwner().getIdYUSER() != yuser.getIdYUSER()){
                        /*
                         * Erreur: on essaie d'accéder à une collection inexistante
                         */
                        // On défini l'erreur qui s'est produite
                        request.setAttribute("errorMsg",
                            "Nous sommes désolé, mais vous ne pouvez pas accéder à la collection demandée.<br/>"
                            + "Référez-vous à l'aide contextuelle pour plus d'information.<br/>"
                            + "Vous n'êtes pas satisfait ? <a href='about'>Contactez-nous</a> !"
                        );
                        
                        // Aide contextuelle
                        Map<String, List<String>> asideHelp = new HashMap<String, List<String>>();
                        
                        List<String> infoBoxes = new ArrayList<String>();
                        List<String> tipBoxes = new ArrayList<String>();
                        
                        infoBoxes.add("La collection qui est demandée est introuvable ou n'est pas en votre possession.");
                        tipBoxes.add("Essayez d'accéder à une autre collection !");
                        tipBoxes.add("N'hésitez pas à <a href='about'>nous contacter</a> si vous pensez qu'il s'agit d'une erreur de notre part. N'oubliez pas de détailler les actions qui vous ont mené à cette page, merci.");
                        
                        asideHelp.put("tip", tipBoxes);
                        asideHelp.put("info", infoBoxes);
                        
                        request.setAttribute("asideHelp", YaceUtils.getAsideHelp(asideHelp));
                        
                        // On nomme et affiche la page
                        request.setAttribute("pageTitle", "Collection introuvable");
                        request.getRequestDispatcher(ERROR_PAGE).forward(request,response);
                    }
                }
                
                
                // Aide contextuelle
                Map<String, List<String>> asideHelp = new HashMap<String, List<String>>();

                List<String> infoBoxes = new ArrayList<String>();
                List<String> tipBoxes = new ArrayList<String>();

                infoBoxes.add("En cours de rédaction");
                tipBoxes.add("En cours de rédaction");
                
                asideHelp.put("tip", tipBoxes);
                asideHelp.put("info", infoBoxes);

                request.setAttribute("asideHelp", YaceUtils.getAsideHelp(asideHelp));
                
                // On nomme et affiche la page
                request.setAttribute("pageTitle", "Assistant de création de collection");
                request.getRequestDispatcher(VUE_WIZARD).forward(request,response);
            }
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Assistant de création de collection";
    }
}
