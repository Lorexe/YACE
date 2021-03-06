package net.yace.facade;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.NoResultException;
import javax.persistence.Query;
import net.yace.entity.Yattribute;
import net.yace.entity.Yitemtype;

@Stateless
public class YattributeFacade extends AbstractFacade<Yattribute> {
    @PersistenceContext(unitName = "Yace-ejbPU")
    private EntityManager em;

    protected EntityManager getEntityManager() {
        return em;
    }

    public YattributeFacade() {
        super(Yattribute.class);
    }
    
    //recherche par nom
    public Yattribute findAttribute(String name){
        Query query;
        query = em.createNamedQuery("Yattribute.findByName");
        query.setParameter("name", name);

        Yattribute type=null;
        try {
            type=(Yattribute)query.getSingleResult();
        } catch(NoResultException e) {
        }
        
        return type;
    }
    
    //liste des types, recherche par nom
    public List<Yattribute> findAttributes(String name)
    {
        List<Yattribute> attrList = null;//liste à retourner
        Query query;
        query = em.createNamedQuery("Yattribute.findByNameLike");
        query.setParameter("name", "%"+name+"%");
        
        try 
        {
            attrList = query.getResultList();
        }catch(NoResultException e){
        }
        
        return attrList;
    }
    
    //liste des attributs ayant un même type (enum)
    public List<Yattribute> findAttributesByType(String type)
    {
        List<Yattribute> attrList = null;//liste à retourner
        Query query;
        query = em.createNamedQuery("Yattribute.findByType");
        query.setParameter("type", type);
        
        try 
        {
            attrList = query.getResultList();
        }catch(NoResultException e){
        }
        
        return attrList;
    }
    
    // Liste les attributs d'un type d'objet
    public List<Yattribute> findAttributesByItem(Yitemtype itemtype) {
        Query query = em.createQuery("SELECT ya FROM Yattribute ya WHERE ya.itemtype = :itemtype");
        query.setParameter("itemtype", itemtype);
        
        return query.getResultList();
    }
}
