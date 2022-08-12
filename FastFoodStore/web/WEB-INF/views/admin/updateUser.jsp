<%-- 
    Document   : updateUser
    Created on : Mar 20, 2022, 2:39:54 PM
    Author     : SE162033 Nguyen Vuong Bach
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

<h1>Information of User</h1>
<hr/>
<div class="container mt-3">
    <form action="<c:url value="/admin/editUser.do"/>" method="post">
        <table class="table">
            <tr>
                <td>Id</td>
                <td><input type="text" name="id" value="${user.id}" style="width:300px;" disabled=""/>
                <input type="hidden" name="id" value="${user.id}" style="width:300px;" />
                </td>
            </tr>
            <tr>
                <td>Name</td>
                <td><input type="text" name="name" value="${user.name}" style="width:300px;"/></td>
            </tr>
            <tr>
                <td>Address</td>
                <td><input type="text" name="address" value="${user.address}" style="width:300px;"/></td>
            </tr>
            <tr>
                <td>Phone</td>
                <td><input type="text" name="phone" value="${user.phone}" style="width:300px;"/></td>
            </tr>
            <tr>
                <td>Email</td>
                <td><input type="text" name="email" value="${user.email}" style="width:300px;"/></td>
            </tr
            <tr>
                <td>User Name</td>
                <td><input type="text" name="username" value="${user.username}" style="width:300px;"/></td>
            </tr>
            <tr>
                <td>Password</td>
                <td><input type="password" name="pass" value="${user.password}" style="width:300px;"/></td>
            </tr>
            <tr>
                <td>Status</td>
                <td><select name="enabled">
                        <option value="0" ${user.enabled==false?"selected":""}>Inactive</option>
                        <option value="1" ${user.enabled==true?"selected":""}>Active</option>
                    </select></td>
            </tr>
            <tr>
                <td>Role</td>
                <td><select name="role">
                        <option value="admin" ${user.role=="admin"?"selected":""}>Admin</option>
                        <option value="customer" ${user.role=="customer"?"selected":""}>Customer</option>
                    </select></td>
            </tr>
            <tr>
                <td></td>
                <td><button type="submit" class="btn btm-sm btn-success"><i class="bi bi-pencil-square"></i> Update</button></td>
            </tr>
        </table>
    </form>
</div>