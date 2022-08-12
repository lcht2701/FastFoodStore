<%-- 
    Document   : account
    Created on : Mar 21, 2022, 10:10:40 PM
    Author     : SE162033 Nguyen Vuong Bach
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h1>Information of User</h1>
<hr/>
<div class="container mt-3">
    <form action="<c:url value="/acc/editAccount.do"/>" method="post">
        <table class="table">
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
                <td><input type="hidden" name="username" value="${user.username}" style="width:300px;"/>${user.username}</td>
            </tr>
            <input type="hidden" name="pass" value="${user.password}" style="width:300px;"/>
            <tr>
                <td></td>
                <td><button type="submit" class="btn btm-sm btn-success"><i class="bi bi-pencil-square"></i> Update</button></td>
            </tr>
        </table>
    </form>
</div>
