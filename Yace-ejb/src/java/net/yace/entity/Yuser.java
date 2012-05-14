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
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Mikhail Pitchugin <mikael.pitchugin.isat@gmail.com>
 */
@Entity
@Table(name = "yuser")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Yuser.findAll", query = "SELECT y FROM Yuser y"),
    @NamedQuery(name = "Yuser.findByIdYUSER", query = "SELECT y FROM Yuser y WHERE y.idYUSER = :idYUSER"),
    @NamedQuery(name = "Yuser.findByEmail", query = "SELECT y FROM Yuser y WHERE y.email = :email"),
    @NamedQuery(name = "Yuser.findByPasswordHash", query = "SELECT y FROM Yuser y WHERE y.passwordHash = :passwordHash"),
    @NamedQuery(name = "Yuser.findByPseudo", query = "SELECT y FROM Yuser y WHERE y.pseudo = :pseudo")})
public class Yuser implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idYUSER")
    private Integer idYUSER;
    @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "email")
    private String email;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 32)
    @Column(name = "password_hash")
    private String passwordHash;
    @Size(max = 45)
    @Column(name = "pseudo")
    private String pseudo;
    @JoinColumn(name = "rank", referencedColumnName = "idYRANK")
    @ManyToOne
    private Yrank rank;
    @OneToMany(mappedBy = "owner")
    private Collection<Ycollection> ycollectionCollection;

    public Yuser() {
    }

    public Yuser(Integer idYUSER) {
        this.idYUSER = idYUSER;
    }

    public Yuser(Integer idYUSER, String email, String passwordHash) {
        this.idYUSER = idYUSER;
        this.email = email;
        this.passwordHash = passwordHash;
    }

    public Integer getIdYUSER() {
        return idYUSER;
    }

    public void setIdYUSER(Integer idYUSER) {
        this.idYUSER = idYUSER;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getPseudo() {
        return pseudo;
    }

    public void setPseudo(String pseudo) {
        this.pseudo = pseudo;
    }

    public Yrank getRank() {
        return rank;
    }

    public void setRank(Yrank rank) {
        this.rank = rank;
    }

    @XmlTransient
    public Collection<Ycollection> getYcollectionCollection() {
        return ycollectionCollection;
    }

    public void setYcollectionCollection(Collection<Ycollection> ycollectionCollection) {
        this.ycollectionCollection = ycollectionCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idYUSER != null ? idYUSER.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Yuser)) {
            return false;
        }
        Yuser other = (Yuser) object;
        if ((this.idYUSER == null && other.idYUSER != null) || (this.idYUSER != null && !this.idYUSER.equals(other.idYUSER))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "net.yace.entity.Yuser[ idYUSER=" + idYUSER + " ]";
    }
    
}
