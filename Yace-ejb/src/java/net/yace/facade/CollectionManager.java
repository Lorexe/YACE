/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.facade;

import javax.annotation.Resource;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;
import javax.ejb.SessionContext;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;

import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import net.yace.entity.*;

/**
 *
 * @author Mikhail Pitchugin <mikael.pitchugin.isat@gmail.com>
 * 
 * classe en developpement
 * methodes de travail sur les collections
 */
@Stateless
@LocalBean
@TransactionManagement(TransactionManagementType.CONTAINER)
public class CollectionManager {
    @PersistenceContext(unitName = "Yace-ejbPU")
    private EntityManager em;
    @Resource
    private SessionContext context;
    
    
    
    //ajout de collection
    public void addCollection(Yuser user, String theme, boolean isPublic)
    {
        Ycollection coll = new Ycollection();
        coll.setOwner(user);
        coll.setTheme(theme);
        
        //temp section, à modifier
        byte[] btab = new byte[1];
        btab[0] = 0;
        coll.setIsPublic(btab);
        
        //mettre le resultat dans la db
        em.persist(coll);
    }
    
    //bloc de creation de Yitemtype et de ses Yattribute
    //Parametre pour recevoir la liste des Yattribute
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void createYitemtype(String name)
    {
        try {
            //creer Yitemtype
            Yitemtype ytype = addYitemtype(name);
            //ajouter si necessaire elements dans link_types
            
            //creer les Yattribute de Yitemtype
            //ajouter les params descriptifs
            //
            //prevoir une boucle
            addYattribute(ytype);
            
        } catch (Exception e) {
            context.setRollbackOnly();
        }
    }
    
    //ajoute un Yitemtype
    public Yitemtype addYitemtype(String name)
    {
        Yitemtype ytype = new Yitemtype();
        ytype.setName(name);
        
        em.persist(ytype);
        return ytype;
    }
    
    public void addYattribute(Yitemtype ytype)
    {
        Yattribute attr = new Yattribute();
        attr.setItemtype(ytype);
        
        //set des autres params
        /*attr.setName(null);
        attr.setNoOrder(0);
        attr.setType(null);
        attr.setMany(null);*/
        
        
        em.persist(attr);
    }
    
}
