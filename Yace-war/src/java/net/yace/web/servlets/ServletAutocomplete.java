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
import net.yace.entity.Yuser;
import net.yace.web.utils.YaceUtils;

public class ServletAutocomplete extends HttpServlet {
    
    private final static String VUE_PRESENTATION = "welcome.jsp";
    private final static String VUE_AUTOCOMPLETE = "WEB-INF/view/user/autocomplete.jsp";
    private final static String ERROR_PAGE = "WEB-INF/view/user/errorpage.jsp";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        /*
         * Test de la session
         */
        HttpSession session = request.getSession(false);
        if (session == null) {
            request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
        } else {
            Yuser yuser = (Yuser) session.getAttribute("user");
            if (yuser == null) {
                request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
            } else {
                /*
                 * Session valide
                 */
                
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
                request.setAttribute("pageTitle", "Test pour l'autocomplétion");
                request.getRequestDispatcher(VUE_AUTOCOMPLETE).forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Test d'autocomplétion";
    }
}
