<%-- 
    Document   : invoice
    Created on : Mar 20, 2022, 3:43:06 PM
    Author     : SE161707 Le Thanh Dat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!--3 functions for admin-->
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
            <th class="text-center">Invoice ID</th>
            <th class="text-center">Time Date</th>
            <th class="text-center">Status</th>
            <th class="text-center">Customer</th>
            <th class="text-center">Operation</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="orderHeader" items="${list}" varStatus="loop">
        <form>
            <tr>
                <td class="text-center">${loop.count}</td>
                <td class="text-center">${orderHeader.id}</td>                           
                <td class="text-center"><fmt:formatDate value="${orderHeader.date}" /></td>
                <td class="text-center">${orderHeader.status}</td>
                <td class="text-center">${orderHeader.customerId.id}</td>
                <td>
                    <input type="hidden" value="${orderHeader.id}" name="id" />
                    <button type="submit" class="btn btn-outline-success" formaction="<c:url value="/admin/invoiceDetail.do"/>">Show Detail</button>
                </td>
            </tr>
        </form>
    </c:forEach>

</tbody>
<tfoot>
    <tr>
        <td></td>           
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>    
</tfoot>
</table>
