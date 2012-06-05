package net.yace.facade;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import net.yace.entity.Yrank;

@Stateless
public class YrankFacade extends AbstractFacade<Yrank> {
    @PersistenceContext(unitName = "Yace-ejbPU")
    private EntityManager em;

    protected EntityManager getEntityManager() {
        return em;
    }

    public YrankFacade() {
        super(Yrank.class);
    }
    
}
