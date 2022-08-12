<%-- 
    Document   : invoiceDetail
    Created on : Mar 21, 2022, 10:37:50 PM
    Author     : Thành Wasabi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="btn-group">
    <!--Functions for admin-->
    <button id="btnGroupDrop" type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
        <i class="bi bi-tools"></i> Admin functions
    </button>
    <ul class="dropdown-menu" aria-labelledby="btnGroupDrop" >
        <li><a class="dropdown-item" href="<c:url value="/admin/index.do"/>"><i class="bi bi-cart-fill"></i> Products Management</a></li>
        <li><a class="dropdown-item" href="<c:url value="/admin/users.do"/>"><i class="bi bi-person-badge-fill"></i> Users Management</a></li>
        <li><a class="dropdown-item" href="<c:url value="/admin/invoice.do"/>"><i class="bi bi-receipt-cutoff"></i> Orders Management</a></li>
        <li><a class="dropdown-item" href="<c:url value="/admin/categories.do"/>"><i class="bi bi-tags-fill"></i> Categories Management</a></li>
    </ul>
</div>

<hr/>
<table class="table table-striped">
    <thead>
        <tr>           
            <th class="text-center">#</th>
            <th class="text-center">ID</th>
            <th class="text-center">Order ID</th>
            <th class="text-center">Product ID</th>
            <th class="text-center">Quantity</th>
            <th class="text-center">Price</th>
            <th class="text-center">Discount</th>
            <th class="text-center">Total</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="orderDetail" items="${list}" varStatus="loop">
            <c:if test="${orderDetail.orderId.id == orderHeader.id}">
            <form>
                <tr>
                    <td class="text-center">${loop.count}</td>
                    <td class="text-center">${orderDetail.id}</td>                           
                    <td class="text-center">${orderDetail.orderId.id}</td>                           
                    <td class="text-center">${orderDetail.productId.description}</td>                                          
                    <td class="text-right">${orderDetail.quantity}</td>                                          
                    <td class="text-right"><fmt:formatNumber value="${orderDetail.price}" type="currency"/></td>                                          
                    <td class="text-right"><fmt:formatNumber value="${orderDetail.discount}" type="percent"/></td>                                          
                    <td class="text-center"><fmt:formatNumber value="${orderDetail.price*orderDetail.quantity - orderDetail.price * orderDetail.discount * orderDetail.quantity}" type="currency"/></td>                                          
                </tr>
            </form>
        </c:if>
    </c:forEach>

</tbody>
<tfoot>
    <tr>
        <td></td>           
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>Total</td>
        <td></td>
        <td class="text-right"><fmt:formatNumber value="${orderDetail.total}" type="currency"/></td>
    </tr>    
</tfoot>
</table>
