package net.yace.web.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.yace.entity.Yuser;
import net.yace.facade.YuserFacade;
import net.yace.web.utils.ServicesLocator;
import net.yace.web.utils.YaceUtils;

public class ServletProfile extends HttpServlet {
    
    private final static String VUE_PRESENTATION = "welcome.jsp";
    private final static String VUE_USER_PROFILE = "WEB-INF/view/user/user-profil.jsp";
    
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

                infoBoxes.add("Sur cette page, vous pouvez redéfinir vos informations de connexion à Ya<em class='CE'>ce</em>.");
                tipBoxes.add("Renforcez votre mot de passe en y faisant figurer des caractères accentués ou spéciaux (p. ex. $£µ*%<>./+-).");
                tipBoxes.add("N'hésitez pas à <a href='about'>nous contacter</a> si vous avez une suggestion à nous transmettre.");

                asideHelp.put("tip", tipBoxes);
                asideHelp.put("info", infoBoxes);

                request.setAttribute("asideHelp", YaceUtils.getAsideHelp(asideHelp));

                // On nomme et affiche la page
                request.setAttribute("pageTitle", "Profil de "+yuser.getPseudo());
                request.getRequestDispatcher(VUE_USER_PROFILE).forward(request, response);
            }
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
                
                // Récupération du formulaire
                String pseudo = request.getParameter("pseudo");
                String email = request.getParameter("email");
                String newPass = request.getParameter("newpwd");
                String newPassVerif = request.getParameter("newpwd-verif");
                String pass = request.getParameter("pwd");
                
                if (pass == null || pass.isEmpty()) {
                    request.setAttribute("error", "Vous devez entrer votre mot de passe actuel pour continuer");
                } else if (!yuser.getPasswordHash().equals(YaceUtils.digestMD5(pass))) {
                    request.setAttribute("error", "Votre mot de passe actuel n'est pas valide");
                } else if (pseudo == null || pseudo.isEmpty()) {
                    request.setAttribute("error", "Vous devez entrer un nom d'utilisateur");
                } else if (email == null || email.isEmpty() || !Pattern.matches("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", email)) {
                    request.setAttribute("error", "Vous devez entrer une adresse email valide");
                } else if (newPass != null && newPassVerif != null && !newPass.isEmpty() && !newPassVerif.isEmpty() && !newPass.equals(newPassVerif)) {
                    request.setAttribute("error", "Vous devez indiquer deux fois le même nouveau mot de passe");
                } else {
                    // Reste à tester que les infos ne sont pas déjà utilisées par un autre user
                    YuserFacade userFacade = ServicesLocator.getUserFacade();
                    Yuser usermail = userFacade.findUser(email);
                    Yuser userpseudo = userFacade.findUser(pseudo);
                    if ((usermail!=null && usermail.getIdYUSER()!=yuser.getIdYUSER()) || (userpseudo!=null && userpseudo.getIdYUSER()!=yuser.getIdYUSER())) { // Utilisateur existant !
                        request.setAttribute("error", "Email ou pseudo déjà utilisé. Veuillez en indiquer un autre.");
                    } else { // Tout est OK pour l'enregistrement
                        yuser.setEmail(email);
                        yuser.setPseudo(pseudo);
                        if(newPass != null && newPassVerif != null && !newPass.isEmpty() && !newPassVerif.isEmpty() && newPass.equals(newPassVerif)){
                            yuser.setPasswordHash(YaceUtils.digestMD5(newPass));
                        }
                        userFacade.edit(yuser);
                    }
                }
                
                // Aide contextuelle
                Map<String, List<String>> asideHelp = new HashMap<String, List<String>>();

                List<String> infoBoxes = new ArrayList<String>();
                List<String> tipBoxes = new ArrayList<String>();

                infoBoxes.add("Sur cette page, vous pouvez redéfinir vos informations de connexion à Ya<em class='CE'>ce</em>.");
                tipBoxes.add("Renforcez votre mot de passe en y faisant figurer des caractères accentués ou spéciaux (p. ex. $£µ*%<>./+-).");
                tipBoxes.add("N'hésitez pas à <a href='about'>nous contacter</a> si vous avez une suggestion à nous transmettre.");

                asideHelp.put("tip", tipBoxes);
                asideHelp.put("info", infoBoxes);

                request.setAttribute("asideHelp", YaceUtils.getAsideHelp(asideHelp));

                // On nomme et affiche la page
                request.setAttribute("pageTitle", "Profil de "+yuser.getPseudo());
                request.getRequestDispatcher(VUE_USER_PROFILE).forward(request, response);
            }
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Profile edition";
    }
}
