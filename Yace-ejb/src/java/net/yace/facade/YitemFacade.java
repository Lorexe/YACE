package net.yace.facade;

import java.util.ArrayList;
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
import net.yace.entity.Yuser;

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
        Query query = em.createQuery("SELECT yit FROM Yitem yit JOIN yit.type yt WHERE yit.collection = :collection AND yt = :type");
        List<Yitem> tList = null;
        query.setParameter("collection", collection);
        query.setParameter("type", type);
        
        try {
            tList = query.getResultList();
        } catch (NoResultException e) {
            
        }
        
        return tList;
    }
    
    public List<Yitem> findAll(Ycollection collection)
    {
        List<Yitem> cList = null;//liste à retourner
        Query query;
        query = em.createNamedQuery("Yitem.findAllFromCollection");
        query.setParameter("collection", collection);
        
        try 
        {
            cList = query.getResultList();
        }catch(NoResultException e){
        }
        
        return cList;
    }
    
    //fonction de recherche de base sur les attributevalue
    //retourne une liste des items publics dont les atributevalues contiennent "search"
    //pour désactiver la limitation sur le nombre des résultats mettre size à 0 
    public List<Yitem> getItemsByAttrValues(String search, int size, int first)
    {
        search = search.toLowerCase();
        List<Yitem> cList = null;//liste à retourner
        Query query;
        query = em.createNamedQuery("Yitem.findItemsByAttrValues");
        
        //si on a passe un nombre des résultats à aficher correct
        //sinon pas de limitation
        if(size != 0)
        {
            query.setFirstResult(first);
            query.setMaxResults(size);
        }
        query.setParameter("search", "%"+search+"%");
        
        try 
        {
            cList = query.getResultList();
        }catch(NoResultException e){
        }
        
        return cList;
    }
    
    
    //retourne une liste des items de yuser dont les atributevalues contiennent "search"
    //pour désactiver la limitation sur le nombre des résultats mettre size à 0
    public List<Yitem> getItemsSearchFromUser(String search, Yuser yuser, int size, int first)
    {
        search = search.toLowerCase();
        List<Yitem> cList = null;//liste à retourner
        Query query;
        query = em.createNamedQuery("Yitem.findItemsFromUser");
        
        //si on a passe un nombre des résultats à aficher correct
        //sinon pas de limitation
        if(size != 0)
        {
            query.setFirstResult(first);
            query.setMaxResults(size);
        }
        query.setParameter("search", "%"+search+"%");
        query.setParameter("yuser", yuser);
        
        try 
        {
            cList = query.getResultList();
        }catch(NoResultException e){
        }
        
        return cList;
    }
    
    public int countNbItemsFromUuser(Yuser user) {
        List<Yitem> listItems = new ArrayList<Yitem>();
        
        Query query = em.createNamedQuery("Yitem.findAllItemsFromUser");
        query.setParameter("yuser", user);
        
        listItems = query.getResultList();
        
        return listItems.size();
    }
    
    //retourne une liste des items de yuser dont les atributevalues contiennent "search"
    //pour désactiver la limitation sur le nombre des résultats mettre size à 0
    public List<Yitem> getItemsInColl(String search, Ycollection coll, Yuser yuser, int size, int first)
    {
        search = search.toLowerCase();
        List<Yitem> cList = null;//liste à retourner
        Query query;
        query = em.createNamedQuery("Yitem.findItemsInColl");
        
        //si on a passe un nombre des résultats à aficher correct
        //sinon pas de limitation
        if(size != 0)
        {
            query.setFirstResult(first);
            query.setMaxResults(size);
        }
        
        query.setParameter("search", "%"+search+"%");
        query.setParameter("coll", coll);
        query.setParameter("yuser", yuser);
        
        try 
        {
            cList = query.getResultList();
        }catch(NoResultException e){
        }
        
        return cList;
    }
    
}
