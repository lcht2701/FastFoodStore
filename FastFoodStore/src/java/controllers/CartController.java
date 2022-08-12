/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import cart.Cart;
import cart.Item;
import entities.Account;
import entities.Customer;
import entities.OrderDetail;
import entities.OrderHeader;
import entities.Product;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sessionbeans.AccountFacade;
import sessionbeans.CustomerFacade;
import sessionbeans.OrderDetailFacade;
import sessionbeans.OrderHeaderFacade;
import sessionbeans.ProductFacade;

/**
 *
 * @author SE161707 Le Thanh Dat
 */
@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

    @EJB
    private OrderDetailFacade odf;

    @EJB
    private AccountFacade af;

    @EJB(name = "ohf")
    private OrderHeaderFacade ohf;

    @EJB(name = "cf")
    private CustomerFacade cf;

    @EJB
    private ProductFacade pf;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getAttribute("action").toString();
        switch (action) {
            case "view":
                view(request, response);
                break;
            case "add":
                add(request, response);
                break;
            case "delete":
                delete(request, response);
                break;
            case "update":
                update(request, response);
                break;
            case "empty":
                empty(request, response);
                break;
            case "checkout":
                checkout(request, response);
                break;
            default:
                request.setAttribute("controller", "error");
                request.setAttribute("action", "index");
        }
        request.getRequestDispatcher(App.LAYOUT).forward(request, response);
    }

    private void add(HttpServletRequest request, HttpServletResponse response) {
        //Lay thong tin tu client
        int id = Integer.parseInt(request.getParameter("id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        String searchValue = request.getParameter("searchValue");

        //Lay cart tu session
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        //Neu session chua co cart thi tao moi cart
        if (cart == null) {
            cart = new Cart();
        }

        //Them item vao cart
        cart.add(id, quantity);
        //Dua cart vao session
        session.setAttribute("cart", cart);

        //Hien user/index.jsp
        request.setAttribute("controller", "user");
        request.setAttribute("action", "index");
        //Doc danh sach san pham
        List<Product> list = null;
        if (searchValue == null) {
            list = pf.findAll();
        } else {
            list = pf.findByName(searchValue);
            request.setAttribute("searchValue", searchValue);
        }
        request.setAttribute("list", list);

    }

    private void view(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("controller", "user");
        request.setAttribute("action", "viewcart");
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        //Lay cart tu session
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        //Xoa item trong cart
        cart.delete(id);

        //Cho hien lai user/cart.jsp
        request.setAttribute("controller", "user");
        request.setAttribute("action", "viewcart");
    }

    private void update(HttpServletRequest request, HttpServletResponse response) {
        int id = Integer.parseInt(request.getParameter("id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        //Lay cart tu session
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        //Update item trong cart
        cart.update(id, quantity);

        //Cho hien lai user/cart.jsp
        request.setAttribute("controller", "user");
        request.setAttribute("action", "viewcart");
    }

    private void empty(HttpServletRequest request, HttpServletResponse response) {

        //Lay cart tu session
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        //Xoa het item trong cart
        cart.empty();

        //Cho hien lai user/cart.jsp
        request.setAttribute("controller", "user");
        request.setAttribute("action", "viewcart");
    }

    private void checkout(HttpServletRequest request, HttpServletResponse response) {
        //Tao dia chi moi cho Customer neu dia chi khac trong table Customer
        HttpSession session = request.getSession();
        String shippingAddress = request.getParameter("shippingAddress");
        Account account = (Account) session.getAttribute("user");
        if (account.getCustomer() == null) {
            account.setCustomer(new Customer(account.getId(), "Copper", shippingAddress));
            af.edit(account);

            cf.create(account.getCustomer());
        }

        Date date = Date.valueOf(LocalDate.now());
        String status = "new";

        OrderHeader newOrderHeader = new OrderHeader(ohf.count() + 2, date, status, account.getCustomer());
        ohf.create(newOrderHeader);
        Cart cart = (Cart) session.getAttribute("cart");
        
        for (Item item : cart.getItems()) {
            odf.create(new OrderDetail(odf.count()+1, item.getQuantity(), item.getNewPrice(), item.getDiscount(),newOrderHeader, pf.find(item.getId())));
        }

        List<OrderHeader> ohfList = ohf.findByCustomerId(account.getId());
        request.setAttribute("list", ohfList);
        

        //Quay sang trang user/invoice.jsp de hien thi hoa don
        request.setAttribute("controller", "user");
        request.setAttribute("action", "invoice");

    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
