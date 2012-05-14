package net.yace.mdb;

import java.util.logging.Level;
import java.util.logging.Logger;
import net.yace.entity.Yuser;
import javax.ejb.ActivationConfigProperty;
import javax.ejb.MessageDriven;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.ObjectMessage;

/**
 *
 * @author Developpeur
 */
@MessageDriven(mappedName = "jms/NotificationQueue", activationConfig = {
    @ActivationConfigProperty(propertyName = "acknowledgeMode", propertyValue = "Auto-acknowledge"),
    @ActivationConfigProperty(propertyName = "destinationType", propertyValue = "javax.jms.Queue")
})
public class NotificationBean implements MessageListener {
    
    public NotificationBean() {
    }
    
    @Override
    public void onMessage(Message message) {
        try
        {
            Object msgObj = ((ObjectMessage)message).getObject();
            if (msgObj != null)
            {
                Yuser u = (Yuser)msgObj;
                System.out.println("User has been updated:");
                StringBuilder sb = new StringBuilder();
                sb.append("User ID=");
                sb.append(u.getIdYUSER());
                sb.append(", ");
                sb.append("Login=");
                sb.append(u.getEmail());
                System.out.println(sb.toString());
            }
        }
        catch (JMSException ex)
        {
            Logger.getLogger(NotificationBean.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
