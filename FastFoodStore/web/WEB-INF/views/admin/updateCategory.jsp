<%-- 
    Document   : updateCategory
    Created on : Mar 22, 2022, 9:27:16 AM
    Author     : SE161867 Pham Tran Duy Tue
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
    
<h1>Update Category</h1>
<hr/>
<!--<div class="container mt-3">
    <form action="editProduct.do">
<c:forEach var="category" items="${list}">
    <tr>
        <td class="text-right"><input type="hidden" value="${category.id}" name="id">${user.id}</td>
        <td class="text-right"><input type="hidden" value="${category.name}" name="name">${category.name}</td>
        <td class="text-right"><input type="hidden" value="${category.status}" name="address">${category.status}</td>
        <td class="text-right"><a href="updateUser.do?op=UpdateForm&id=${category.id}">Edit</a></td>
    </tr>
</c:forEach>
</form>
</div>-->

<div class="container mt-3">

    <table class="table table-bordered">
        <tr>
            <th class="text-centre">Id</th>
            <th class="text-centre">Name</th>
            <th class="text-centre">Status</th>
            <th class="text-centre">Operation</th>
        </tr>
        <c:forEach var="category" items="${list}">
            <form action="<c:url value="/admin/editCategory.do"/>">
                <tr>
                    <td class="text-centre"><input type="hidden" value="${category.id}" name="id">${category.id}</td>
                    <td class="text-centre"><input type="hidden" value="${category.name}" name="name">${category.name}</td>

                    <td>
                        <select name="enabled">
                            <option value="0" ${category.status==false?"selected":""}>Inactive</option>
                            <option value="1" ${category.status==true?"selected":""}>Active</option>
                        </select>
                    </td>

                    <td><input type="submit" name="op" value="Edit"/></td>
                </tr>
            </form>
        </c:forEach>
    </table>
</div>
