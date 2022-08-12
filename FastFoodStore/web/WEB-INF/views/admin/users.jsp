<%-- 
    Document   : user
    Created on : Mar 20, 2022, 3:42:52 PM
    Author     : SE161707 Le Thanh Dat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
<!--List of data-->

<h1>List of Users</h1>
<hr/>
<div class="container mt-3">
    <table class="table table-bordered">
        <tr>
            <th class="text-right">Id</th>
            <th class="text-left">Name</th>
            <th class="text-left">Address</th>
            <th class="text-right">Phone</th>
            <th class="text-left">Email</th>
            <th class="text-left">User Name</th>
            <th class="text-left">Password</th>
            <th class="text-left">Status</th>
            <th class="text-left">Role</th>
            <th class="text-center">Operation</th>
        </tr>
        <c:forEach var="user" items="${list}">
            <tr>
                <td class="text-right"><input type="hidden" value="${user.id}" name="id">${user.id}</td>
                <td class="text-left"><input type="hidden" value="${user.name}" name="name">${user.name}</td>
                <td class="text-left"><input type="hidden" value="${user.address}" name="address">${user.address}</td>
                <td class="text-right"><input type="hidden" value="${user.phone}" name="phone">${user.phone}</td>
                <td class="text-left"><input type="hidden" value="${user.email}" name="email">${user.email}</td>
                <td class="text-left"><input type="hidden" value="${user.username}" name="username">${user.username}</td>
                <td class="text-left"><input type="hidden" value="${user.password}" name="pass">***</td>
                <td class="text-left"><input type="hidden" value="${user.enabled}" name="enabled">${user.enabled==false?"Inactive":"Active"}</td>
                <td class="text-left"><input type="hidden" value="${user.role}" name="role">${user.role}</td>
                <td class="text-center">
                    <a href="updateUser.do?&id=${user.id}"><button type="submit" class="btn btm-sm btn-info"><i class="bi bi-pencil-square"></i> Edit</button></a>
                </td>

            </tr>
        </c:forEach>
    </table>
</div>