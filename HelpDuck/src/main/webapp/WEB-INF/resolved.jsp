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
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
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
					<li><a class="dropdown-item" href="/profile">Profile</a></li>
					<li><a class="dropdown-item" href="/dashboard">Dashboard</a></li>
				    <li><a class="dropdown-item" href="/ticket/add">Ask For Help</a></li>
				    <li><a class="dropdown-item" href="/resolved">Resolved Tickets</a></li>
				    <li><a class="dropdown-item" href="/timer">Timer</a></li>
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
			<h1 class="title">Resolved Tickets</h1>
	    	<div class="card-container row row-cols-1 row-cols-md-4 g-4">
				<c:forEach items="${allTickets}" var="t">
					<c:if test="${ t.resolved == true }">
						<div class="post-it" style="width: 18rem">
							<div class="card-body">
								<div class="card-body-top">
									<h5 class="card-title title-hover">
										<span><a href="/ticket/${t.id}/view">${t.title}</a></span>
									</h5>
									<div class="subtitle-container">
										<h6 class="card-subtitle mb-2 text-muted">
											${t.user.name}
										</h6>
										<h6 class="card-subtitle mb-2 text-muted">${t.type}</h6>
									</div>
								</div>
								<p class="card-text overflow">${t.description}</p>
								<div class="space">
									<p class="card-text"><fmt:formatDate type = "both" dateStyle = "short" timeStyle = "short" value = "${t.createdAt}" /></p>
									<c:if test="${ t.resolved }">
										<div class="resolved">
											<p>RESOLVED</p>
											<span class="material-symbols-outlined check">check_circle</span>
										</div>
									</c:if>
								</div>
								<div>
									<c:if test="${ user_id == t.user.id }">
										<div class="wrapper">
											<div class="icon-container">
												<a href="/ticket/${t.id}/edit" class="card-link"><span class="material-symbols-outlined">edit_note</span></a>
												<a href="/ticket/${t.id}/delete" class="card-link"><span class="material-symbols-outlined">delete_forever</span></a>
											</div>
										</div>
									</c:if>
									<c:if test="${ user_id != t.user.id }">
										<c:if test="${ t.likedUsers.contains(theUser) == false }">
											<form action="/ticket/bookmark/${ t.id }" method="post">
												<input type="hidden" name="_method" value="put">
												<section>
											    	<input type="hidden" name="userId" value="${ user_id }" />
											    </section>
											    <button class="bookmark-btn">
											    	<span class="material-symbols-outlined">bookmark</span>
											    </button>
											</form>
										</c:if>
									</c:if>
								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
    </main>
    <footer>
    
    </footer>
</body>
</html>