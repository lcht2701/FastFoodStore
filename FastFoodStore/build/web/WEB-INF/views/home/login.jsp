<%-- 
    Document   : login
    Created on : Mar 20, 2022, 11:17:07 AM
    Author     : SE161707 Le Thanh Dat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<nav class="navbar navbar-light bg-light">
    <form class="container-fluid mx-4" action="<c:url value="/acc/login.do"/>" method="post">
        <div class="input-group my-1">
            <span class="input-group-text" id="basic-addon1">@</span>
            <input type="text" class="form-control" placeholder="Username" value="${username}" name="username"/>
        </div>
        <div class="input-group my-1">
            <span class="input-group-text" id="basic-addon1"><i class="bi bi-key-fill"></i></span>
            <input type="password" class="form-control" placeholder="Password" name="password"/>
        </div>
        <button type="submit" class="btn btn-primary my-1 px-3">
            <i class="bi bi-box-arrow-in-right "></i> Login 
        </button>
    </form>

    <a href="<c:url value="/home/register.do"/>"><button class="btn btn-outline-primary my-1 mx-5"><i class="bi bi-person-plus-fill"></i> Create an Account</button></a> <br>
    <div class="mx-5">${message}</div>
</nav>
