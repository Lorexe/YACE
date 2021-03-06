package net.yace.facade;

import java.util.ArrayList;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.Query;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.NoResultException;
import net.yace.entity.Ycollection;
import net.yace.entity.Yitemtype;

@Stateless
public class YitemtypeFacade extends AbstractFacade<Yitemtype> {

    @PersistenceContext(unitName = "Yace-ejbPU")
    private EntityManager em;

    protected EntityManager getEntityManager() {
        return em;
    }

    public YitemtypeFacade() {
        super(Yitemtype.class);
    }

    //recherche par nom
    public Yitemtype findItemType(String name) {
        Query query;
        query = em.createNamedQuery("Yitemtype.findByName");
        query.setParameter("name", name);

        Yitemtype type = null;
        try {
            type = (Yitemtype) query.getSingleResult();
        } catch (NoResultException e) {
        }

        return type;
    }

    //liste des types, recherche par nom
    public List<Yitemtype> findItemTypes(String name) {
        List<Yitemtype> tList = null;//liste à retourner
        Query query;
        query = em.createNamedQuery("Yitemtype.findAllTypesLike");
        query.setParameter("name", "%" + name + "%");

        try {
            tList = query.getResultList();
        } catch (NoResultException e) {
        }

        return tList;
    }

    public List<Yitemtype> findItemtypesInCollection(Ycollection collection) {
        List<Yitemtype> tList = null;
        Query query;
        query = em.createNamedQuery("Yitemtype.findAllInCollection");
        query.setParameter("idYCOLLECTION", collection.getIdYCOLLECTION());

        try {
            tList = query.getResultList();
        } catch (NoResultException e) {
        }
        
        return tList;
    }
    
    public List<Yitemtype> findItemtypesPublic() {
        List<Yitemtype> tList = null;
        Query query;
        query = em.createNamedQuery("Yitemtype.findAllItemtypePublic");
        
        try {
            tList = query.getResultList();
        } catch (NoResultException e) {
        }

        return tList;
    }
    
    public List<Yitemtype> findItemtypesWithoutItem(Ycollection collection) {
        List<Yitemtype> tList = null;
        Query query;
        query = em.createNamedQuery("Yitemtype.findWithoutItem");
        query.setParameter("idYCOLLECTION", collection.getIdYCOLLECTION());

        try {
            tList = query.getResultList();
        } catch (NoResultException e) {
        }
        
        return tList;
    }
}
