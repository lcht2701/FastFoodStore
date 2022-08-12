<%-- 
    Document   : register
    Created on : Mar 20, 2022, 11:32:56 AM
    Author     : SE161707 Le Thanh Dat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>




<nav class="navbar navbar-light bg-light">
    <form class="container-fluid mx-4 row g-3" action="<c:url value="/acc/register.do"/>" method="post">
        <div class="col-sm-6">
            <div class="input-group">
                <span class="input-group-text" id="basic-addon1"><i class="bi bi-person-circle"></i></span>
                <input type="text" class="form-control" placeholder="Name" value="${acc.name}" name="name" required=""/>

            </div>
        </div>
        <div class="col-sm-6">
            ${errorMessage.name}
        </div>

        <div class="col-sm-6">
            <div class="input-group">
                <span class="input-group-text" id="basic-addon1"><i class="bi bi-telephone-fill"></i></span>
                <input type="tel" class="form-control" placeholder="Phone" value="${acc.phone}" name="phone" required=""/>
            </div>
        </div>
        <div class="col-sm-6">
            ${errorMessage.phone}        
        </div>

        <div class="col-sm-6">
            <div class="input-group">
                <span class="input-group-text" id="basic-addon1"><i class="bi bi-envelope-fill"></i></span>
                <input type="email" class="form-control" placeholder="Email" value="${acc.email}" name="email" required=""/>
            </div>
        </div>

        <div class="col-sm-6">
            ${errorMessage.email}
        </div>

        <div class="col-sm-6">
            <div class="input-group">
                <span class="input-group-text" id="basic-addon1"><i class="bi bi-geo-alt-fill"></i></span>
                <input type="text" class="form-control" placeholder="Address" value="${acc.address}" name="address"/>                
            </div>
        </div>

        <div class="col-sm-6">

        </div>

        <div class="col-sm-6">
            <div class="input-group">
                <span class="input-group-text" id="basic-addon1">@</span>
                <input type="text" class="form-control" placeholder="Username" value="${acc.username}" name="username" required=""/>
            </div>
        </div>

        <div class="col-sm-6">
            ${errorMessage.username}
        </div>

        <div class="col-sm-6">
            <div class="input-group">
                <span class="input-group-text" id="basic-addon1"><i class="bi bi-key-fill"></i></span>
                <input type="password" class="form-control" placeholder="Password" name="password" required=""/>
            </div>
        </div>

        <div class="col-sm-6">
            ${errorMessage.password}
        </div>

        <div class="col-sm-6">
            <div class="input-group">
                <span class="input-group-text" id="basic-addon1"><i class="bi bi-key-fill"></i></span>
                <input type="password" class="form-control" placeholder="Confirm Password" name="passwordConfirm" required=""/>
            </div>
        </div>

        <div class="col-sm-6"></div>
        <div class="col-sm-6">
            <button type="submit" class="btn btn-primary ">
                <i class="bi bi-box-arrow-in-right "></i> Register
            </button>
        </div>
        <div class="mx-5">${message}</div>


    </form>
</nav>


