/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.web.servlets;

import java.io.IOException;
import java.util.HashMap;
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
        HttpSession session = request.getSession(true);
        if(session==null) {
            request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
        } else {
            Yuser yuser = (Yuser)session.getAttribute("user");
            if(yuser==null) {
                //request.setAttribute("error", "Session invalide");
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
                    
                    // TODO: vérifier que l'utilisateur possède la collection !
                    
                    if(collection==null || collection.getOwner().getIdYUSER() != yuser.getIdYUSER()){
                        /*
                         * Erreur: on essaie d'accéder à une collection inexistante
                         */
                        // On défini l'erreur qui s'est produite
                        request.setAttribute("errorMsg",
                            "Nous sommes désolé, mais la collection que vous tentez de modifier n'est pas en votre possession.<br/>"
                            + "Référez-vous à l'aide contextuelle pour plus d'information.<br/>"
                            + "Vous n'êtes pas satisfait ? <a href='about'>Contactez-nous</a> !"
                        );
                        
                        // Aide contextuelle
                        Map<String,String> asideHelp = new HashMap<String,String>();
                        asideHelp.put("info", "azerty");
                        asideHelp.put("tip", "qsdfghjklm");
                        asideHelp.put("tip", "Corn horseradish komatsuna bok choy artichoke salsify. Collard greens tatsoi potato bok choy catsear broccoli spinach parsley caulie soko. Prairie turnip cucumber rock melon arugula epazote bitterleaf cabbage potato coriander bunya nuts soybean nori spinach endive shallot.");
                        asideHelp.put("info", "Dandelion bush tomato quandong bok choy lotus root seakale plantain gram okra cress sorrel yarrow komatsuna chicory grape. Chard tomatillo grape black-eyed pea potato cress bamboo shoot. Epazote ricebean cauliflower kale kombu endive.");
                        asideHelp.put("info", "Veggies sunt bona vobis, proinde vos postulo esse magis yarrow watercress rock melon nori chard tigernut wakame pea sprouts wattle seed potato kale kohlrabi avocado aubergine.");
                        request.setAttribute("asideHelp", YaceUtils.getAsideHelp(asideHelp));
                        
                        // On nomme et affiche la page
                        request.setAttribute("pageTitle", "Collection introuvable");
                        request.getRequestDispatcher(ERROR_PAGE).forward(request,response);
                    }
                }
                
                // request.setAttribute("pageTitle", "Assistant de création de collection");
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
