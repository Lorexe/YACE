package net.yace.web.servlets.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.yace.entity.Yrank;
import net.yace.entity.Yuser;
import net.yace.facade.YrankFacade;
import net.yace.facade.YuserFacade;
import net.yace.web.utils.ServicesLocator;
import net.yace.web.utils.YaceUtils;

public class ServletUserMgmt extends HttpServlet {

    private final static String VUE_PRESENTATION = "welcome.jsp";
    private final static String VUE_GESTION_USERS = "WEB-INF/view/admin/utilisateurs.jsp";

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
        YaceUtils.SessionState state = YaceUtils.getSessionState(request);

        if (state == YaceUtils.SessionState.admin) {
            // Aide contextuelle
            Map<String, List<String>> asideHelp = new HashMap<String, List<String>>();

            List<String> infoBoxes = new ArrayList<String>();
            List<String> tipBoxes = new ArrayList<String>();

            infoBoxes.add("Sur cette page, vous pouvez éditer les informations de connexion des utilisateurs de Ya<em class='CE'>ce</em>, à l'exception du mot de passe.");
            infoBoxes.add("Vous pouvez aussi changer le grade d'un utilisateur, afin de l'élever à un rang d'administrateur, on simplement lui permettre de pouvoir enregistrer plus d'objets dans ses collections.");
            tipBoxes.add("N'hésitez pas à changer les informations de connexion d'un utilisateur s'il ne respecte pas les règles d'éthique en société.");
            tipBoxes.add("N'hésitez pas à supprimer un utilisateur qui partage de manière publique des collections choquantes. Les objets qu'il a enregistré sur le site seront automatiquement oubliés.");
            tipBoxes.add("N'hésitez pas à <a href='about'>nous contacter</a> si vous avez une suggestion à nous transmettre.");

            asideHelp.put("tip", tipBoxes);
            asideHelp.put("info", infoBoxes);

            request.setAttribute("asideHelp", YaceUtils.getAsideHelp(asideHelp));

            // On nomme et affiche la page
            request.setAttribute("pageTitle", "Gestion des utilisateurs - Administration du site");
            request.getRequestDispatcher(VUE_GESTION_USERS).forward(request, response);
        } else if (state == YaceUtils.SessionState.noauth) {
            request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
        } else {
            YaceUtils.displayAdminError(request, response);
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
         * "mode" : add, edit ou delete suivant l'opération
         * "id" : l'id de l'utilisateur (sauf pour le add)
         * "name" : nom de l'utilisateur
         * "email" : adresse email
         * "rank" : integer représentant l'id du rang
         * 
         * Attribut "error" : message d'erreur !
         */

        YaceUtils.SessionState state = YaceUtils.getSessionState(request);

        if (state == YaceUtils.SessionState.admin) {
            String mode = request.getParameter("mode");
            String id = request.getParameter("idYUSER");
            String pseudo = request.getParameter("pseudo");
            String email = request.getParameter("email");
            String rank = request.getParameter("rank");

            YuserFacade userFacade = ServicesLocator.getUserFacade();
            YrankFacade rankFacade = ServicesLocator.getRankFacade();            

            if (pseudo == null || pseudo.isEmpty()) {
                request.setAttribute("footDebug", "User name cannot be empty");
                request.setAttribute("error", "Le nom d'utilisateur ne peut pas être vide");
            } else if (pseudo.length() > 254) {
                request.setAttribute("footDebug", "User name cannot exceed 254 characters");
                request.setAttribute("error", "Le nom d'utilisateur est trop long (Max: 254 caractères)");
            } else if (email == null || email.isEmpty()) {
                request.setAttribute("footDebug", "User email cannot be empty");
                request.setAttribute("error", "Votre email ne peut pas être vide");
            } else if (email.length() > 254) {
                request.setAttribute("footDebug", "User email cannot exceed 254 characters");
                request.setAttribute("error", "Votre email est trop long (Max: 254 caractères)");
            } else if (!YaceUtils.isValidEmail(email)) {
                request.setAttribute("footDebug", "User email : Wrong format");
                request.setAttribute("error", "Votre email ne respecte pas le format standard");
            } else {
                if (mode.equals("edit")) {
                    try {
                        int userid = Integer.parseInt(id);

                        //Test données uniques
                        Yuser usermail = userFacade.findUser(email);
                        Yuser userpseudo = userFacade.findUser(pseudo);

                        if ((usermail != null && usermail.getIdYUSER() != userid) || (userpseudo != null && userpseudo.getIdYUSER() != userid)) {
                            request.setAttribute("footDebug","User name or email already used");
                            request.setAttribute("error", "Pseudo ou e-mail déjà utilisé");
                        } else {
                            Yuser user = userFacade.find(userid);
                            
                            HttpSession session = request.getSession();
                            Yuser sessionUser = (Yuser)session.getAttribute("user");

                            user.setPseudo(pseudo);
                            user.setEmail(email);

                            Yrank entrank = rankFacade.find(Integer.parseInt(rank));
                            if(sessionUser.getIdYUSER() == userid && !entrank.isAdmin()) {
                                request.setAttribute("footDebug","An administrator can't downgrade himself");
                                request.setAttribute("error", "Un administrateur ne peut pas abaisser son rang");
                                user.setRank(sessionUser.getRank());
                            } else {
                                user.setRank(entrank);
                            }

                            userFacade.edit(user);
                            
                            /*
                             * Si on se modifie soi-même => mise à jour en session
                             */
                            if(user.getIdYUSER() == sessionUser.getIdYUSER())
                                session.setAttribute("user", user);
                        }
                    } catch (NumberFormatException e) {
                        request.setAttribute("footDebug", "Wrong user ID");
                        request.setAttribute("error", "Erreur ID utilisateur");
                    }
                } else if (mode.equals("delete")) {
                    try {
                        Yuser user = userFacade.find(Integer.parseInt(id));
                        HttpSession session = request.getSession(false);
                        Yuser u = (Yuser) session.getAttribute("user");
//                        YcollectionFacade collFacade = ServicesLocator.getCollectionFacade();

                        if (u.getIdYUSER() == user.getIdYUSER()) {
                            request.setAttribute("footDebug", "One does not simply delete himself");
                            request.setAttribute("error", "Vous ne pouvez pas vous supprimer vous même !");
                        } 
//                        else if (collFacade.findAllFromUser(user.getIdYUSER()).size() > 0) {
//                            request.setAttribute("footDebug", "Guess who has a collection ?");
//                            request.setAttribute("error","Vous ne pouvez pas supprimer un utilisateur possédant une collection !");
//                        }
                        else {
                            userFacade.remove(user);
                        }
                    } catch (NumberFormatException e) {
                        request.setAttribute("footDebug", "Wrong user ID");
                        request.setAttribute("error", "Erreur ID utilisateur");
                    }
                }
            }
        }

        doGet(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Gestion des utilisateurs";
    }
}
