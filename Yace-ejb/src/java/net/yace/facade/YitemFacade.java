/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.facade;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.ejb.Stateless;
import javax.persistence.Query;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import net.yace.entity.Yattributevalue;
import net.yace.entity.Ycollection;
import net.yace.entity.Yitem;

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
    
}
