<%-- 
    Document   : layout
    Created on : Feb 23, 2022, 10:47:32 AM
    Author     : SE161707 Le Thanh Dat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Fast Food Store</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>        
        <link href="${root}/css/site.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="container">
            <!--navigator-->     
            <div class="row">
                <div class="col">
                    <div class="header">
                        <a href="<c:url value="/home/index.do"/>" title="Home Page" class="logo">
                            <img src="${root}/logo.png" style="height: 80px"/> 
                        </a>

                        <div class="header-link">
                            <c:if test="${user.role != 'admin'}">
                                <a href="<c:url value="/cart/view.do"/>"><button class="btn btn-outline-info"><i class="bi bi-cart-fill"></i> Cart: ${cart==null? 0:cart.numOfProducts} product(s)</button></a>
                            </c:if>

                            <c:if test="${user == null}">                                
                                <a href="<c:url value="/home/register.do"/>"><button class="btn btn-primary"><i class="bi bi-person-plus-fill"></i> Register</button></a>
                                <a href="<c:url value="/home/login.do"/>"><button class="btn btn-outline-primary"><i class="bi bi-box-arrow-in-right "></i> Login</button></a>
                            </c:if>

                            <c:if test="${user != null}">                            
                                <a href="<c:url value="/acc/updateAccount.do"/>"><button class="btn btn-outline-primary"><i class="bi bi-person-check-fill"></i> Welcome ${user.name}</button></a> 
                                <a href="<c:url value="/acc/logout.do"/>"><button class="btn btn-outline-primary"><i class="bi bi-box-arrow-left"></i> Logout</button></a> 
                            </c:if>
                        </div>
                    </div>
                    <hr/>
                </div>
            </div>      




            <!--body-->
            <div class="row content py-3">
                <div class="col">                    
                    <jsp:include page="/WEB-INF/views/${controller}/${action}.jsp" />
                </div>
            </div>



            <!--footer-->
            <div class="row footer">
                <div class="col">
                    <hr/>
                    &copy; Copyright 2021-2022 PRJ. All Rights Reserved.
                </div>
            </div>
        </div>        
    </body>
</html>