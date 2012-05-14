package net.yace.web.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.yace.entity.Yrank;
import net.yace.entity.Yuser;
import net.yace.facade.YuserFacade;
import net.yace.utils.MD5Utils;
import net.yace.web.utils.ServicesLocator;

/**
 *
 * @author Scohy Jerome
 * @author Boi Bruno
 */
public class ServletRegister extends HttpServlet {
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ServletRegister</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ServletRegister at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
             */
        } finally {
            out.close();
        }
    }

    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
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
        String email = request.getParameter("email");
        String pass = request.getParameter("pwd");
        String passVerif = request.getParameter("pwd-verif");

        // Test des champs
        if (pseudo == null || pseudo.isEmpty()) {
            request.setAttribute("error", "Vous devez choisir<br/>un pseudo !");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else if (email == null || email.isEmpty() || !Pattern.matches("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", email)) {
            request.setAttribute("error", "Vous devez indiquer<br/>un email valide !");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else if (pass == null || passVerif == null || pass.isEmpty() || passVerif.isEmpty() || !pass.equals(passVerif)) {
            request.setAttribute("error", "Vous devez indiquer deux fois<br/>le même mot de passe !");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else {
            // Chargement de la facade
            YuserFacade userFacade = ServicesLocator.getUserFacade();

            // Reste à tester que l'utilisateur n'existe pas déjà
            Yuser userTest = userFacade.findUser(email);
            if (userTest != null) { // Utilisateur existant !
                request.setAttribute("error", "Email déjà utilisé.<br/>Veuillez indiquer un autre.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            } else {
                userTest = userFacade.findUser(pseudo);
                if (userTest != null) { // Utilisateur existant !
                    request.setAttribute("error", "Pseudo déjà pris.<br/>Veuillez en choisir un autre.");
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                } else { // Tout est OK pour l'enregistrement
                    Yuser u = new Yuser();
                    u.setPseudo(pseudo);
                    u.setEmail(email);
                    u.setPasswordHash(MD5Utils.digest(pass));
                    u.setRank(new Yrank(1)); //TODO : récupérer le rang par défaut

                    userFacade.create(u);

                    request.setAttribute("info", "Le compte a été créé.<br/>Vous pouvez vous connecter.");
                    request.getRequestDispatcher("login").forward(request, response);
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
        return "Enregistre un membre dans la BDD";
    }
}
