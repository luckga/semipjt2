<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
	$(function(){
		$('#loginErrorModal').modal('show');
	});
</script>
<c:if test="${id == 'admin' }">
	<div class="container">
		<h1 id="title"><a href="main.ma"><img src="image/RocketLaptop.png" width="100px" id="mainPageImg">메인페이지</a></h1>
		<br>
		<ul class="nav nav-tabs nav-justified">
			<li class="nav-item">
				<a class="nav-link" href="NoticeList.ad">공지사항 목록</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="ProductList.ad">상품 목록</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="UserList.ad">회원 목록</a>
			</li>
		</ul>
	</div>
</c:if>

<c:if test="${id != 'admin' || id == null }">
	<div class="modal hide fade" id="loginErrorModal">
		<div class="modal-dialog modal-sm modal-dialog-centered">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">로그인 오류</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
		        
		        <!-- Modal body -->
				<div class="modal-body">
					<h4>관리자로 로그인 해주십시오.</h4>
				</div>
		        
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" onClick="location.href='main.ma'">확인</button>
				</div>
			</div>
		</div>
	</div>
</c:if>