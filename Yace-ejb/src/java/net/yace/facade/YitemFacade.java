/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.facade;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.Query;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import net.yace.entity.Yattributevalue;
import net.yace.entity.Ycollection;
import net.yace.entity.Yitem;
import net.yace.entity.Yitemtype;

/**
 *
 * @author Mikhail Pitchugin <mikael.pitchugin.isat@gmail.com>
 */
@Stateless
public class YitemFacade extends AbstractFacade<Yitem> {
    @PersistenceContext(unitName = "Yace-ejbPU")
    private EntityManager em;

    protected EntityManager getEntityManager() {
        return em;
    }

    public YitemFacade() {
        super(Yitem.class);
    }
    
    //retourne une Liste contenant attrValue de l'item avec itId, trié en fonction du noOrder de leur yattribute
    public List<Yattributevalue> getItemsAttrValues(int itId)
    {
        List<Yattributevalue> cList = null;//liste à retourner
        Query query;
        query = em.createNamedQuery("Yitem.findAllAttrValues");
        query.setParameter("idYITEM", itId);
        
        try 
        {
            cList = query.getResultList();
        }catch(NoResultException e){
        }
        
        return cList;
    }
    
    public List<Yitem> getItemsByCollectionAndType(Ycollection collection, Yitemtype type)
    {
        Query query = em.createQuery("SELECT yit FROM yitem yit WHERE collection = :collection AND type = :type");
        List<Yitem> tList = null;
        query.setParameter("collection", collection);
        query.setParameter("type", type);
        
        try {
            tList = query.getResultList();
        } catch (NoResultException e) {
            
        }
        
        return tList;
    }
    
    //fonction de recherche de base sur les attributevalue
    //retourne une liste des items d'une collection publique, dont les atributs contiennent "search"
    public List<Yitem> getItemsByAttrValues(String search)
    {
        search = search.toLowerCase();
        List<Yitem> cList = null;//liste à retourner
        Query query;
        query = em.createNamedQuery("Yitem.findItemsByAttrValues");
        query.setParameter("search", "%"+search+"%");
        
        try 
        {
            cList = query.getResultList();
        }catch(NoResultException e){
        }
        
        return cList;
    }
    
}
