<%-- 
    Document   : invoice
    Created on : Mar 20, 2022, 3:43:06 PM
    Author     : SE161707 Le Thanh Dat
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
            <th class="text-center">#</th>
            <th class="text-center">Invoice ID</th>
            <th class="text-center">Time Date</th>
            <th class="text-center">Status</th>
            <th class="text-center" hidden="">Customer</th>
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
                <td class="text-center"><input type="hidden" value="${orderHeader.customerId.id}" name="customerId" />
                </td>
                <td>
                    <input type="hidden" value="${orderHeader.id}" name="id" />
                    <button type="submit" class="btn btn-outline-success" formaction="<c:url value="/user/invoiceDetail.do"/>">Show Detail</button>
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
