/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import entities.Account;
import entities.Category;
import entities.OrderDetail;
import entities.OrderHeader;
import entities.Product;
import java.io.IOException;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sessionbeans.AccountFacade;
import sessionbeans.CategoryFacade;
import sessionbeans.OrderDetailFacade;
import sessionbeans.OrderHeaderFacade;
import sessionbeans.ProductFacade;

/**
 *
 * @author SE162033 Nguyen Vuong Bach
 */
@WebServlet(name = "AdminController", urlPatterns = {"/admin"})
public class AdminController extends HttpServlet {

    @EJB(name = "odf")
    private OrderDetailFacade odf;

    @EJB(name = "ohf")
    private OrderHeaderFacade ohf;

    @EJB
    private ProductFacade pf;

    @EJB
    private CategoryFacade cf;

    @EJB
    private AccountFacade af;

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
            case "index":
                getPagination(request, response);
                break;
            case "users":
                users(request, response);
                break;
            case "updateUser":
                updateUser(request, response);
                break;
            case "editUser":
                editUser(request, response);
                users(request, response);
                break;
            case "updateProduct":
                updateProduct(request, response);
                break;
            case "editProduct":
                editProduct(request, response);
                break;
            case "orders":

                break;
            case "categories":
                viewCategory(request, response);
                break;
            case "editCategory":
                editCategory(request, response);
                break;
            case "invoice":
                invoice(request, response);
                break;
            case "invoiceDetail":
                invoiceDetail(request, response);
                break;
            default:
                request.setAttribute("controller", "error");
                request.setAttribute("action", "index");
        }
        request.getRequestDispatcher(App.LAYOUT).forward(request, response);
    }

    private void getPagination(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();

        //Phan trang
        int pageSize = 6;//Kich thuoc trang         

        //Xac dinh so thu tu cua trang hien tai
        Integer page = (Integer) session.getAttribute("pageNum");
        if (page == null) {
            page = 1;
        }

        //Xac dinh tong so trang
        Integer totalPage = (Integer) session.getAttribute("totalPage");
        if (totalPage == null) {
            int count = pf.count();//Dem so luong records
            totalPage = (int) Math.ceil((double) count / pageSize);//Tinh tong so trang
        }

        String op = request.getParameter("op");
        if (op == null) {
            op = "FirstPage";
        }
        switch (op) {
            case "FirstPage":
                page = 1;
                break;
            case "PreviousPage":
                if (page > 1) {
                    page--;
                }
                break;
            case "NextPage":
                if (page < totalPage) {
                    page++;
                }
                break;
            case "LastPage":
                page = totalPage;
                break;
            case "GotoPage":
                page = Integer.parseInt(request.getParameter("gotoPage"));
                if (page <= 0) {
                    page = 1;
                } else if (page > totalPage) {
                    page = totalPage;
                }
                break;
        }

        //Lay trang du lieu duoc yeu cau
        int n1 = (page - 1) * pageSize;//Vi tri mau tin dau trang
        int n2 = n1 + pageSize - 1;//Vi tri mau tin cuoi trang
        List<Product> list = pf.findRange(new int[]{n1, n2});//Doc mot trang

        //Luu thong tin vao session va request
        session.setAttribute("pageNum", page);
        session.setAttribute("totalPage", totalPage);
        request.setAttribute("list", list);
    }

    private void users(HttpServletRequest request, HttpServletResponse response) {
        List<Account> list = af.findAll();
        request.setAttribute("list", list);
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) {
        Integer id = Integer.parseInt(request.getParameter("id"));
        Account user = af.find(id);
        request.setAttribute("user", user);
    }

    private void editUser(HttpServletRequest request, HttpServletResponse response) {

        boolean status = false;

        Integer id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("pass");
        String tempStatus = request.getParameter("enabled");
        if (tempStatus.equals("1")) {
            status = true;
        }
        String role = request.getParameter("role");

        Account account = new Account(id, name, address, phone, email, username, password, status, role);
        af.edit(account);

        request.setAttribute("controller", "admin");
        request.setAttribute("action", "users");
    }

    private void editProduct(HttpServletRequest request, HttpServletResponse response) {
        boolean enabled = false;

        //Thu thap thong tin tu user 
        Integer id = Integer.parseInt(request.getParameter("id"));
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        double discount = Double.parseDouble(request.getParameter("discount"));
        Integer tempCategoryId = Integer.parseInt(request.getParameter("categoryId"));
        Category categoryId = cf.find(tempCategoryId);
        String tempStatus = request.getParameter("enabled");
        if (tempStatus.equals("1")) {
            enabled = true;
        }

        //Edit user 
        Product product = new Product(id, description, price, discount, enabled);
        product.setCategoryId(categoryId);
        pf.edit(product);

        //Cap nhat list moi tu request
        List<Product> list = pf.findAll();
        request.setAttribute("list", list);
        //Quay ve view admin/index
        request.setAttribute("controller", "admin");
        request.setAttribute("action", "index");

    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) {
        Integer id = Integer.parseInt(request.getParameter("id"));
        Product product = pf.find(id);
        request.setAttribute("product", product);

        List<Category> list = cf.findAll();
        for (Category c : list) {
            System.out.println(c.getId());
        }
        request.setAttribute("list", list);
    }

    private void editCategory(HttpServletRequest request, HttpServletResponse response) {
        boolean status = false;

        //thu thap thong tin tu user
        Integer id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String tempStatus = request.getParameter("enabled");
        if (tempStatus.equals("1")) {
            status = true;
        }

        Category category = new Category(id, name, status);
        cf.edit(category);

        List<Product> productList = pf.findAll();
        for (Product product : productList) {
            if (product.getCategoryId().getId().equals(category.getId())) {
                product.setEnabled(status);
                pf.edit(product);
            }
        }

        request.setAttribute("controller", "admin");
        request.setAttribute("action", "categories");

        List<Category> list = cf.findAll();
        request.setAttribute("list", list);

    }

    private void viewCategory(HttpServletRequest request, HttpServletResponse response) {
        List<Category> list = cf.findAll();
        request.setAttribute("list", list);
    }
    private void invoice(HttpServletRequest request, HttpServletResponse response) {
//        List<Account> account = af.findAll();
//        request.setAttribute("account", account);

        List<OrderHeader> list = ohf.findAll();
        request.setAttribute("list", list);
    }

    private void invoiceDetail(HttpServletRequest request, HttpServletResponse response) {
        Integer id = Integer.parseInt(request.getParameter("id"));
        OrderHeader orderHeader = ohf.find(id);
        request.setAttribute("orderHeader", orderHeader);

        List<OrderDetail> list = odf.findAll();
        request.setAttribute("list", list);
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
