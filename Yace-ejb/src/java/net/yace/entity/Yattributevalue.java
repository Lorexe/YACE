package net.yace.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

@Entity
@Table(name = "yattributevalue")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Yattributevalue.findAll", query = "SELECT y FROM Yattributevalue y"),
    @NamedQuery(name = "Yattributevalue.findByIdYATTRIBUTEVALUE", query = "SELECT y FROM Yattributevalue y WHERE y.idYATTRIBUTEVALUE = :idYATTRIBUTEVALUE"),
    @NamedQuery(name = "Yattributevalue.findByValInt", query = "SELECT y FROM Yattributevalue y WHERE y.valInt = :valInt"),
    @NamedQuery(name = "Yattributevalue.findByValFlt", query = "SELECT y FROM Yattributevalue y WHERE y.valFlt = :valFlt"),
    @NamedQuery(name = "Yattributevalue.findByValDate", query = "SELECT y FROM Yattributevalue y WHERE y.valDate = :valDate"),
    @NamedQuery(name = "Yattributevalue.findByValBool", query = "SELECT y FROM Yattributevalue y WHERE y.valBool = :valBool")})
public class Yattributevalue implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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
    
    
    //ajoute un yitem
    //MANY to MANY
    public void addYitem(Yitem item) {
        if(this.yitemCollection == null)
            this.yitemCollection = new ArrayList<Yitem>();
        this.yitemCollection.add(item);
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
