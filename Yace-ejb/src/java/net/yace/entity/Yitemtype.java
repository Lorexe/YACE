/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.entity;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Mikhail Pitchugin <mikael.pitchugin.isat@gmail.com>
 */
@Entity
@Table(name = "yitemtype")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Yitemtype.findAll", query = "SELECT y FROM Yitemtype y"),
    @NamedQuery(name = "Yitemtype.findByIdYITEMTYPE", query = "SELECT y FROM Yitemtype y WHERE y.idYITEMTYPE = :idYITEMTYPE"),
    @NamedQuery(name = "Yitemtype.findByName", query = "SELECT y FROM Yitemtype y WHERE y.name = :name")})
public class Yitemtype implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idYITEMTYPE")
    private Integer idYITEMTYPE;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "name")
    private String name;
    @JoinTable(name = "link_types", joinColumns = {
        @JoinColumn(name = "child", referencedColumnName = "idYITEMTYPE")}, inverseJoinColumns = {
        @JoinColumn(name = "parent", referencedColumnName = "idYITEMTYPE")})
    @ManyToMany
    private Collection<Yitemtype> yitemtypeCollection;
    @ManyToMany(mappedBy = "yitemtypeCollection")
    private Collection<Yitemtype> yitemtypeCollection1;
    @OneToMany(mappedBy = "type")
    private Collection<Yitem> yitemCollection;
    @OneToMany(mappedBy = "itemtype")
    private Collection<Yattribute> yattributeCollection;

    public Yitemtype() {
    }

    public Yitemtype(Integer idYITEMTYPE) {
        this.idYITEMTYPE = idYITEMTYPE;
    }

    public Yitemtype(Integer idYITEMTYPE, String name) {
        this.idYITEMTYPE = idYITEMTYPE;
        this.name = name;
    }

    public Integer getIdYITEMTYPE() {
        return idYITEMTYPE;
    }

    public void setIdYITEMTYPE(Integer idYITEMTYPE) {
        this.idYITEMTYPE = idYITEMTYPE;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @XmlTransient
    public Collection<Yitemtype> getYitemtypeCollection() {
        return yitemtypeCollection;
    }

    public void setYitemtypeCollection(Collection<Yitemtype> yitemtypeCollection) {
        this.yitemtypeCollection = yitemtypeCollection;
    }

    @XmlTransient
    public Collection<Yitemtype> getYitemtypeCollection1() {
        return yitemtypeCollection1;
    }

    public void setYitemtypeCollection1(Collection<Yitemtype> yitemtypeCollection1) {
        this.yitemtypeCollection1 = yitemtypeCollection1;
    }

    @XmlTransient
    public Collection<Yitem> getYitemCollection() {
        return yitemCollection;
    }

    public void setYitemCollection(Collection<Yitem> yitemCollection) {
        this.yitemCollection = yitemCollection;
    }

    @XmlTransient
    public Collection<Yattribute> getYattributeCollection() {
        return yattributeCollection;
    }

    public void setYattributeCollection(Collection<Yattribute> yattributeCollection) {
        this.yattributeCollection = yattributeCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idYITEMTYPE != null ? idYITEMTYPE.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Yitemtype)) {
            return false;
        }
        Yitemtype other = (Yitemtype) object;
        if ((this.idYITEMTYPE == null && other.idYITEMTYPE != null) || (this.idYITEMTYPE != null && !this.idYITEMTYPE.equals(other.idYITEMTYPE))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "net.yace.entity.Yitemtype[ idYITEMTYPE=" + idYITEMTYPE + " ]";
    }
    
}
