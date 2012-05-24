/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.yace.entity;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Mikhail Pitchugin <mikael.pitchugin.isat@gmail.com>
 */
@Entity
@Table(name = "yattributevalue")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Yattributevalue.findAll", query = "SELECT y FROM Yattributevalue y"),
    @NamedQuery(name = "Yattributevalue.findByIdYATTRIBUTEVALUE", query = "SELECT y FROM Yattributevalue y WHERE y.idYATTRIBUTEVALUE = :idYATTRIBUTEVALUE"),
    @NamedQuery(name = "Yattributevalue.findByValInt", query = "SELECT y FROM Yattributevalue y WHERE y.valInt = :valInt"),
    @NamedQuery(name = "Yattributevalue.findByValFlt", query = "SELECT y FROM Yattributevalue y WHERE y.valFlt = :valFlt"),
    @NamedQuery(name = "Yattributevalue.findByValDate", query = "SELECT y FROM Yattributevalue y WHERE y.valDate = :valDate")})
public class Yattributevalue implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "idYATTRIBUTEVALUE")
    private Integer idYATTRIBUTEVALUE;
    @Lob
    @Size(max = 2147483647)
    @Column(name = "val_str")
    private String valStr;
    @Column(name = "val_int")
    private Integer valInt;
    @Column(name = "val_flt")
    private Short valFlt;
    @Column(name = "val_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date valDate;
    @Column(name = "val_bool")
    private Boolean valBool;
    @ManyToMany(mappedBy = "yattributevalueCollection")
    private Collection<Yitem> yitemCollection;
    @JoinColumn(name = "attribute", referencedColumnName = "idYATTRIBUTE")
    @ManyToOne
    private Yattribute attribute;

    public Yattributevalue() {
    }

    public Yattributevalue(Integer idYATTRIBUTEVALUE) {
        this.idYATTRIBUTEVALUE = idYATTRIBUTEVALUE;
    }

    public Integer getIdYATTRIBUTEVALUE() {
        return idYATTRIBUTEVALUE;
    }

    public void setIdYATTRIBUTEVALUE(Integer idYATTRIBUTEVALUE) {
        this.idYATTRIBUTEVALUE = idYATTRIBUTEVALUE;
    }

    public String getValStr() {
        return valStr;
    }

    public void setValStr(String valStr) {
        this.valStr = valStr;
    }

    public Integer getValInt() {
        return valInt;
    }

    public void setValInt(Integer valInt) {
        this.valInt = valInt;
    }

    public Short getValFlt() {
        return valFlt;
    }

    public void setValFlt(Short valFlt) {
        this.valFlt = valFlt;
    }

    public Date getValDate() {
        return valDate;
    }

    public void setValDate(Date valDate) {
        this.valDate = valDate;
    }

    public Boolean getValBool() {
        return valBool;
    }

    public void setValBool(Boolean valBool) {
        this.valBool = valBool;
    }

    @XmlTransient
    public Collection<Yitem> getYitemCollection() {
        return yitemCollection;
    }

    public void setYitemCollection(Collection<Yitem> yitemCollection) {
        this.yitemCollection = yitemCollection;
    }

    public Yattribute getAttribute() {
        return attribute;
    }

    public void setAttribute(Yattribute attribute) {
        this.attribute = attribute;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idYATTRIBUTEVALUE != null ? idYATTRIBUTEVALUE.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Yattributevalue)) {
            return false;
        }
        Yattributevalue other = (Yattributevalue) object;
        if ((this.idYATTRIBUTEVALUE == null && other.idYATTRIBUTEVALUE != null) || (this.idYATTRIBUTEVALUE != null && !this.idYATTRIBUTEVALUE.equals(other.idYATTRIBUTEVALUE))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "net.yace.entity.Yattributevalue[ idYATTRIBUTEVALUE=" + idYATTRIBUTEVALUE + " ]";
    }
    
}
