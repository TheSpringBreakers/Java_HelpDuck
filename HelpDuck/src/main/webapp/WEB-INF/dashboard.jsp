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
<link rel="stylesheet" href="/webjars/font-awesome/css/font-awesome.min.css">

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
		    <div class="collapse navbar-collapse" id="navbarNavDarkDropdown">
		      <ul class="navbar-nav float-right">
		        <li class="nav-item dropdown">
		          <a class="nav-link dropdown-toggle" href="#" id="navbarDarkDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
		            <span class="navbar-toggler-icon"></span>
		          </a>
		          <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="navbarDarkDropdownMenuLink">
					<li><a class="dropdown-item" href="/home">Home</a></li>
					<li><a class="dropdown-item" href="/dashboard">Dashboard</a></li>
				    <li><a class="dropdown-item" href="/ticket/add">Ask For Help</a></li>
				    <li><a class="dropdown-item" href="/logout">Logout</a></li>
		          </ul>
		        </li>
		      </ul>
		    </div>
		  </div>
		</nav>
	</header>
    <main>
        <video id="background-video" autoplay loop muted poster="/images/toystory.jpeg">
			<source src="/images/giphy.mp4" type="video/mp4">
		</video>
		<div class="main-container">
			<h1 class="title">Browse Help Tickets</h1>
	    	<div class="card-container row row-cols-1 row-cols-md-4 g-4">
				<c:forEach items="${allTickets}" var="t">
					<div class="card" style="width: 18rem">
						<div class="card-body">
							<h5 class="card-title">
								<span><a href="/ticket/${t.id}/view">${t.title}</a></span>
							</h5>
							<h6 class="card-subtitle mb-2 text-muted">
								${t.user.name}
							</h6>
							<p class="card-text">${t.type}</p>
							<p class="card-text">${t.description}</p>
							<p class="card-text"><fmt:formatDate type = "both" dateStyle = "short" timeStyle = "short" value = "${t.createdAt}" /></p>
							<c:if test="${ t.resolved }">
								<p>RESOLVED :)</p>
							</c:if>
							<div>
								<c:if test="${ user_id == t.user.id }">
									<a href="/ticket/${t.id}/edit" class="card-link">Edit</a>
									<a href="/ticket/${t.id}/delete" class="card-link">Delete</a>
								</c:if>
								<c:if test="${ t.likedUsers.contains(theUser) == false }">
									<form action="/ticket/bookmark/${ t.id }" method="post">
										<section>
									    	<input type="hidden" name="userId" value="${ user_id }" />
									    </section>
									    <button>
									    	<i class="fa-solid fa-bookmark" style="color: #7c93ae;">bookmark</i>
									    </button>
									</form>
								</c:if>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
    </main>
    <footer>
    
    </footer>
</body>
</html>