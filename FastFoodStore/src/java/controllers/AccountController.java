/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import entities.Account;
import entities.Product;
import tools.NewAccountCheck;
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
import sessionbeans.ProductFacade;

/**
 *
 * @author SE161707 Le Thanh Dat
 */
@WebServlet(name = "AccountController", urlPatterns = {"/acc"})
public class AccountController extends HttpServlet {

    @EJB
    private ProductFacade pf;

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
            case "login":
                login(request, response);
                break;
            case "register":
                register(request, response);
                break;
            case "logout":
                logout(request, response);
                break;
            case "updateAccount":
                updateAccount(request, response);
                break;
            case "editAccount":
                editAccount(request, response);
                break;

            default:
                request.setAttribute("controller", "error");
                request.setAttribute("action", "index");
        }
        request.getRequestDispatcher(App.LAYOUT)
                .forward(request, response);
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

    private void login(HttpServletRequest request, HttpServletResponse response) {
        //Lay thong tin user
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        //Check user
        Account user = af.checkLogin(username, password);

        //Phan quyen
        if (user != null && user.isEnabled()) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            switch (user.getRole()) {
                case "admin": {
                    //Hien admin/index.jsp
                    request.setAttribute("controller", "admin");
                    request.setAttribute("action", "index");
                    break;
                }
                case "customer": {
                    //Hien user/index.jsp
                    request.setAttribute("controller", "user");
                    request.setAttribute("action", "index");
                    break;
                }

            }
            //Doc danh sach san pham
            getPagination(request, response);
        } else {
            //Dinh kem thong tin da nhap
            request.setAttribute("username", username);
            //Hien home/login.jsp
            request.setAttribute("controller", "home");
            request.setAttribute("action", "login");

            if (user != null && user.isEnabled() == false) {
                request.setAttribute("message", "This account is disabled!");

            } else {
                request.setAttribute("message", "User ID or Password is incorrect!");
            }

        }

    }

    private void register(HttpServletRequest request, HttpServletResponse response) {
        //Thu thap thong tin
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String passwordConfirm = request.getParameter("passwordConfirm");

        Account acc = new Account(af.count(), name, phone, email, username, password, true, "customer");
        //Kiem tra thong tin
        NewAccountCheck accCheck = af.checkNewAccount(acc, passwordConfirm);

        //Xu li
        if (accCheck.isError()) {
            //Hien home/login.jsp
            request.setAttribute("controller", "home");
            request.setAttribute("action", "register");

            request.setAttribute("errorMessage", accCheck);
            request.setAttribute("acc", acc);
        } else {
            af.create(acc);

            //Chuyen ve trang hien tai
            request.setAttribute("controller", "home");
            request.setAttribute("action", "register");
            //Dinh kem thong tin da nhap
            request.setAttribute("acc", acc);
            //Dinh kem thong bao da tao account thanh cong
            request.setAttribute("message", "Create user successfully, please login");

        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();

        session.invalidate();//Xoa session

        //Hien home/index.jsp
        request.setAttribute("controller", "home");
        request.setAttribute("action", "index");
        //Doc danh sach san pham
        getPagination(request, response);

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

    private void updateAccount(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");

        if (user != null) {
            switch (user.getRole()) {
                case "admin":
                    request.setAttribute("controller", "admin");
                    break;
                case "customer":
                    request.setAttribute("controller", "user");
                    break;
            }
        }
        request.setAttribute("action", "account");

    }

    private void editAccount(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("user");
        acc.setName(request.getParameter("name"));
        acc.setAddress(request.getParameter("address"));
        acc.setPhone(request.getParameter("phone"));
        acc.setEmail(request.getParameter("email"));
        acc.setPassword(request.getParameter("pass"));
        af.edit(acc);

        switch (acc.getRole()) {
            case "admin":
                request.setAttribute("controller", "admin");
                break;
            case "customer":
                request.setAttribute("controller", "user");
                break;
        }
        request.setAttribute("action", "index");

         //Doc danh sach san pham
        getPagination(request, response);
    }

}
