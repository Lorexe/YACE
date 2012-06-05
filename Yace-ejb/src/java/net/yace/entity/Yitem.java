/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Mikhail Pitchugin <mikael.pitchugin.isat@gmail.com>
 */
@Entity
@Table(name = "yitem")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Yitem.findAll", query = "SELECT y FROM Yitem y"),
    @NamedQuery(name = "Yitem.findAllFromCollection", query = "SELECT y FROM Yitem y WHERE y.collection = :collection"),
    @NamedQuery(name = "Yitem.findByIdYITEM", query = "SELECT y FROM Yitem y WHERE y.idYITEM = :idYITEM"),
    @NamedQuery(name = "Yitem.findAllAttrValues", query = "SELECT av FROM Yitem y JOIN y.yattributevalueCollection av JOIN av.attribute a WHERE y.idYITEM = :idYITEM ORDER BY a.noOrder"),
    @NamedQuery(name = "Yitem.findItemsByAttrValues", 
        query = "SELECT DISTINCT y FROM Yitem y "
        + "JOIN y.collection col "
        + "JOIN y.yattributevalueCollection av "
        + "JOIN av.attribute ya "
        + "WHERE (col.isPublic = true) AND (ya.type NOT IN ('Image','URL')) AND (LOWER(av.valStr) LIKE :search) ORDER BY col.theme"),
    @NamedQuery(name = "Yitem.findItemsFromUser", 
        query = "SELECT DISTINCT yi FROM Yuser y "
        + "JOIN y.ycollectionCollection yc "
        + "JOIN yc.yitemCollection yi "
        + "JOIN yi.yattributevalueCollection yav "
        + "JOIN yav.attribute ya "
        + "WHERE y = :yuser AND (ya.type NOT IN ('Image','URL')) AND (LOWER(yav.valStr) LIKE :search) ORDER BY yc.theme"),
    @NamedQuery(name = "Yitem.findItemsInColl", 
        query = "SELECT DISTINCT yi FROM Ycollection yc "
        + "JOIN yc.owner y "
        + "JOIN yc.yitemCollection yi "
        + "JOIN yi.yattributevalueCollection yav "
        + "JOIN yav.attribute ya "
        + "WHERE yc = :coll AND (y = :yuser OR yc.isPublic = true) AND (ya.type NOT IN ('Image','URL')) AND (LOWER(yav.valStr) LIKE :search) ORDER BY yc.theme"),
    @NamedQuery(name = "Yitem.findAllItemsFromUser", 
        query = "SELECT DISTINCT yi FROM Yuser y "
        + "JOIN y.ycollectionCollection yc "
        + "JOIN yc.yitemCollection yi "
        + "WHERE y = :yuser")})
public class Yitem implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idYITEM")
    private Integer idYITEM;
    @JoinTable(name = "link_attr_item", joinColumns = {
        @JoinColumn(name = "item", referencedColumnName = "idYITEM")}, inverseJoinColumns = {
        @JoinColumn(name = "value", referencedColumnName = "idYATTRIBUTEVALUE")})
    @ManyToMany(cascade={CascadeType.REMOVE})
    private Collection<Yattributevalue> yattributevalueCollection;
    @JoinColumn(name = "type", referencedColumnName = "idYITEMTYPE")
    @ManyToOne
    private Yitemtype type;
    @JoinColumn(name = "collection", referencedColumnName = "idYCOLLECTION")
    @ManyToOne
    private Ycollection collection;

    public Yitem() {
    }

    public Yitem(Integer idYITEM) {
        this.idYITEM = idYITEM;
    }

    public Integer getIdYITEM() {
        return idYITEM;
    }

    public void setIdYITEM(Integer idYITEM) {
        this.idYITEM = idYITEM;
    }

    @XmlTransient
    public Collection<Yattributevalue> getYattributevalueCollection() {
        return yattributevalueCollection;
    }

    public void setYattributevalueCollection(Collection<Yattributevalue> yattributevalueCollection) {
        this.yattributevalueCollection = yattributevalueCollection;
    }
    
    //ajoute un Yattributevalue 
    //MANY to MANY
    public void addYattributevalue(Yattributevalue val)
    {
        if(this.yattributevalueCollection == null)
            this.yattributevalueCollection = new ArrayList<Yattributevalue>();
        this.yattributevalueCollection.add(val);
    }

    public Yitemtype getType() {
        return type;
    }

    public void setType(Yitemtype type) {
        this.type = type;
    }

    public Ycollection getCollection() {
        return collection;
    }

    public void setCollection(Ycollection collection) {
        this.collection = collection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idYITEM != null ? idYITEM.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Yitem)) {
            return false;
        }
        Yitem other = (Yitem) object;
        if ((this.idYITEM == null && other.idYITEM != null) || (this.idYITEM != null && !this.idYITEM.equals(other.idYITEM))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "net.yace.entity.Yitem[ idYITEM=" + idYITEM + " ]";
    }
    
}
