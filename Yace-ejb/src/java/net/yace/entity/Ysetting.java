package net.yace.entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@Table(name = "ysetting")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Ysetting.findAll", query = "SELECT y FROM Ysetting y"),
    @NamedQuery(name = "Ysetting.findByIdYSETTING", query = "SELECT y FROM Ysetting y WHERE y.idYSETTING = :idYSETTING"),
    @NamedQuery(name = "Ysetting.findByName", query = "SELECT y FROM Ysetting y WHERE y.name = :name"),
    @NamedQuery(name = "Ysetting.findByVal", query = "SELECT y FROM Ysetting y WHERE y.val = :val")})
public class Ysetting implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idYSETTING")
    private Integer idYSETTING;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "name")
    private String name;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "val")
    private String val;

    public Ysetting() {
    }

    public Ysetting(Integer idYSETTING) {
        this.idYSETTING = idYSETTING;
    }

    public Ysetting(Integer idYSETTING, String name, String val) {
        this.idYSETTING = idYSETTING;
        this.name = name;
        this.val = val;
    }

    public Integer getIdYSETTING() {
        return idYSETTING;
    }

    public void setIdYSETTING(Integer idYSETTING) {
        this.idYSETTING = idYSETTING;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idYSETTING != null ? idYSETTING.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Ysetting)) {
            return false;
        }
        Ysetting other = (Ysetting) object;
        if ((this.idYSETTING == null && other.idYSETTING != null) || (this.idYSETTING != null && !this.idYSETTING.equals(other.idYSETTING))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "net.yace.entity.Ysetting[ idYSETTING=" + idYSETTING + " ]";
    }
    
}
