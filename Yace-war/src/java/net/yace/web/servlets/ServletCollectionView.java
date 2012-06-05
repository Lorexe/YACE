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
import net.yace.entity.Yattribute;
import net.yace.entity.Yattributevalue;
import net.yace.entity.Ycollection;
import net.yace.entity.Yitem;
import net.yace.entity.Yitemtype;
import net.yace.entity.Yuser;
import net.yace.facade.YattributeFacade;
import net.yace.facade.YattributevalueFacade;
import net.yace.facade.YcollectionFacade;
import net.yace.facade.YitemFacade;
import net.yace.facade.YitemtypeFacade;
import net.yace.web.utils.ServicesLocator;
import net.yace.web.utils.YaceUtils;

/**
 *
 * @author MaBoy <bruno.boi@student.helha.be>
 */
public class ServletCollectionView extends HttpServlet {

    //TODO mettre ta fucking jsp ici mec :p
    private final static String VUE_COLL_VIEW = "WEB-INF/view/user/collection.jsp";

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
        boolean error = false;

        String idCollection = request.getParameter("idCollection");
        try {
            int collid = Integer.parseInt(idCollection);

            YcollectionFacade collfac = ServicesLocator.getCollectionFacade();
            Ycollection coll = collfac.find(collid);
            Yuser owner = coll.getOwner();
            Yuser user = (Yuser) request.getSession().getAttribute("user");

            if (coll.isPublic() || (user != null && user.getIdYUSER() == owner.getIdYUSER())) {
                YitemtypeFacade itfac = ServicesLocator.getItemTypeFacade();
                YitemFacade ifac = ServicesLocator.getItemFacade();
                YattributeFacade yatfac = ServicesLocator.getAttributeFacade();
                YattributevalueFacade yatvfac = ServicesLocator.getAttributeValueFacade();

                List<Yitemtype> itemtypes = itfac.findItemtypesInCollection(coll);
                List<List<Yitem>> itemsByType = new ArrayList<List<Yitem>>();
                List<List<Yattribute>> attributes = new ArrayList<List<Yattribute>>();
                List<List<List<Yattributevalue>>> values = new ArrayList<List<List<Yattributevalue>>>();

                for (int i = 0; i < itemtypes.size(); i++) {
                    attributes.add(yatfac.findAttributesByItem(itemtypes.get(i)));

                    List<Yitem> items = ifac.getItemsByCollectionAndType(coll, itemtypes.get(i));
                    itemsByType.add(items);
                    values.add(new ArrayList<List<Yattributevalue>>());
                    for (int j = 0; j < items.size(); j++) {
                        values.get(i).add(yatvfac.findAllValuesForItem(items.get(j)));
                    }
                }

                // Ajout d'objet de typeitem public
                List<Yitemtype> itemtypesPublic = itfac.findItemtypesPublic();

                // Liste les types d'objet sans objet
                List<Yitemtype> withoutItem = itfac.findItemtypesWithoutItem(coll);

                request.setAttribute("collection", coll);
                request.setAttribute("itemtypes", itemtypes);
                request.setAttribute("withoutItem", withoutItem);
                request.setAttribute("itemtypesPublic", itemtypesPublic);
                request.setAttribute("attributes", attributes);
                request.setAttribute("values", values);
                request.setAttribute("items", itemsByType);
                request.setAttribute("pageTitle", "Objets dans la collection");

                //ASIDE HELP
                Map<String, List<String>> asideHelp = new HashMap<String, List<String>>();
                List<String> infoBoxes = new ArrayList<String>();
                List<String> tipBoxes = new ArrayList<String>();

                infoBoxes.add("Sur cette page, vous pouvez consulter le contenu de vos collections");
                infoBoxes.add("Les objets sont triés par type");
                tipBoxes.add("Un clic sur un objet affichera sa description complète");
                tipBoxes.add("Un clic sur <strong>Détails</strong> vous redirigera sur une page de navigation détaillée");
                if (user.getIdYUSER() == owner.getIdYUSER()) {
                    tipBoxes.add("Vous pouvez aussi ajouter des objets à votre collection, ou éditer un objet déjà existant");
                }

                asideHelp.put("tip", tipBoxes);
                asideHelp.put("info", infoBoxes);

                request.setAttribute("asideHelp", YaceUtils.getAsideHelp(asideHelp));

                request.getRequestDispatcher(VUE_COLL_VIEW).forward(request, response);
            } else {
                error = true;
            }
        } catch (NumberFormatException e) {
            error = true;
        }

        if (error) {
            YaceUtils.displayCollectionUnreachableError(request, response);
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
        doGet(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Ajout et édition d'un objet";
    }
}
