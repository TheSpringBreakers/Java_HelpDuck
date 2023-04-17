<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- for forms -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!-- for validation -->
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<!-- for Bootstrap CSS -->
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<!-- YOUR own local CSS -->
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Coiny&family=Shadows+Into+Light&family=Sono:wght@400;500&display=swap" rel="stylesheet">
<!-- For any Bootstrap that uses JS -->
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>Help Duck</title>
</head>
<body>
	<header class="header-container">
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		  <div class="container-fluid">
		    <a class="navbar-brand" href="#"><span><img src="/images/duck1.png" alt="duck brand pic" class="header-pic" /></span>Help Duck</a>
		  </div>
		</nav>
	</header>
    <main>
    	<div class="d-flex flex-row">
	    	<form:form action="/register" method="POST" modelAttribute="newUser" class="w-50 h-auto m-2 logReg-form">
	    		<div class="text-center py-2">
                    <h3>Register</h3>
                </div>
				<section class=" py-2">
					<form:label path="name" class="border-end w-50 ps-2 me-1">Name</form:label>
					<form:input type="text" class="input" path="name" />
					<form:errors path="name" class="text-danger ps-2" />
				</section>
				<section class=" py-2">
					<form:label path="email" class="border-end w-50 ps-2 me-1">Email</form:label>
					<form:input type="email" class="input" path="email" />
					<form:errors path="email" class="text-danger ps-2" />
				</section>
				<section class=" py-2">
					<form:label path="password" class="border-end w-50 ps-2 me-1">Password</form:label>
					<form:input type="password" class="input" path="password" />
					<form:errors path="password" class="text-danger text-right" />
				</section>
				<section class=" py-2">
					<form:label path="confirmPassword" class="border-end w-50 ps-2 me-1">Confirm Password</form:label>
					<form:input type="password" class="input" path="confirmPassword" />
					<form:errors path="confirmPassword" class="text-danger ps-2" />
				</section>
				<div class="p-2">
                    <button class="button-52 my-1 w-100" role="button">Register and Login</button>
                </div>
			</form:form>
					
			<form:form action="/login" method="POST" modelAttribute="newLogin" class="w-50 m-2 logReg-form">
				<div class=" text-center py-2">
                    <h3>Login</h3>
                </div>
				<section class=" py-2">
					<form:label path="email" class="border-end w-50 ps-2 me-1">Email</form:label>
					<form:input type="email" class="input" path="email" />
					<form:errors path="email" class="text-danger" />
				</section>
				<section class=" py-2">
					<form:label path="password" class="border-end w-50 ps-2 me-1">Password</form:label>
					<form:input type="password" class="input" path="password" />
					<form:errors path="password" class="text-danger" />
				</section>
				<div class=" p-2">
                    <button class="button-52 my-1 w-100" role="button">Login</button>
                </div>
			</form:form>
    	</div>
    </main>
    <footer>
    
    </footer>
</body>
</html>