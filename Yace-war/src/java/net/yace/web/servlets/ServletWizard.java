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
    //private final static String VUE_WIZARD = "WEB-INF/view/user/wizard.jsp";
    private final static String VUE_WIZARD = "WEB-INF/view/user/update-collection.jsp";
    private final static String SVLT_COLLECTION = "see?idCollection=";

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
        //Si on appelle l'assistant pour une collection déjà définie, paramètre "collection" passé en get
        //S'en suit un C.V. et si c'est bon, on passe l'attribut "collection" pour la jsp.
        // TODO : déterminer quels renseignements sont nécessaires à l'assistant histoire que tout soit disponible dans la request
        //        la modification d'une collection existante est certainement une fonctionnalité dont on peut se passer pour vendredi
        //        je prropose donc qu'on se concentre d'abord sur la création proprement dite (donc code get bon, reste code post)
        YaceUtils.SessionState state = YaceUtils.getSessionState(request);
        if (state == YaceUtils.SessionState.noauth) {
            request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
        } else {
            YcollectionFacade collFacade = ServicesLocator.getCollectionFacade();

            HttpSession session = request.getSession(false);
            //On check pas, c'est déjà fait !
            Yuser user = (Yuser) session.getAttribute("user");

            String strIdcoll = request.getParameter("idCollection");
            //Collection définie en get ?
            if (strIdcoll != null) {
                int idcoll = Integer.parseInt(strIdcoll);
                Ycollection collection = collFacade.find(idcoll);
                if (collection != null) {
                    Yuser owner = collection.getOwner();
                    if (!owner.equals(user)) {
                        YaceUtils.displayCollectionUnreachableError(request, response);
                    }
                } else { // La collection n'existe pas
                    YaceUtils.displayCollectionUnreachableError(request, response);
                }
            }

            // Aide contextuelle
            Map<String, List<String>> asideHelp = new HashMap<String, List<String>>();

            List<String> infoBoxes = new ArrayList<String>();
            List<String> tipBoxes = new ArrayList<String>();

            infoBoxes.add("Sur cette page, vous pouvez créer une nouvelle collection, ou éditer vos collections déjà existantes.");
            infoBoxes.add("Vous pouvez choisir de rendre vos collections publiques à tout moment.");
            tipBoxes.add("Pour partager vos collections avec vos amis, rendez-la publique. Il pourront ainsi la consulter sans être membre de Ya<em class='CE'>ce</em> !");

            asideHelp.put("tip", tipBoxes);
            asideHelp.put("info", infoBoxes);

            request.setAttribute("asideHelp", YaceUtils.getAsideHelp(asideHelp));

            request.setAttribute("pageTitle", "Assistant de création de collection");
            request.getRequestDispatcher(VUE_WIZARD).forward(request, response);
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
        /*
         * Test de la session
         */
        YaceUtils.SessionState state = YaceUtils.getSessionState(request);
        if (state == YaceUtils.SessionState.noauth) {
            request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
        } else {
            HttpSession session = request.getSession(false);
            Yuser yuser = (Yuser) session.getAttribute("user");
            boolean nextStep = false;
            /*
             * Session valide: utilisateur connecté
             */

            YcollectionFacade facColl = ServicesLocator.getCollectionFacade();
            Ycollection collection = null;

            String idCollection = request.getParameter("idCollection");
            String name = request.getParameter("name");
            String isPublic = request.getParameter("isPublic");
            String delete = request.getParameter("delete");

            if (idCollection != null && !idCollection.isEmpty()) {
                /*
                 * On demande la modification d'une collection existante
                 */
                collection = facColl.find(Integer.parseInt(idCollection));

                if (collection == null || collection.getOwner().getIdYUSER() != yuser.getIdYUSER()) {
                    /*
                     * Erreur: on essaie d'accéder à une collection inexistante
                     */
                    YaceUtils.displayCollectionUnreachableError(request, response);
                } else {
                    if (delete != null && delete.equals("delete")) {
                        /*
                         * On demande la suppression totale de la collection
                         * items et tutti quanti
                         */

                        facColl.remove(collection);
                    } else {
                        /*
                         * On edite la collection
                         */
                        collection.setTheme(name);

                        if (isPublic.equals("true")) {
                            collection.setIsPublic(Boolean.TRUE);
                        } else {
                            collection.setIsPublic(Boolean.FALSE);
                        }

                        facColl.edit(collection);
                    }
                }
            } else {
                //ajout d'une nouvelle collection
                collection = new Ycollection();
                if (isPublic.equals("true")) {
                    collection.setIsPublic(Boolean.TRUE);
                } else {
                    collection.setIsPublic(Boolean.FALSE);
                }
                collection.setOwner(yuser);
                collection.setTheme(name);
                facColl.create(collection);
                nextStep = true;
            }

            if (nextStep) {
                /*
                 * On renvoie vers l'ajout d'itemtypes et d'objets
                 */
                request.getRequestDispatcher(SVLT_COLLECTION + collection.getIdYCOLLECTION()).forward(request, response);
            } else {
                // Aide contextuelle
                Map<String, List<String>> asideHelp = new HashMap<String, List<String>>();

                List<String> infoBoxes = new ArrayList<String>();
                List<String> tipBoxes = new ArrayList<String>();

                infoBoxes.add("Sur cette page, vous pouvez créer une nouvelle collection, ou éditer vos collections déjà existantes.");
                infoBoxes.add("Vous pouvez choisir de rendre vos collections publiques à tout moment.");
                tipBoxes.add("Pour partager vos collections avec vos amis, rendez-la publique. Il pourront ainsi la consulter sans être membre de Ya<em class='CE'>ce</em> !");

                asideHelp.put("tip", tipBoxes);
                asideHelp.put("info", infoBoxes);

                request.setAttribute("asideHelp", YaceUtils.getAsideHelp(asideHelp));

                // On nomme et affiche la page
                request.setAttribute("pageTitle", "Assistant de création de collection");
                request.getRequestDispatcher(VUE_WIZARD).forward(request, response);
            }
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Assistant de création/édition/suppression de collection";
    }
}
