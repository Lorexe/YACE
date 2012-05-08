/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.web.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.yace.ejb.UserSessionBean;
import net.yace.entity.User;

/**
 *
 * @author Developpeur
 */
public class ServletRegister extends HttpServlet {

    @EJB
    private UserSessionBean userSessionBean;
    
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
        //processRequest(request, response);
        
        String login = request.getParameter("login");
        String pass = request.getParameter("pwd");
        String passVerif = request.getParameter("pwd-verif");

        if(login!=null && pass!=null && passVerif!=null && !login.isEmpty() && !pass.isEmpty() && !passVerif.isEmpty() && pass.equals(passVerif)) {       
            User userTest= userSessionBean.getUser(login);
            //User userTest = null;
            if(userTest==null) {
                User u = new User();
                u.setEmail(login);
                u.setPasswordHash(pass);
                u.setRankID(0);

                userSessionBean.insert(u);
                
                request.setAttribute("info", "Le compte a été créé.<br/>Vous pouvez vous connecter.");
                request.getRequestDispatcher("ServletLogin").forward(request, response);
            } else {
                request.setAttribute("error", "L'utilisateur existe déjà !");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Il faut remplir tous les champs!");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }   
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Enregistre un membre";
    }
}
