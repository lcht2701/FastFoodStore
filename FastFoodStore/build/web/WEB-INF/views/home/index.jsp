<%-- 
    Document   : index
    Created on : Mar 1, 2022, 4:39:53 PM
    Author     : SE161707 Le Thanh Dat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!--Search bar-->
<nav class="d-flex justify-content-end">
    <div class="col-4">
        <form class="d-flex" action="<c:url value="/home/searchProduct.do"/>">
            <input class="form-control me-2" type="search" name="searchValue" value="${searchValue}" >
            <button class="btn btn-outline-success" type="submit"><i class="bi bi-search"></i></button>
        </form>
    </div>
</nav>
<hr/>
            
            
<div class="row">
    <c:forEach var="product" items="${list}">
        <c:if test="${product.enabled == true}">
            <div class="col-12 col-md-6 col-lg-4 my-1">
                <div class="card">
                    <img src="<c:url value="/products/${product.id}.jpg"/>" class="card-img-top"/>

                    <div class="card-body">
                        <form action="<c:url value="/cart/add.do"/>" class="card-body">
                            <input type="hidden" value="${product.id}" name="id">
                            <h5 class="card-title text-center">${product.description}</h5>
                            <p class="card-text">
                                Price:
                                <c:if test="${product.discount>0}">
                                <strike><fmt:formatNumber value="${product.price}" type="currency"/></strike>                     
                                <span class="text-danger"><fmt:formatNumber value="${product.price*(1-product.discount)}" type="currency"/></span><br/>
                                Discount: <fmt:formatNumber value="${product.discount}" type="percent"/><br/>
                            </c:if>
                            <c:if test="${product.discount==0}">
                                <fmt:formatNumber value="${product.price}" type="currency"/><br/><br/>
                            </c:if>
                            Quantity:
                            <input type="number" min="1" name="quantity" value="1" class="col-4"/><br/>
                            </p> 

                            <div class="center-button">
                                <button type="submit" class="btn btm-sm btn-info"><i class="bi bi-cart-plus-fill"></i> Add to cart</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>


        </c:if>
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
