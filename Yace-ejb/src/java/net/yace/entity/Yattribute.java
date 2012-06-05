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
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

@Entity
@Table(name = "yattribute")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Yattribute.findAll", query = "SELECT y FROM Yattribute y"),
    @NamedQuery(name = "Yattribute.findByIdYATTRIBUTE", query = "SELECT y FROM Yattribute y WHERE y.idYATTRIBUTE = :idYATTRIBUTE"),
    @NamedQuery(name = "Yattribute.findByName", query = "SELECT y FROM Yattribute y WHERE y.name = :name"),
    @NamedQuery(name = "Yattribute.findByNameLike", query = "SELECT y FROM Yattribute y WHERE y.name LIKE :name"),
    @NamedQuery(name = "Yattribute.findByType", query = "SELECT y FROM Yattribute y WHERE y.type = :type"),
    @NamedQuery(name = "Yattribute.findByNoOrder", query = "SELECT y FROM Yattribute y WHERE y.noOrder = :noOrder"),
    @NamedQuery(name = "Yattribute.findByMany", query = "SELECT y FROM Yattribute y WHERE y.many = :many")})
public class Yattribute implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idYATTRIBUTE")
    private Integer idYATTRIBUTE;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "name")
    private String name;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "type")
    private String type;
    @Basic(optional = false)
    @NotNull
    @Column(name = "no_order")
    private int noOrder;
    @Basic(optional = false)
    @NotNull
    @Column(name = "many")
    private Boolean many;
    @OneToMany(mappedBy = "attribute")
    private Collection<Yattributevalue> yattributevalueCollection;
    @JoinColumn(name = "itemtype", referencedColumnName = "idYITEMTYPE")
    @ManyToOne
    private Yitemtype itemtype;

    public Yattribute() {
    }

    public Yattribute(Integer idYATTRIBUTE) {
        this.idYATTRIBUTE = idYATTRIBUTE;
    }

    public Yattribute(Integer idYATTRIBUTE, String name, String type, int noOrder, Boolean many) {
        this.idYATTRIBUTE = idYATTRIBUTE;
        this.name = name;
        this.type = type;
        this.noOrder = noOrder;
        this.many = many;
    }

    public Integer getIdYATTRIBUTE() {
        return idYATTRIBUTE;
    }

    public void setIdYATTRIBUTE(Integer idYATTRIBUTE) {
        this.idYATTRIBUTE = idYATTRIBUTE;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getNoOrder() {
        return noOrder;
    }

    public void setNoOrder(int noOrder) {
        this.noOrder = noOrder;
    }

    public Boolean getMany() {
        return many;
    }

    public void setMany(Boolean many) {
        this.many = many;
    }

    @XmlTransient
    public Collection<Yattributevalue> getYattributevalueCollection() {
        return yattributevalueCollection;
    }

    public void setYattributevalueCollection(Collection<Yattributevalue> yattributevalueCollection) {
        this.yattributevalueCollection = yattributevalueCollection;
    }

    public Yitemtype getItemtype() {
        return itemtype;
    }

    public void setItemtype(Yitemtype itemtype) {
        this.itemtype = itemtype;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idYATTRIBUTE != null ? idYATTRIBUTE.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Yattribute)) {
            return false;
        }
        Yattribute other = (Yattribute) object;
        if ((this.idYATTRIBUTE == null && other.idYATTRIBUTE != null) || (this.idYATTRIBUTE != null && !this.idYATTRIBUTE.equals(other.idYATTRIBUTE))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "net.yace.entity.Yattribute[ idYATTRIBUTE=" + idYATTRIBUTE + " ]";
    }
    
}
