/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.ejb;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.naming.NamingException;
import net.yace.entity.User;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author MaBoy
 * @author Lorexe
 */
@Stateless
@LocalBean
public class UserSessionBean {

    @PersistenceContext
    private EntityManager em;

    /**
     * Returns a list of Customer objects in the database
     * @return List<Customer>
     */
    public List<User> retrieve()
    {
        Query query = em.createNamedQuery("User.findAll");
        return query.getResultList();
    }

    /**
     * Update the customer record
     * @param customer object to be updated
     * @return Customer
     */
    public User update(User u)
    {
        return em.merge(u);
    }
    
    
    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")

    private Message createJMSMessageForjmsNotificationQueue(Session session, Object messageData) throws JMSException {
        // TODO create and populate message to send
        TextMessage tm = session.createTextMessage();
        tm.setText(messageData.toString());
        return tm;
    }

    private void sendJMSMessageToNotificationQueue(Object messageData) throws NamingException, JMSException {
        Context c = new InitialContext();
        ConnectionFactory cf = (ConnectionFactory) c.lookup("java:comp/env/jms/NotificationQueueFactory");
        Connection conn = null;
        Session s = null;
        try {
            conn = cf.createConnection();
            s = conn.createSession(false, s.AUTO_ACKNOWLEDGE);
            Destination destination = (Destination) c.lookup("java:comp/env/jms/NotificationQueue");
            MessageProducer mp = s.createProducer(destination);
            mp.send(createJMSMessageForjmsNotificationQueue(s, messageData));
        } finally {
            if (s != null) {
                try {
                    s.close();
                } catch (JMSException e) {
                    Logger.getLogger(this.getClass().getName()).log(Level.WARNING, "Cannot close session", e);
                }
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
    
}
