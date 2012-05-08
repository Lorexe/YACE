<%-- 
    Document   : connecte.jsp
    Created on : 14 déc. 2011, 10:55:44
    Author     : Developpeur
--%>

<%@page import="net.yace.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Connecté</title>
    </head>
    <body>
        <% 
        HttpSession sess = request.getSession(false);
        if(sess != null) {
        %>
        <h1>Vous êtes connecté</h1>
        <p>ID: <%= ((User)sess.getAttribute("user")).toString() %></p>
        <p>Email: <%= ((User)sess.getAttribute("user")).getEmail() %></p>
        <%
        } else {
        %>
        <h1>Vous n'êtes pas connecté</h1>
        <%
        }       
               }
        %>
    
    
    </body>
</html>
