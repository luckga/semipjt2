<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<jsp:include page="../main/header.jsp" />
		<jsp:include page="AdminNav.jsp" />
		<title>관리자 페이지 - 유저 목록</title>
		<link href="css/admin/adminNav.css" type="text/css" rel="stylesheet">
		<style>
			.container > h1{
				text-align : center;
				margin-top: 8px;
			}
			
			.container > h1 > a{
				color : black;
			}
		</style>
	</head>
	<body>
		<div class="container">
			<c:if test="${id == 'admin'}">
				<h1><a href="#">회원 목록</a></h1>
				<form action="#" method="post">
				    <div class="input-group">
				        <select id="viewcount" name="search_field">
				            <option value="0" selected>아이디</option>
				            <option value="1">이름</option>
				            <option value="2">성별</option>
				            <option value="3">이메일</option>
				            <option value="3">전화번호</option>
				        </select>
				        <input name="search_word" type="text" class="form-control"
				               placeholder="아이디 입력하세요" value="${search_word}">
				        <button id="search" class="btn btn-primary" type="submit">검색</button>
				    </div>
				</form>
				<h2>회원 수 : 1</h2>
				<table class="table table-striped table-bordered text-center">
					<thead>
						<tr>
							<th>프로필사진</th>
							<th>아이디</th>
							<th>이름</th>
							<th>생년월일</th>
							<th>성별</th>
							<th>이메일</th>
							<th>전화번호</th>
							<th>주소</th>
							<th>가입일</th>
							<th>수정</th>
						</tr>
					</thead>
					<tbody>
							<tr>
								<td><img src="image/among us.png" style="width : 70px;"></td>
								<td class="align-middle">JSConF66</td>
								<td class="align-middle"><a href="#">홍길동</a></td>
								<td class="align-middle">1999-01-01</td>
								<td class="align-middle">남</td>
								<td class="align-middle">JSConF66@naver.com</td>
								<td class="align-middle">010-1111-1111</td>
								<td class="align-middle">31223 서울 종로구 수표로 23길</td>
								<td class="align-middle">2021-08-13</td>
								<td class="align-middle"><button class="btn btn-primary">수정</button></td>
							</tr>
					</tbody>
				</table>
				
				<!-- 삭제 모달창 -->
				<div class="modal hide fade" id="UserDeleteModal">
					<div class="modal-dialog modal-sm modal-dialog-centered">
						<div class="modal-content">
				      
							<!-- Modal Header -->
							<div class="modal-header">
								<h4 class="modal-title">유저 삭제</h4>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>
				        
							<!-- Modal body -->
							<div class="modal-body">
								<h5>(회원이름)님을 삭제하시겠습니까??</h5>
							</div>
				        
							<!-- Modal footer -->
							<div class="modal-footer">
								<a type="button" class="btn btn-danger" href="#">삭제</a>
								<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							</div>
				        
						</div>
					</div>
				</div>
				  
				<!-- 오류 모달창 -->
				<div class="modal hide fade" id="ErrorModal">
					<div class="modal-dialog modal-sm modal-dialog-centered">
						<div class="modal-content">
				      
							<!-- Modal Header -->
							<div class="modal-header">
								<h4 class="modal-title" id="ErrorModal-Title"></h4>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>
				        
							<!-- Modal body -->
							<div class="modal-body" id="ErrorModal-body">
				          
							</div>
				        
							<!-- Modal footer -->
							<div class="modal-footer">
								<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
							</div>
				        
						</div>
					</div>
				</div>
			</c:if>
		</div>
	</body>
</html>