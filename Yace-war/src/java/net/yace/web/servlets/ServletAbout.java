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
import net.yace.web.utils.EmailSender;
import net.yace.web.utils.YaceUtils;

/**
 *
 * @author MaBoy <bruno.boi@student.helha.be>
 */
public class ServletAbout extends HttpServlet {
    
    private final static String VUE_ABOUT = "WEB-INF/view/user/about.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Aide contextuelle
        Map<String, List<String>> asideHelp = new HashMap<String, List<String>>();

        List<String> infoBoxes = new ArrayList<String>();
        List<String> tipBoxes = new ArrayList<String>();

        infoBoxes.add("Sur cette page, vous pouvez découvrir les auteurs de Ya<em class='CE'>ce</em>.");
        infoBoxes.add("Aussi, un formulaire de contact vous permet de contacter l'administrateur du site.");
        tipBoxes.add("N'hésitez pas à partager vos impressions ou vos idées d'amélioration !");

        asideHelp.put("tip", tipBoxes);
        asideHelp.put("info", infoBoxes);

        request.setAttribute("asideHelp", YaceUtils.getAsideHelp(asideHelp));

        request.setAttribute("pageTitle", "&Agrave; propos");
        request.getRequestDispatcher(VUE_ABOUT).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String senderName = request.getParameter("name");
        String senderMail = request.getParameter("email");
        String msgSubject = request.getParameter("subject");
        String msgContent = request.getParameter("msg");
        
        if(senderName != null && senderMail != null && msgSubject != null && msgContent != null && 
                !senderName.isEmpty() && !senderMail.isEmpty() && !msgSubject.isEmpty() && !msgContent.isEmpty()) {
            if(YaceUtils.isValidEmail(senderMail)) {
                try {
                    new EmailSender(
                            EmailSender.MAIL_TO_YACE,
                            EmailSender.MAIL_TO_YACE,
                            "[Message from a YaCE! user] " + msgSubject,
                            "Auteur: " + senderName + " <" + senderMail + ">\n\n" + msgContent
                        );

                    request.setAttribute("messageInfos", "Votre message a été envoyé.");
                } catch (RuntimeException e) {
                    request.setAttribute("messageError", "Erreur lors de l'envoi du message !<br/>" + e.getMessage());
                }
            } else {
                request.setAttribute("messageError", "Votre adresse email n'est pas valide !");
            }
        } else {
            request.setAttribute("messageError", "Vous devez remplir tous les champs !");
        }
        
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "A propos de Yace et de ses développeurs";
    }
}
