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
import java.util.regex.Pattern;
import javax.ejb.Stateless;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import net.yace.entity.Yuser;

/**
 *
 * @author Jérôme Scohy <pyaitchpi@acdc.me>
 */
@Stateless
public class YuserSessionBean {

    @PersistenceContext
    EntityManager em;

    public List<Yuser> retrieve()
    {
        Query query = em.createNamedQuery("Yuser.findAll");
        return query.getResultList();
    }
    
    public Yuser getYuser(String login) {
        Query query;
        if(Pattern.matches("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", login)) {
            query = em.createNamedQuery("Yuser.findByEmail");
            query.setParameter("email", login);
        }
        else {
            query = em.createNamedQuery("Yuser.findByPseudo");
            query.setParameter("pseudo", login);
        }

        Yuser u=null;
        try {
            u=(Yuser)query.getSingleResult();
        } catch(NoResultException e) {
        }
        
        return u;
    }
        
    public Yuser update(Yuser u)
    {
        return em.merge(u);
    }
    
    public void insert(Yuser u) throws EntityExistsException, IllegalArgumentException {
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
            s = conn.createSession(false, Session.AUTO_ACKNOWLEDGE);
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
