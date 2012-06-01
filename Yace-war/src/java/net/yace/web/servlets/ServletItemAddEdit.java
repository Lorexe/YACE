/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.web.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
 * @author Scohy Jérôme
 */
public class ServletItemAddEdit extends HttpServlet {

    private final static String VUE_COLLECTION = "/viewcol";
    private final static String VUE_ITEM_ADDEDIT = "WEB-INF/view/user/item-addedit.jsp";
    
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        YaceUtils.SessionState state = YaceUtils.getSessionState(request);
        if (state != YaceUtils.SessionState.noauth) {
            HttpSession session = request.getSession(false);
            Yuser yuser = (Yuser) session.getAttribute("user");

            YcollectionFacade facColl = ServicesLocator.getCollectionFacade();
            YitemtypeFacade facItemtype = ServicesLocator.getItemTypeFacade();
            
            String idCollection = request.getParameter("coll");
            String idType = request.getParameter("type");
            if (idCollection!=null && !idCollection.isEmpty() && idType!=null && !idType.isEmpty()) {
                Ycollection collection = facColl.find(Integer.parseInt(idCollection));
                Yitemtype itemtype = facItemtype.find(Integer.parseInt(idType));
                // TODO : Vérifier si l'itemtype est associé à la collection
                if (itemtype!=null && collection!=null && collection.getOwner().getIdYUSER() == yuser.getIdYUSER()) {
                    request.setAttribute("pageTitle", "Ajout d'un objet " + itemtype.getName() + " dans la collection " + collection.getTheme());
                    request.setAttribute("pageHeaderTitle", "Ajout d'un objet <strong>" + itemtype.getName() + "</strong> dans la collection <strong>" + collection.getTheme() + "</strong>");
                    request.setAttribute("idColl", idCollection);
                    request.setAttribute("idType", idType);
                    request.getRequestDispatcher(VUE_ITEM_ADDEDIT).forward(request, response);
                } else {
                    YaceUtils.displayCollectionUnreachableError(request, response);
                }
            } else {
                YaceUtils.displayCollectionUnreachableError(request, response);
            }
        } else {
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        YaceUtils.SessionState state = YaceUtils.getSessionState(request);
        if (state != YaceUtils.SessionState.noauth) {
            HttpSession session = request.getSession(false);
            Yuser yuser = (Yuser) session.getAttribute("user");
            
            YcollectionFacade facColl = ServicesLocator.getCollectionFacade();
            YitemtypeFacade facItemtype = ServicesLocator.getItemTypeFacade();
            
            String idCollection = request.getParameter("coll");
            String idType = request.getParameter("type");
            if (idCollection!=null && !idCollection.isEmpty() && idType!=null && !idType.isEmpty()) {
                Ycollection collection = facColl.find(Integer.parseInt(idCollection));
                Yitemtype itemtype = facItemtype.find(Integer.parseInt(idType));
                // TODO : Vérifier si l'itemtype est associé à la collection
                if (itemtype!=null && collection!=null && collection.getOwner().getIdYUSER() == yuser.getIdYUSER()) {

                    YitemFacade itemFacade = ServicesLocator.getItemFacade();
                    YattributeFacade attrFacade = ServicesLocator.getAttributeFacade();
                    YattributevalueFacade attrValFacade = ServicesLocator.getAttributeValueFacade();
                    
                    // Création de l'objet
                    Yitem item = new Yitem();
                    item.setType(itemtype);
                    item.setCollection(collection);
                    itemFacade.create(item);
                    
                    // Récupération des attributs
                    List<Yattribute> listAttributes = new ArrayList<Yattribute>();
                    listAttributes = attrFacade.findAttributesByItem(itemtype);
                    
                    // Remplissage des attributeValue
                    for(Yattribute attr : listAttributes) {
                        Yattributevalue av = new Yattributevalue();
                        av.setAttribute(attr);
                        
                        // Gestion des types d'attributs
                        if(attr.getType().equalsIgnoreCase("string")) {
                            av.setValStr(request.getParameter("attr_" + attr.getName()));
                        } else {
                            av.setValStr(request.getParameter("attr_" + attr.getName()));
                        }
                        
                        // Enregistrement de l'attributevalue
                        attrValFacade.create(av);
                        av.addYitem(item);
                        item.addYattributevalue(av);
                        itemFacade.edit(item);
                        attrValFacade.edit(av);
                    }
                    
                    request.setAttribute("idColl", idCollection);
                    request.setAttribute("idType", idType);
                    request.getRequestDispatcher(VUE_ITEM_ADDEDIT).forward(request, response);
                }
            }
        }
        
        doGet(request, response);
    }
    
    @Override
    public String getServletInfo() {
        return "Gestion de l'ajout/edition d'objet à une collection.";
    }
}
