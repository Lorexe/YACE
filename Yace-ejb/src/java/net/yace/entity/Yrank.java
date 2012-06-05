package net.yace.entity;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

@Entity
@Table(name = "yrank")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Yrank.findAll", query = "SELECT y FROM Yrank y"),
    @NamedQuery(name = "Yrank.findByIdYRANK", query = "SELECT y FROM Yrank y WHERE y.idYRANK = :idYRANK"),
    @NamedQuery(name = "Yrank.findByDescription", query = "SELECT y FROM Yrank y WHERE y.description = :description"),
    @NamedQuery(name = "Yrank.findByNbMaxItem", query = "SELECT y FROM Yrank y WHERE y.nbMaxItem = :nbMaxItem"),
    @NamedQuery(name = "Yrank.findByIsAdmin", query = "SELECT y FROM Yrank y WHERE y.isAdmin = :isAdmin")})
public class Yrank implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idYRANK")
    private Integer idYRANK;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "description")
    private String description;
    @Basic(optional = false)
    @NotNull
    @Column(name = "nb_max_item")
    private int nbMaxItem;
    @Basic(optional = false)
    @NotNull
    @Column(name = "is_admin")
    private Boolean isAdmin;
    @OneToMany(mappedBy = "rank")
    private Collection<Yuser> yuserCollection;

    public Yrank() {
        
    }

    public Yrank(Integer idYRANK) {
        this.idYRANK = idYRANK;
    }

    public Yrank(Integer idYRANK, String description, int nbMaxItem, Boolean isAdmin) {
        this.idYRANK = idYRANK;
        this.description = description;
        this.nbMaxItem = nbMaxItem;
        this.isAdmin = isAdmin;
    }
    
    public Yrank(String description, int nbMaxItem, Boolean isAdmin)
    {
        this.description = description;
        this.nbMaxItem = nbMaxItem;
        this.isAdmin = isAdmin;
    }

    public Integer getIdYRANK() {
        return idYRANK;
    }

    public void setIdYRANK(Integer idYRANK) {
        this.idYRANK = idYRANK;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getNbMaxItem() {
        return nbMaxItem;
    }

    public void setNbMaxItem(int nbMaxItem) {
        this.nbMaxItem = nbMaxItem;
    }

    public Boolean isAdmin() {
        return isAdmin;
    }
    
    /*
     * Important pour pouvoir utiliser ${user.rank.isAdmin} dans les jsp...
     */
    public Boolean getIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(Boolean isAdmin) {
        this.isAdmin = isAdmin;
    }

    @XmlTransient
    public Collection<Yuser> getYuserCollection() {
        return yuserCollection;
    }

    public void setYuserCollection(Collection<Yuser> yuserCollection) {
        this.yuserCollection = yuserCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idYRANK != null ? idYRANK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Yrank)) {
            return false;
        }
        Yrank other = (Yrank) object;
        if ((this.idYRANK == null && other.idYRANK != null) || (this.idYRANK != null && !this.idYRANK.equals(other.idYRANK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "net.yace.entity.Yrank[ idYRANK=" + idYRANK + " ]";
    }
    
}
