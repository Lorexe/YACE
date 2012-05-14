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

/**
 *
 * @author Mikhail Pitchugin <mikael.pitchugin.isat@gmail.com>
 */
@Entity
@Table(name = "ycollection")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Ycollection.findAll", query = "SELECT y FROM Ycollection y"),
    @NamedQuery(name = "Ycollection.findByIdYCOLLECTION", query = "SELECT y FROM Ycollection y WHERE y.idYCOLLECTION = :idYCOLLECTION"),
    @NamedQuery(name = "Ycollection.findByTheme", query = "SELECT y FROM Ycollection y WHERE y.theme = :theme")})
public class Ycollection implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idYCOLLECTION")
    private Integer idYCOLLECTION;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "theme")
    private String theme;
    @Basic(optional = false)
    @NotNull
    @Lob
    @Column(name = "is_public")
    private byte[] isPublic;
    @OneToMany(mappedBy = "collection")
    private Collection<Yitem> yitemCollection;
    @JoinColumn(name = "owner", referencedColumnName = "idYUSER")
    @ManyToOne
    private Yuser owner;

    public Ycollection() {
    }

    public Ycollection(Integer idYCOLLECTION) {
        this.idYCOLLECTION = idYCOLLECTION;
    }

    public Ycollection(Integer idYCOLLECTION, String theme, byte[] isPublic) {
        this.idYCOLLECTION = idYCOLLECTION;
        this.theme = theme;
        this.isPublic = isPublic;
    }

    public Integer getIdYCOLLECTION() {
        return idYCOLLECTION;
    }

    public void setIdYCOLLECTION(Integer idYCOLLECTION) {
        this.idYCOLLECTION = idYCOLLECTION;
    }

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public byte[] getIsPublic() {
        return isPublic;
    }

    public void setIsPublic(byte[] isPublic) {
        this.isPublic = isPublic;
    }

    @XmlTransient
    public Collection<Yitem> getYitemCollection() {
        return yitemCollection;
    }

    public void setYitemCollection(Collection<Yitem> yitemCollection) {
        this.yitemCollection = yitemCollection;
    }

    public Yuser getOwner() {
        return owner;
    }

    public void setOwner(Yuser owner) {
        this.owner = owner;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idYCOLLECTION != null ? idYCOLLECTION.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Ycollection)) {
            return false;
        }
        Ycollection other = (Ycollection) object;
        if ((this.idYCOLLECTION == null && other.idYCOLLECTION != null) || (this.idYCOLLECTION != null && !this.idYCOLLECTION.equals(other.idYCOLLECTION))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "net.yace.entity.Ycollection[ idYCOLLECTION=" + idYCOLLECTION + " ]";
    }
    
}
