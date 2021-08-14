<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<jsp:include page="../main/header.jsp" />
		<title>관리자 페이지 - 상품 상세 페이지</title>
		<script>
			$(function(){
				$("input[value='${p.product_status}']").prop('checked', true);
			});
		</script>
		<link href="css/product/productDetailView.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<c:if test="${id == 'admin' }">
			<div id="showImage"><img src="${'LaptopImgUpload/'}${p.product_image}" width="100%" height="100%"></div>
			<div id="DetailDiv" class="mt-2">
				<h1>상품 상세 페이지</h1>
				<!-- 상품코드 -->
				<div class="form-group text-left">
					<label for="product_code">상품코드</label>
					<input type="text" class="form-control"
						   id="product_code" name="product_code" value="${p.product_code}" readOnly>
				</div>
				
				<!-- 상품코드 -->
				<div class="form-group text-left">
					<label for="category_name">카테고리</label>
					<input type="text" class="form-control"
						   id="category_name" name="category_name" value="${p.category_name}" readOnly>
				</div>
				
				<!-- 상품명 -->
				<div class="form-group text-left">
					<label for="product_name">상품명</label>
					<input type="text" class="form-control"
					       id="product_name" name="product_name" value="${p.product_name}" readOnly>
				</div>
				
				<!-- 상품 가격 -->
				<div class="form-group text-left">
					<label for="product_price">가격</label>
					<input type="text" class="form-control"
					       id="product_price" name="product_price" value="${p.product_price }" readOnly>
				</div>
		    
				<!-- 상품 상세정보 -->
				<div class="form-group text-left">
			  		<label for="product_details">상세정보</label>
			  		<textarea class="form-control" rows="3"
			  				  id="product_details" name="product_details" readOnly>${p.product_details}</textarea>
				</div>
			    
				<!-- 상품 재고 수 -->
				<div class="form-group text-left">
					<label for="product_stock">재고 수</label>
					<input type="text" class="form-control"
					       id="product_stock" name="product_stock" value="${p.product_stock}" readOnly>
				</div>
			    
				<!-- 상품 상태 -->
				<div class="form-group text-left" style="font-size : 25px">
					<label for="product_status">상태 </label>
					<div class="form-check-inline">
						<label class="form-check-label" for="newProduct">
							<input type="radio" class="form-check-input"
							       id="newProduct" name="optradio" value="신규" onClick="return(false);">신규상품
						</label>
					</div>
					<div class="form-check-inline">
						<label class="form-check-label" for="usedProduct">
							<input type="radio" class="form-check-input"
							 	   id="usedProduct" name="optradio" value="중고" onClick="return(false);">중고상품
						</label>
					</div>
				</div>
			    
				<!-- 이미지 -->
				<div class="form-group text-left">
			 		<button class="btn btn-primary" id="imgUploadbtn" onClick="return(false);">이미지 이름</button>
					<input class="form-control" type="file" id="imgUpload" name="imgUpload" accept="image/*">
					<span id="imgvalue">${p.product_image }</span>
				</div>
					
				<!-- 버튼 -->
				<div class="text-right mb-4">
					<a type="submit" class="btn btn-primary" href="ProductModifyView.ad?product_code=${p.product_code}">수정</a>
					<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#ProductDeleteModal">삭제</button>
					<a type="button" class="btn btn-info" href="ProductList.ad">목록</a>
				</div>
				
				<!-- 삭제 모달창 -->
				<div class="modal hide fade" id="ProductDeleteModal">
					<div class="modal-dialog modal-sm modal-dialog-centered">
						<div class="modal-content">
				      
							<!-- Modal Header -->
							<div class="modal-header">
								<h4 class="modal-title">상품 삭제</h4>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>
				        
							<!-- Modal body -->
							<div class="modal-body">
								<h4>상품을 삭제하시겠습니까??</h4>
							</div>
				        
							<!-- Modal footer -->
							<div class="modal-footer">
								<a type="button" class="btn btn-danger" href="ProductDeleteAction.ad?product_code=${param.product_code}">삭제</a>
								<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							</div>
				        
						</div>
					</div>
				</div>
			</div>
		</c:if>
	</body>
</html>