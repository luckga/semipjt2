<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');

	*{
		font-family: 'Do Hyeon', sans-serif;
	}

	 #nav-top{
		height: 40px;
		font-size: 25px;
	 }

	.navbar-dark .navbar-nav .nav-link {
		color: rgb(255, 255, 255);
	}
	
	#loginUser{
		color : white;
	}
	
	.logoutbtn{
		color : white;
	}
	
	footer{
		height : 80px;
	}
	
	#logo{
		float : left;
	}
</style>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark justify-content-end" id="nav-top">
	<ul class="navbar-nav">
		<c:if test="${!empty id}">
			<c:if test="${id == 'admin' }">
				<li class="nav-item">
					<span id="loginUser">관리자님 </span><a href="logout.ma" class="logoutbtn">(로그아웃)</a>
				</li>
			</c:if>
			<c:if test="${id != 'admin'}">
				<li class="nav-item">
					<span id="loginUser">${id}님 </span><a href="logout.ma" class="logoutbtn">(로그아웃)</a>
				</li>
			</c:if>
		</c:if>
		<c:if test="${empty id}">
			<li class="nav-item">
				<a class="nav-link" href="login.ma">로그인</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="#">회원가입</a>
			</li>
		</c:if>
	</ul>
</nav>