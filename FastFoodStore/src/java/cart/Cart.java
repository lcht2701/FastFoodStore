/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cart;

import entities.Product;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import sessionbeans.ProductFacade;

/**
 *
 * @author SE161707 Le Thanh Dat
 */
public class Cart {

    ProductFacade pf = lookupProductFacadeBean();
    List<Item> list;

    public Cart() {
        list = new ArrayList();
    }

    public Item find(int id) {
        for (Item item : list) {
            if (item.getId() == id) {
                return item;
            }
        }
        return null;
    }

    public void add(int id, int quantity) {
        Item item = find(id);

        if (item == null) {
            Product product = pf.find(id);

            list.add(new Item(product.getId(),
                    product.getDescription(),
                    product.getPrice(),
                    product.getDiscount(),
                    quantity));
        } else {
            item.setQuantity(item.getQuantity() + quantity);
        }
    }

    public void delete(int id) {
        Item item = find(id);

        list.remove(item);
    }

    public void update(int id, int quantity) {
        Item item = find(id);
        item.setQuantity(quantity);
    }
    
    public void empty(){
        list.clear();
    }
    
    public List<Item> getItems(){
        return list;
    }
    
    public int getNumOfProducts() {
        return list.size();
    }
    
    public double getTotal() {
        double total = list.stream().mapToDouble(Item::getCost).sum();
        return total;
    }
    
    private ProductFacade lookupProductFacadeBean() {
        try {
            Context c = new InitialContext();
            return (ProductFacade) c.lookup("java:global/Assignment_G2_FastFoodStore/ProductFacade!sessionbeans.ProductFacade");
        } catch (NamingException ne) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", ne);
            throw new RuntimeException(ne);
        }
    }

}
