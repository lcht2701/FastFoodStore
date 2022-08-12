<%-- 
    Document   : updateProduct
    Created on : Mar 21, 2022, 10:30:45 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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

<h1>Update Product</h1>
<hr/>
<div class="container mt-3">
    <form action="editProduct.do">
        <table class="table">
            <tr>
                <td>Product ID</td>
                <td><input type="text" name="id1" value="${product.id}" style="width:300px;" disabled/></td>
                <td><input type="hidden" name="id" value="${product.id}" style="width:300px;"/></td>
            </tr>
            <tr>
                <td>Description</td>
                <td><input type="text" name="description" value="${product.description}" style="width:300px;"/></td>
            </tr>
            <tr>
                <td>Price</td>
                <td><input type="text" name="price" value="${product.price}" style="width:300px;"/></td>
            </tr>
            <tr>
                <td>Discount</td>
                <td><input type="text" name="discount" value="${product.discount}" style="width:300px;"/></td>
            </tr>
            <tr>
                <td>Category Name</td>
                <td>
                    <select name="categoryId">
                        <c:forEach var="category" items="${list}">
                            <option ${category.id == product.categoryId.id? "selected":""} value="${category.id}">${category.name}</option>
                        </c:forEach>
                    </select>
                    <!--                            <select name="categoryId">
                                                    <option value="1" ${product.categoryId.id=="1"?"selected":""}>${list[0].name}</option>
                                                    <option value="2" ${product.categoryId.id=="2"?"selected":""}>${list[1].name}</option>
                                                    <option value="3" ${product.categoryId.id=="3"?"selected":""}>${list[2].name}</option>
                                                    <option value="4" ${product.categoryId.id=="4"?"selected":""}>${list[3].name}</option>
                                                </select>   -->
                </td>
            </tr
            <tr>
                <td>Enabled</td>
                <td><select name="enabled">
                        <option value="0" ${product.enabled==false?"selected":""}>Không bán</option>
                        <option value="1" ${product.enabled==true?"selected":""}>Bán</option>
                    </select></td>
            </tr>
            <tr>
                <td></td>
                <td><button type="submit" class="btn btm-sm btn-success"><i class="bi bi-pencil-square"></i> Update</button></td>
            </tr>
        </table>
    </form>
</div>

