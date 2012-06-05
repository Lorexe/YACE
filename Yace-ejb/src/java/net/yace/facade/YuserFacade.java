package net.yace.facade;

import java.util.regex.Pattern;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import net.yace.entity.Yuser;

@Stateless
public class YuserFacade extends AbstractFacade<Yuser> {
    @PersistenceContext(unitName = "Yace-ejbPU")
    private EntityManager em;

    protected EntityManager getEntityManager() {
        return em;
    }

    public YuserFacade() {
        super(Yuser.class);
    }
    
    public Yuser findUser(String login) {
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
}
