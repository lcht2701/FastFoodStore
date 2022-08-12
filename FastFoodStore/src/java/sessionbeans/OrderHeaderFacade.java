/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import entities.OrderHeader;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author SE161707 Le Thanh Dat
 */
@Stateless
public class OrderHeaderFacade extends AbstractFacade<OrderHeader> {

    @PersistenceContext(unitName = "Assignment_G2_FastFoodStorePU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public OrderHeaderFacade() {
        super(OrderHeader.class);
    }
    
    public List<OrderHeader> findByCustomerId(int customerId) {
        String sql = String.format("SELECT * FROM OrderHeader oh WHERE oh.customerId = '%s'", customerId);
        Query q = em.createNativeQuery(sql, OrderHeader.class);
        return q.getResultList();
    }
}
