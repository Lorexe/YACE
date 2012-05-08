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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import net.yace.entity.User;

/**
 *
 * @author Developpeur
 */
@Stateless
public class UserSessionBean {

    @PersistenceContext
    EntityManager em;

    public List<User> retrieve()
    {
        Query query = em.createNamedQuery("User.findAll");
        return query.getResultList();
    }
    
    public User getUser(String login) {
        Query query = em.createNamedQuery("User.findByEmail");
        query.setParameter("email", login);

        User u=null;
        try {
            u=(User)query.getSingleResult();
        } catch(NoResultException e) {
        }
        
        return u;
    }
        
    public User update(User u)
    {
        return em.merge(u);
    }
    
    public void insert(User u) throws EntityExistsException, IllegalArgumentException {
        em.persist(u);
        em.flush();
    }
    
    private Message createJMSMessageForjmsNotificationQueue(Session session, Object messageData) throws JMSException {
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
