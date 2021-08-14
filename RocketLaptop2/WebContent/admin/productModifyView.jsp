<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<jsp:include page="../main/header.jsp" />
		<title>관리자 페이지 - 상품 수정</title>
		<link href="css/product/productModifyView.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="js/product/productModifyView.js"></script>
	</head>
	<body>
		<c:if test="${id == 'admin' }">
			<input type="hidden" value="${p.product_status }" class="product_status">
			<div id="showImage"><img src="${'LaptopImgUpload/'}${p.product_image}" width="100%" height="100%"></div>
			<div id="ModifyDiv" class="mt-2">
				<h1>상품 수정</h1>
				<form action="ProductModifyAction.ad" id="productModifyFrom" method="post" name="productModifyForm" enctype="multipart/form-data">
					<!-- 상품코드 -->
				    <div class="form-group text-left">
				    	<label for="product_code">상품코드</label>
				    	<input type="text" class="form-control"
				    		   id="product_code" name="product_code" value="${p.product_code}" readOnly>
				   	</div>
				   	
				   	<!-- 카테고리 -->
				    <div class="form-group text-left">
				    	<label for="category_name">카테고리</label>
				    	<input type="text" class="form-control"
				    		   id="category_name" name="category_name" value="${p.category_name}" readOnly>
				    	<input type="hidden" name="category_code" value="${p.category_code}">
				   	</div>
				   	
				   	<!-- 상품명 -->
				   	<div class="form-group text-left">
				    	<label for="product_name">상품명</label>
				    	<input type="text" class="form-control"
				    	       id="product_name" name="product_name" value="${p.product_name}">
				   	</div>
				   	
				   	<!-- 상품 가격 -->
				   	<div class="form-group text-left">
				    	<label for="product_price">가격</label>
				    	<input type="text" class="form-control"
				    	       id="product_price" name="product_price" value="${p.product_price }">
				   	</div>
		    		
				   	<!-- 상품 상세정보 -->
				   	<div class="form-group text-left">
					  	<label for="product_details">상세정보</label>
					  	<textarea class="form-control" rows="3"
					  	id="product_details" name="product_details">${p.product_details}</textarea>
				   	</div>
		    		
					<!-- 상품 재고 수 -->
					<div class="form-group text-left">
						<label for="product_stock">재고 수</label>
						<input type="text" class="form-control"
						       id="product_stock" name="product_stock" value="${p.product_stock}">
					</div>
		    		
					<!-- 상품 상태 -->
					<div class="form-group text-left" style="font-size : 25px;">
						<label for="product_status">상태 </label>
						<div class="form-check-inline">
							<label class="form-check-label" for="newProduct">
								<input type="radio" class="form-check-input" id="newProduct" name="productStatus" value="신규">신규상품
							</label>
						</div>
						<div class="form-check-inline">
							<label class="form-check-label" for="usedProduct">
								<input type="radio" class="form-check-input" id="usedProduct" name="productStatus" value="중고">중고상품
							</label>
						</div>
					</div>
		    		
					<!-- 이미지 -->
					<div class="form-group text-left">
		 				<button class="btn btn-primary" id="imgUploadbtn">이미지 첨부</button>
						<input class="form-control" type="file" id="imgUpload" name="imgUpload" accept="image/*">
						<span id="imgvalue">${p.product_image }</span>
						<img src="image/remove.png" alt="이미지삭제" width="30px" class="remove">
					</div>
				   
					<!-- 버튼 -->
					<div class="text-right mb-4">
						<button type="submit" class="btn btn-primary">수정</button>
						<button type="button" class="btn btn-danger" onClick="history.back();">취소</button>
					</div>
				</form>
				
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
			</div>
		</c:if>
	</body>
</html>