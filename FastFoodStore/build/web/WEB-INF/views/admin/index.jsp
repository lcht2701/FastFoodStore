<%-- 
    Document   : index
    Created on : Mar 20, 2022, 3:11:28 PM
    Author     : SE161707 Le Thanh Dat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!--List of data-->
<nav class="d-flex justify-content-between">
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
    <div class="col-4">
        <!--Search bar-->
        <form class="d-flex" action="<c:url value="/home/searchProduct.do"/>">
            <input class="form-control me-2" type="search" name="searchValue" value="${searchValue}" >
            <button class="btn btn-outline-success" type="submit"><i class="bi bi-search"></i></button>
        </form>
    </div>
</nav>
<hr/>

<div class="row">
    <c:forEach var="product" items="${list}">

        <div class="col-12 col-md-6 col-lg-4 p-2">

            <div style="height: 295px"><img src="<c:url value="/products/${product.id}.jpg"/>" width="100%"/></div><br/>

            <input type="hidden" value="${product.id}" name="id">
            Id: ${product.id}<br/>
            Description: ${product.description}<br/>
            Price:  <strike><fmt:formatNumber value="${product.price}" type="currency"/></strike> 
            <span class="text-danger"><fmt:formatNumber value="${product.price*(1-product.discount)}" type="currency"/></span><br/>
            Discount: <fmt:formatNumber value="${product.discount}" type="percent"/><br/>
            Category: ${product.categoryId.name}<br/>
            Status: 
            <span>
                <c:if test="${product.enabled == true}">Bán</c:if>
                <c:if test="${product.enabled == false}">Không bán</c:if>               
                </span><br/>
                <div class="center-button">
                    <a href="<c:url value="/admin/updateProduct.do?id=${product.id}"/>"><button class="btn btn-info"><i class="bi bi-pencil-square"></i> Edit</button></a>
            </div>

        </div>

    </c:forEach>
</div>


<!--Pagination-->
<c:if test="${searchValue=='' or searchValue==null}">
    <div class="row">
        <div class="col" style="text-align: right;">
            <br/>
            <form action="<c:url value="/home/index.do" />">
                <button type="submit" class="btn btn-sm btn-info" name="op" value="FirstPage" title="First Page" <c:if test="${pageNum==1}">disabled</c:if>><i class="bi bi-chevron-bar-left"></i></button>
                <button type="submit" class="btn btn-sm btn-info" name="op" value="PreviousPage" title="Previous Page" <c:if test="${pageNum==1}">disabled</c:if>><i class="bi bi-chevron-left"></i></button>
                <button type="submit" class="btn btn-sm btn-info" name="op" value="NextPage" title="Next Page" <c:if test="${pageNum==totalPage}">disabled</c:if>><i class="bi bi-chevron-right"></i></button>
                <button type="submit" class="btn btn-sm btn-info" name="op" value="LastPage" title="Last Page" <c:if test="${pageNum==totalPage}">disabled</c:if>><i class="bi bi-chevron-bar-right"></i></button>
                <input type="number" name="gotoPage" value="${pageNum}" min="1" max="${totalPage}" class="btn btn-sm btn-outline-default" style="text-align: right;width: 40px;" title="Enter page number"/>
                <button type="submit" class="btn btn-sm btn-info" name="op" value="GotoPage" title="Goto Page"><i class="bi bi-arrow-up-right-circle"></i></button>
            </form>
            Page ${pageNum}/${totalPage}
        </div>
    </div>
</c:if>

