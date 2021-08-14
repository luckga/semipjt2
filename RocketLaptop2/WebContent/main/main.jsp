<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="header.jsp" />
		<title>RocketLaptop</title>
		<style>
			#title{
				font-size: 30px;
				margin-top: 0px;
			}
		
			#search_input{
				width: 700px;
				border-radius: .25rem;
			}
		
			.fonticon{
				margin-left: 20px;
			}
			
			select{
				color : #495057;
				background-color : #fff;
				background-clip : padding-box;
				border : 1px solid #ced4da;
				border-radius : .25rem;
				transition : border-color .15s ease-in-out, box-shadow .15s ease-in-out;
				outline : none;
				margin-right: 6px;
			}
		
			#category{
				font-size: 25px;
			}
		
			#category > li{
				margin-right: 50px;
			}
			
			.carousel-inner img {
		   		width: 100%;
		   		height: 100%;
		  	}

			.fa-user{
				padding-left: 20px;
			}

			#nav-search{
				height:  70px;
			}
		</style>
	</head>
	<body>
		<nav class="navbar navbar-expand-sm bg-secondary navbar-dark pt-3 justify-content-center" id="nav-search">
			<a class="navbar-brand" id="title" href="#">RocketLaptop</a>
			<form class="form-inline" action="#">
				<div class="input-group">
					<select id="viewcount" name="search_field">
						<option value="0" selected>상품명</option>
						<option value="1">브랜드명</option>
					</select>
					<input class="form-control mr-sm-2" id="search_input" type="text" placeholder="상품명을 입력하세요">
					<button class="btn btn-success" type="submit">검색</button>
				</div>
			</form>
			<ul class="navbar-nav">
				<c:if test="${id == 'admin'}">
					<li class="nav-item">
						<a class="nav-link fonticon" href="NoticeList.ad"><i class="fas fa-user fa-2x"></i><br>관리자 페이지</a>
					</li>
				</c:if>
				<c:if test="${id != 'admin' || empty id}">
					<li class="nav-item">
						<a class="nav-link fonticon" href="#"><i class="fas fa-user fa-2x"></i><br>마이 페이지</a>
					</li>
					<li class="nav-item">
						<a class="nav-link fontiocn" href="#"><i class="fas fa-shopping-cart fa-2x"></i><br>장바구니</a>
					</li>
				</c:if>
			</ul>
		</nav>
		<nav class="navbar navbar-expand-sm bg-dark navbar-dark justify-content-center">
			<ul class="navbar-nav" id="category">
				<li class="nav-item dropdown">
				 	<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
						<i class="fas fa-align-justify fa-1x"></i> 카테고리
				  	</a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="#">브랜드명</a>
						<a class="dropdown-item" href="#">브랜드명</a>
						<a class="dropdown-item" href="#">브랜드명</a>
				  	</div>
				</li>
				
			  	<li class="nav-item">
					<a class="nav-link" href="#">새로운 상품</a>
			  	</li>
			  	<li class="nav-item">
					<a class="nav-link" href="#">베스트 상품</a>
			 	 </li>
			  	<li class="nav-item">
					<a class="nav-link" href="#">공지사항</a>
			 	 </li>
			  	<li class="nav-item">
					<a class="nav-link" href="#">문의사항</a>
			 	</li>
			</ul>
		</nav>

		  <!--banner-->
		<div class="container">
			<div id="demo" class="carousel slide" data-ride="carousel">
				<ul class="carousel-indicators">
					<li data-target="#demo" data-slide-to="0" class="active"></li>
					<li data-target="#demo" data-slide-to="1"></li>
					<li data-target="#demo" data-slide-to="2"></li>
				</ul>
				<div class="carousel-inner">
					<div class="carousel-item active">
						<img src="image/banner.png" alt="Los Angeles" width="1100" height="500">
						<div class="carousel-caption">
							<h3>Los Angeles</h3>
							<p>We had such a great time in LA!</p>
						</div>   
					</div>
					<div class="carousel-item">
						<img src="image/banner.png" alt="Chicago" width="1100" height="500">
						<div class="carousel-caption">
							<h3>Chicago</h3>
							<p>Thank you, Chicago!</p>
						</div>   
					</div>
					<div class="carousel-item">
						<img src="image/banner.png" alt="New York" width="1100" height="500">
						<div class="carousel-caption">
							<h3>New York</h3>
							<p>We love the Big Apple!</p>
						</div>   
					</div>
				</div>
				<a class="carousel-control-prev" href="#demo" data-slide="prev">
					<span class="carousel-control-prev-icon"></span>
				</a>
				<a class="carousel-control-next" href="#demo" data-slide="next">
					<span class="carousel-control-next-icon"></span>
				</a>
			</div>
		</div>

		<!--bestproduct-->
		<div class="container mt-5 mb-5">
			<h3>베스트 상품</h3>
			<div class="row row-cols-1 row-cols-md-3 g-4">
				<div class="col">
					<div class="card h-100">
						<img src="image/account_user.png" class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="card-title">상품 이름</h5>
							<p class="card-text">상품 설명</p>
						</div>
						<div class="card-footer">
							<a href="#">자세히 보기</a>	
						</div>
					</div>
				</div>
				<div class="col">
					<div class="card h-100">
						<img src="image/among us.png" class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="card-title">상품 이름</h5>
							<p class="card-text">상품 설명</p>
						</div>
						<div class="card-footer">
							<a href="#">자세히 보기</a>
						</div>
					</div>
				</div>
				<div class="col">
					<div class="card h-100">
						<img src="image/android_robot.png" class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="card-title">상품 이름</h5>
							<p class="card-text">상품 설명</p>
						</div>
						<div class="card-footer">
							<a href="#">자세히 보기</a>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!--newproduct-->
		<div class="container mb-5">
			<h3>새로운 상품</h3>
			<div class="row row-cols-1 row-cols-md-3 g-4">
				<div class="col">
					<div class="card h-100">
						<img src="image/heart.png" class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="card-title">상품 이름</h5>
							<p class="card-text">상품 설명</p>
						</div>
						<div class="card-footer">
							<a href="#">자세히 보기</a>
						</div>
					</div>
				</div>
				<div class="col">
					<div class="card h-100">
						<img src="image/social.png" class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="card-title">상품 이름</h5>
							<p class="card-text">상품 설명</p>
						</div>
						<div class="card-footer">
							<a href="#">자세히 보기</a>
						</div>
					</div>
				</div>
				<div class="col">
					<div class="card h-100">
						<img src="image/user.png" class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="card-title">상품 이름</h5>
							<p class="card-text">상품 설명</p>
						</div>
						<div class="card-footer">
							<a href="#">자세히 보기</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="footer.jsp" />
	</body>
</html>