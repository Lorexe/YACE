/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.facade;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import net.yace.entity.Ysetting;

/**
 *
 * @author MaBoy <bruno.boi@student.helha.be>
 */
@Stateless
public class YsettingFacade extends AbstractFacade<Ysetting> {

    @PersistenceContext(unitName = "Yace-ejbPU")
    private EntityManager em;

    protected EntityManager getEntityManager() {
        return em;
    }

    public YsettingFacade() {
        super(Ysetting.class);
    }
}
