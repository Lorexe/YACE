/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.web.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.yace.entity.Yuser;
import net.yace.facade.YuserFacade;
import net.yace.utils.MD5Utils;
import net.yace.web.utils.ServicesLocator;

/**
 *
 * @author Developpeur
 */
public class ServletLogin extends HttpServlet {
    
    private final static String VUE_PRESENTATION = "welcome.jsp";
    private final static String VUE_HOME = "WEB-INF/view/user/home.jsp";

    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        if(session==null) {
            request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
        } else {
            Yuser yuser = (Yuser)session.getAttribute("user");
            if(yuser==null) {
                //request.setAttribute("error", "Session invalide");
                request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
            } else {
                request.setAttribute("pageTitle", "Page d'accueil");
                request.getRequestDispatcher(VUE_HOME).forward(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupération du formulaire
        String pseudo = request.getParameter("pseudo");
        String pass = request.getParameter("pwd");
        
        // Test des champs
        if(pseudo==null || pseudo.isEmpty()) {
            request.setAttribute("error", "Vous devez entrer<br/>un pseudo !");
            request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
        }
        else if(pass==null || pass.isEmpty()) {
            request.setAttribute("error", "Vous devez entrer<br/>un mot de passe !");
            request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
        } else {
            // Chargement de la facade
            YuserFacade userFac = ServicesLocator.getUserFacade();
            Yuser u = userFac.findUser(pseudo);
            
            // Reste à tester les infos de connexion
            if(u==null) {
                request.setAttribute("error", "Utilisateur introuvable");
                request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
            } else {
                if(!u.getPasswordHash().equals(MD5Utils.digest(pass))) {
                    request.setAttribute("error", "Mauvais mot de passe");
                    request.getRequestDispatcher(VUE_PRESENTATION).forward(request, response);
                } else {
                    // Tout est OK, on crée la session
                    HttpSession session = request.getSession();
                    session.setAttribute("user", u);
                    
                    // On nomme et affiche la page
                    request.setAttribute("pageTitle", "Page d'accueil");
                    request.getRequestDispatcher(VUE_HOME).forward(request, response);
                }
            }
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Connecte un utilisateur";
    }// </editor-fold>
}
