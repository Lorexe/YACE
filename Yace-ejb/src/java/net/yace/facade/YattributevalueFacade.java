/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.facade;

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import net.yace.entity.Yattributevalue;
import net.yace.entity.Yitem;
import net.yace.entity.Yitemtype;

/**
 *
 * @author Mikhail Pitchugin <mikael.pitchugin.isat@gmail.com>
 */
@Stateless
public class YattributevalueFacade extends AbstractFacade<Yattributevalue> {

    @PersistenceContext(unitName = "Yace-ejbPU")
    private EntityManager em;

    protected EntityManager getEntityManager() {
        return em;
    }

    public YattributevalueFacade() {
        super(Yattributevalue.class);
    }

    public List<Yattributevalue> findAllValuesForItem(Yitemtype itemtype, Yitem item) {
        List<Yattributevalue> tList = null;
        Query query = em.createQuery("SELECT yatv FROM yattributevalue yatv WHERE yatv.attribute IN (SELECT idYATTRIBUTE FROM yattribute yat WHERE itemtype = :itemtype) AND yatv.idYATTRIBUTEVALUE IN (SELECT lnk.value FROM link_attr_item lnk WHERE lnk.item = :item)");
        query.setParameter("itemtype", itemtype);
        query.setParameter("item", item);

        try {
            tList = query.getResultList();
        } catch (NoResultException e) {
        }

        return tList;
    }
}
