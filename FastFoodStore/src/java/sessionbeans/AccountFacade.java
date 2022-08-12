/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sessionbeans;

import tools.NewAccountCheck;
import entities.Account;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author SE161707 Le Thanh Dat
 */
@Stateless
public class AccountFacade extends AbstractFacade<Account> {

    @PersistenceContext(unitName = "Assignment_G2_FastFoodStorePU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public AccountFacade() {
        super(Account.class);
    }

    public Account checkLogin(String username, String password) {
        Account acc = null;
        String sql = String.format("SELECT * FROM Account WHERE username='%s' and password = '%s'", username, password);

        Query query = em.createNativeQuery(sql, Account.class);
        try {
            acc = (Account) query.getSingleResult();
        } catch (Exception e) {
            return null;
        }
        return acc;
    }

    public NewAccountCheck checkNewAccount(Account newAcc, String passwordConfirm) {
        NewAccountCheck error = new NewAccountCheck();
        Account acc;
        //Kiem tra duplicated username  
        String sql = String.format("SELECT * FROM Account WHERE username='%s'", newAcc.getUsername());

        Query query = em.createNativeQuery(sql, Account.class);

        try {
            acc = (Account) query.getSingleResult();
        } catch (Exception e) {
            acc = null;
        }
        if (acc != null) {
            error.setError(true);
            error.setUserName("Duplicated username");
            acc = null;
        }

        //Kiem tra duplicated phone        
        sql = String.format("SELECT * FROM Account WHERE phone='%s'", newAcc.getPhone());
        query = em.createNativeQuery(sql, Account.class);
        try {
            acc = (Account) query.getSingleResult();
        } catch (Exception e) {
            acc = null;
        }
        if (acc != null) {
            error.setError(true);
            error.setPhone("Duplicated phone number");
            acc = null;
        }

        //Kiem tra duplicated email        
        sql = String.format("SELECT * FROM Account WHERE email='%s'", newAcc.getEmail());
        query = em.createNativeQuery(sql, Account.class);
        try {
            acc = (Account) query.getSingleResult();
        } catch (Exception e) {
            acc = null;
        }
        if (acc != null) {
            error.setError(true);
            error.setEmail("Duplicated email");
            acc = null;
        }

        //Kiem tra password        
        if (!newAcc.getPassword().equals(passwordConfirm)) {
            error.setError(true);
            error.setPassword("Wrong password confirm");
            acc = null;
        }

        return error;
    }

}
