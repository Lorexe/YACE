package net.yace.facade;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.NoResultException;
import javax.persistence.Query;
import net.yace.entity.Ycollection;

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
    
    //recherche par Id
    public Ycollection find(int id){
        Query query;
        query = em.createNamedQuery("Ycollection.findByIdYCOLLECTION");
        query.setParameter("idYCOLLECTION", id);

        Ycollection coll=null;
        try {
            coll=(Ycollection)query.getSingleResult();
        } catch(NoResultException e) {
        }
        
        return coll;
    }
    
    
    //recherche par theme
    public Ycollection find(String theme){
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
    public List<Ycollection> findAll(String theme)
    {
        List<Ycollection> cList = null;//liste à retourner
        Query query;
        query = em.createNamedQuery("Ycollection.findAllThemesLike");
        query.setParameter("theme", "%"+theme+"%");//ajout des "%" pour le LIKE
        
        try 
        {
            cList = query.getResultList();
        }catch(NoResultException e){
        }
        
        return cList;
    }
    
    public List<Ycollection> findAllPublic(String theme)
    {
        List<Ycollection> cList = null;//liste à retourner
        Query query;
        query = em.createNamedQuery("Ycollection.findAllPublicThemes");
        query.setParameter("theme", "%"+theme+"%");
        
        try 
        {
            cList = query.getResultList();
        }catch(NoResultException e){
        }
        
        return cList;
    }
    
    public List<Ycollection> findAllPublicFromUser(int id) {
        List<Ycollection> cList = null;//liste à retourner
        Query query;
        query = em.createNamedQuery("Ycollection.findAllPublicFromUser");
        query.setParameter("idYUSER", id);
        
        try 
        {
            cList = query.getResultList();
        }catch(NoResultException e){
        }
        
        return cList;
    }
    
    public List<Ycollection> findAllFromUser(int id) {
        List<Ycollection> cList = null;//liste à retourner
        Query query;
        query = em.createNamedQuery("Ycollection.findAllFromUser");
        query.setParameter("idYUSER", id);
        
        try 
        {
            cList = query.getResultList();
        }catch(NoResultException e){
        }
        
        return cList;
    }
    
    //recherche collections par itemtype des items
    public List<Ycollection> findAllByItemType(String type)
    {
        List<Ycollection> cList = null;//liste à retourner
        Query query;
        query = em.createNamedQuery("Ycollection.findAllPublicByItemType");
        query.setParameter("name", "%"+type+"%");
        
        try 
        {
            cList = query.getResultList();
        }catch(NoResultException e){
        }
        
        return cList;
    }
    
    public List<Ycollection> findFromUserByItemType(String type, int id)
    {
        List<Ycollection> cList = null;//liste à retourner
        Query query;
        query = em.createNamedQuery("Ycollection.findPubFromUserByYIT");
        query.setParameter("name", "%"+type+"%");
        query.setParameter("idYUSER", id);
        
        try 
        {
            cList = query.getResultList();
        }catch(NoResultException e){
        }
        
        return cList;
    }
    
    //recherche des collections dont les yattributevalue des items contiennent le terme recherché
    public List<Ycollection> findAllByAttrValues(String search)
    {
        List<Ycollection> cList = null;//liste à retourner
        Query query;
        query = em.createNamedQuery("Ycollection.findAllByAttrValues");
        query.setParameter("search", "%"+search+"%");
        
        try 
        {
            cList = query.getResultList();
        }catch(NoResultException e){
        }
        
        return cList;
    }
    
}
