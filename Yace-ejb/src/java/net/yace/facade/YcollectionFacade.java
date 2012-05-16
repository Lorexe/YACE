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
import net.yace.entity.Ycollection;

/**
 *
 * @author Mikhail Pitchugin <mikael.pitchugin.isat@gmail.com>
 */
@Stateless
public class YcollectionFacade extends AbstractFacade<Ycollection> {
    @PersistenceContext(unitName = "Yace-ejbPU")
    private EntityManager em;

    protected EntityManager getEntityManager() {
        return em;
    }

    public YcollectionFacade() {
        super(Ycollection.class);
    }
    
    
    //recherche par theme
    public Ycollection findCollection(String theme){
        Query query;
        query = em.createNamedQuery("Ycollection.findByTheme");
        query.setParameter("theme", theme);

        Ycollection coll=null;
        try {
            coll=(Ycollection)query.getSingleResult();
        } catch(NoResultException e) {
        }
        
        return coll;
    }
    
    //recherche des collections ayant un theme similaire
    public List<Ycollection> findCollections(String theme)
    {
        List<Ycollection> cList = null;//liste à retourner
        Query query;
        query = em.createNamedQuery("Ycollection.findAllThemesLike");
        query.setParameter("theme", theme);
        
        try 
        {
            cList = query.getResultList();
        }catch(NoResultException e){
        }
        
        return cList;
    }
    
}
