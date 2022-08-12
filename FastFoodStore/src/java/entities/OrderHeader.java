/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author SE161707 Le Thanh Dat
 */
@Entity
@Table(name = "OrderHeader")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "OrderHeader.findAll", query = "SELECT o FROM OrderHeader o")
    , @NamedQuery(name = "OrderHeader.findById", query = "SELECT o FROM OrderHeader o WHERE o.id = :id")
    , @NamedQuery(name = "OrderHeader.findByDate", query = "SELECT o FROM OrderHeader o WHERE o.date = :date")
    , @NamedQuery(name = "OrderHeader.findByStatus", query = "SELECT o FROM OrderHeader o WHERE o.status = :status")})
public class OrderHeader implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date date;
    @Size(max = 30)
    @Column(name = "status")
    private String status;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "orderId")
    private List<OrderDetail> orderDetailList;
    @JoinColumn(name = "customerId", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Customer customerId;

    public OrderHeader() {
    }

    public OrderHeader(Integer id) {
        this.id = id;
    }

    public OrderHeader(Integer id, Date date) {
        this.id = id;
        this.date = date;
    }

    public OrderHeader(Integer id, Date date, String status, Customer customerId) {
        this.id = id;
        this.date = date;
        this.status = status;
        this.customerId = customerId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @XmlTransient
    public List<OrderDetail> getOrderDetailList() {
        return orderDetailList;
    }

    public void setOrderDetailList(List<OrderDetail> orderDetailList) {
        this.orderDetailList = orderDetailList;
    }

    public Customer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Customer customerId) {
        this.customerId = customerId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof OrderHeader)) {
            return false;
        }
        OrderHeader other = (OrderHeader) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.OrderHeader[ id=" + id + " ]";
    }

}
