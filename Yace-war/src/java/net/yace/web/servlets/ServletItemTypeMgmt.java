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
import net.yace.entity.Yattribute;
import net.yace.entity.Ycollection;
import net.yace.entity.Yitemtype;
import net.yace.entity.Yuser;
import net.yace.facade.YattributeFacade;
import net.yace.facade.YcollectionFacade;
import net.yace.facade.YitemFacade;
import net.yace.facade.YitemtypeFacade;
import net.yace.web.utils.ServicesLocator;
import net.yace.web.utils.YaceUtils;
import net.yace.web.utils.YaceUtils.SessionState;

/**
 *
 * @author biddaputzese <biddaputzese@gmail.com>
 */
public class ServletItemTypeMgmt extends HttpServlet {
    
    private final static String VUE_PRESENTATION = "welcome.jsp";
    private final static String VUE_MGMT_ITEMTYPE = "WEB-INF/view/user/itemtypemgmt.jsp";
    private final static String SVLT_COLLECTION = "see?idCollection=";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SessionState state = YaceUtils.getSessionState(request);
        if(state == YaceUtils.SessionState.noauth) {
            request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
        } else {
            // Aide contextuelle
            Map<String, List<String>> asideHelp = new HashMap<String, List<String>>();

            List<String> infoBoxes = new ArrayList<String>();
            List<String> tipBoxes = new ArrayList<String>();

            infoBoxes.add("En cours de rédaction.");
            tipBoxes.add("En cours de rédaction.");

            asideHelp.put("tip", tipBoxes);
            asideHelp.put("info", infoBoxes);

            request.setAttribute("asideHelp", YaceUtils.getAsideHelp(asideHelp));

            
            HttpSession session = request.getSession(false);
            Yuser yuser = (Yuser) session.getAttribute("user");

            YcollectionFacade facColl = ServicesLocator.getCollectionFacade();
            String idCollection = request.getParameter("coll");
            if (idCollection != null && !idCollection.isEmpty()) {
                Ycollection collection = facColl.find(Integer.parseInt(idCollection));
                if (collection!=null && collection.getOwner().getIdYUSER() == yuser.getIdYUSER()) {
                    // On nomme et affiche la page
                    request.setAttribute("pageTitle", "Ajout d'un type d'objet à la collection " + collection.getTheme());
                    request.setAttribute("pageHeaderTitle", "Ajout d'un type d'objet à la collection <strong>" + collection.getTheme() + "</strong>");
                    request.setAttribute("idColl", idCollection);
                    request.getRequestDispatcher(VUE_MGMT_ITEMTYPE).forward(request, response);
                } else {
                     YaceUtils.displayCollectionUnreachableError(request, response);
                }
            } else {
                 YaceUtils.displayCollectionUnreachableError(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        boolean redirect = false;
        
        YaceUtils.SessionState state = YaceUtils.getSessionState(request);
        if (state != YaceUtils.SessionState.noauth) {
            HttpSession session = request.getSession(false);
            Yuser yuser = (Yuser) session.getAttribute("user");

            YcollectionFacade facColl = ServicesLocator.getCollectionFacade();
            YitemtypeFacade facItemtype = ServicesLocator.getItemTypeFacade();
            YattributeFacade facAttribute = ServicesLocator.getAttributeFacade();

            String idCollection = request.getParameter("coll");
            if (idCollection != null && !idCollection.isEmpty() ) {
                Ycollection collection = facColl.find(Integer.parseInt(idCollection));
                if (collection != null && collection.getOwner().getIdYUSER() == yuser.getIdYUSER()) {
                    String buttonValidate = request.getParameter("button_validate");
                    if (buttonValidate != null) {
                        int nb_champs = Integer.parseInt(request.getParameter("nb_champs"));
                        
                        Yitemtype it = new Yitemtype();
                        it.setName(request.getParameter("name_type"));
                        it.setIsPublic(Boolean.FALSE);
                        facItemtype.create(it);
                        
                        for(int i=0; i<nb_champs; i++) {
                            Yattribute attr = new Yattribute();
                            attr.setMany(Boolean.FALSE);
                            attr.setName(request.getParameter("name_"+i));
                            attr.setNoOrder((i+1));
                            attr.setType(request.getParameter("type_"+i));
                            attr.setItemtype(it);
                            facAttribute.create(attr);
                        }
                    }
                    
                    redirect = true;
                    response.sendRedirect(SVLT_COLLECTION + idCollection);
                }
            }
        }
        
        if (!redirect) // si pas d'ajout, on fait appel à l'affichage normal de la page
        {
            doGet(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Ajout/suppression d'un itemtype à une collection";
    }
}