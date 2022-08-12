<%-- 
    Document   : invoiceDetail
    Created on : Mar 21, 2022, 10:37:50 PM
    Author     : Thành Wasabi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!--USER-->
<nav class="d-flex justify-content-between">
    <a href="<c:url value="/user/invoice.do"/>"><button class="btn btn-outline-info"><i class="bi bi-cart-fill"></i>View previous orders</button></a>

    <div class="col-4">
        <form class="d-flex" action="<c:url value="/home/searchProduct.do"/>">
            <input class="form-control me-2" type="search" name="searchValue" value="${searchValue}" >
            <button class="btn btn-outline-success" type="submit"><i class="bi bi-search"></i></button>
        </form>
    </div>
</nav>

<hr/>
<table class="table table-striped">
    <thead>
        <tr>           
            <th class="text-center">Order ID</th>
            <th class="text-center">Product ID</th>
            <th class="text-right">Quantity</th>
            <th class="text-right">Price</th>
            <th class="text-right">Discount</th>
            <th class="text-right">Total</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="orderDetail" items="${list}" varStatus="loop" >
            <c:if test="${orderDetail.orderId.id == orderHeader.id}">
            <form>
                <tr>                   
                    <td class="text-center">${orderDetail.orderId.id}</td>                           
                    <td class="text-center">${orderDetail.productId.description}</td>                                          
                    <td class="text-right">${orderDetail.quantity}</td>                                          
                    <td class="text-right"><fmt:formatNumber value="${orderDetail.price}" type="currency"/></td>                                          
                    <td class="text-right"><fmt:formatNumber value="${orderDetail.discount}" type="percent"/></td>                                          
                    <td class="text-right"><fmt:formatNumber value="${orderDetail.price*orderDetail.quantity - orderDetail.price * orderDetail.discount * orderDetail.quantity}" type="currency"/></td>                                          
                </tr>
            </form>
        </c:if>
    </c:forEach>

</tbody>

</table>
