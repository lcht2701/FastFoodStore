<%-- 
    Document   : index
    Created on : Mar 6, 2022, 8:34:52 PM
    Author     : SE162033 Nguyen Vuong Bach
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<table class="table table-striped table-hover">
    <thead>
        <tr>
            <th class="text-right">No.</th>
            <th class="text-right">Id</th>
            <th>Image</th>
            <th>Description</th>
            <th class="text-right">Old Price</th>
            <th class="text-right">Discount</th>
            <th class="text-right">New Price</th>
            <th class="text-right">Quantity</th>
            <th class="text-right">Cost</th>
            <th class="text-center">Operation</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="item" items="${cart.items}" varStatus="loop">

        <form>
            <tr>
                <td class="text-right">${loop.count}</td>
                <td class="text-right">${item.id}</td>
                <td><img src="<c:url value="/products/${item.id}.jpg"/>" height="40px"/></td>
                <td>${item.description}</td>
                <td class="text-right"><fmt:formatNumber value="${item.price}" type="currency" /></td>
                <td class="text-right"><fmt:formatNumber value="${item.discount}" type="percent" /></td>
                <td class="text-right"><fmt:formatNumber value="${item.newPrice}" type="currency" /></td>
                <td class="text-right"><input type="number" value="${item.quantity}" name="quantity" min="0"></td>
                <td class="text-right"><fmt:formatNumber value="${item.cost}" type="currency" /></td>
                <td class="d-flex justify-content-center">
                    <input type="hidden" value="${item.id}" name="id" />
                    <button type="submit" class="btn btn-info mx-1" formaction="<c:url value="/cart/update.do"/>"><i class="bi bi-arrow-clockwise"></i> Update</button>
                    <button type="submit" class="btn btn-warning mx-1" formaction="<c:url value="/cart/delete.do"/>"><i class="bi bi-cart-dash-fill"></i> Delete</button>
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
        <td></td>
        <td class="text-right">Total</td>
        <td class="text-right"><fmt:formatNumber value="${cart==null? 0:cart.total}" type="currency" /></td>
        <td></td>

    </tr>    
</tfoot>
</table>


<div class="d-flex flex-row-reverse row">    
    <form class="d-flex flex-row-reverse bd-highlight my-2" action="<c:url value="/cart/checkout.do"/>">        
        <button type="submit" class="btn btn-outline-success"><i class="bi bi-cart-check-fill"></i></i>Checkout</button>
        <div class="col-sm-6">
            <div class="input-group px-2">
                <input type="hidden" value="${item.id}" name="id" />
                <span class="input-group-text" id="basic-addon1"><i class="bi bi-geo-alt-fill"></i></span>
                <input type="text" class="form-control" placeholder="Shipping Address" value="${shippingAddress}" name="shippingAddress" required=""/>
            </div>
        </div>
    </form> 
    <div class="d-flex flex-row-reverse bd-highlight my-2"><a href="<c:url value="/cart/empty.do"/>" ><button class="btn btn-outline-danger"><i class="bi bi-cart-x-fill"></i></i>Empty your cart</button></a></div>
</div>
