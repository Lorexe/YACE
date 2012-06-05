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

    public List<Yattributevalue> findAllValuesForItem(Yitem item) {
        List<Yattributevalue> tList = null;
        Query query = em.createQuery("SELECT av FROM Yitem y JOIN y.yattributevalueCollection av JOIN av.attribute a WHERE y.idYITEM = :idYITEM ORDER BY a.noOrder");
        //SELECT yatv FROM Yattributevalue yatv WHERE yatv.attribute IN (SELECT idYATTRIBUTE FROM Yattribute yat WHERE itemtype = :itemtype) AND yatv.idYATTRIBUTEVALUE IN (SELECT lnk.value FROM link_attr_item lnk WHERE lnk.item = :item)
        //query.setParameter("itemtype", itemtype);//yitemtype inutile ici
        query.setParameter("idYITEM", item.getIdYITEM());

        try {
            tList = query.getResultList();
        } catch (NoResultException e) {
        }

        return tList;
    }
}
