/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.facade;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.NoResultException;
import javax.persistence.Query;
import net.yace.entity.Yattribute;

/**
 *
 * @author Mikhail Pitchugin <mikael.pitchugin.isat@gmail.com>
 */
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
        query.setParameter("name", name);
        
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
    
    
    
}
