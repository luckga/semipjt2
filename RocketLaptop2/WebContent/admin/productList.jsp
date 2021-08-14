<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<jsp:include page="../main/header.jsp" />
		<jsp:include page="AdminNav.jsp" />
		<title>관리자 페이지 - 상품 목록</title>
		<link href="css/admin/adminNav.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="js/product/productList.js"></script>
		<link href="css/product/productList.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<div class="container">
			<c:if test="${id == 'admin'}">
				<h1 class="ProductTitle"><a href="ProductList.ad">상품 목록</a></h1>
				<form action="ProductList.ad" method="post">
				    <div class="input-group">
				        <select id="viewcount" name="search_field">
				            <option value="0" selected>상품코드</option>
				            <option value="1">상품명</option>
				            <option value="2">카테고리</option>
				            <option value="3">상품상태</option>
				        </select>
				        <input name="search_word" type="text" class="form-control"
				               placeholder="상품코드 입력하세요" value="${search_word}">
				        <button id="search" class="btn btn-primary" type="submit">검색</button>
				    </div>
				</form>
				<input type="hidden" value="${search_field }" class="search_field">
				<h2>상품 개수 : ${listcount}</h2>
				<button type="button" class="btn btn-primary" id="productAddbtn">상품 등록</button>
				<c:if test="${listcount > 0 }">
					<table class="table table-striped table-bordered text-center">
						<thead>
							<tr>
								<th class="align-middle">전체선택<br><input name="allCheck" type="checkbox" name="allCheck"></th>
								<th class="align-middle">상품이미지</th>
								<th class="align-middle">상품코드</th>
								<th class="align-middle">카테고리</th>
								<th class="align-middle">상품명</th>
								<th class="align-middle">상품가격</th>
								<th class="align-middle">재고수</th>
								<th class="align-middle">상품 상태</th>
								<th class="align-middle">판매량</th>
								<th class="align-middle">상품등록일</th>
								<th class="align-middle">수정</th>	
							</tr>
						</thead>
						<tbody>
							<c:forEach var="p" items="${productlist }">
								<fmt:formatNumber type="number" maxFractionDigits="3" value="${p.product_price}" var="product_price" />
								<c:set var="src" value="${'LaptopImgUpload/'}${p.product_image }" />
								<tr>
									<td class="align-middle"><input name="RowCheck" type="checkbox" value="${p.product_code }"></td>
									<td class="align-middle"><img src="${src }" style="width : 130px;"></td>
									<td class="align-middle">${p.product_code }</td>
									<td class="align-middle">${p.category_name }</td>
									<td class="align-middle"><a href="ProductDetail.ad?product_code=${p.product_code}">${p.product_name }</a></td>
									<td class="align-middle">${product_price }</td>
									<td class="align-middle">${p.product_stock }</td>
									<td class="align-middle">${p.product_status }</td>
									<td class="align-middle">${p.product_sales }</td>
									<td class="align-middle">${p.product_date }</td>
									<td class="align-middle"><a class="btn btn-info" href="ProductModifyView.ad?product_code=${p.product_code}">수정</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<button type="button" class="btn btn-danger" id="selectionDelete">선택 삭제</button>
				 
				 	<ul class="pagination justify-content-center">
						<c:if test="${page <= 1 }">
							<li class="page-item">
								<a class="page-link gray">이전&nbsp;</a>
							</li>
						</c:if>
						<c:if test="${page > 1 }">
							<li class="page-item">
								<a href="ProductList.ad?page=${page-1}&search_field=${search_field}&search_word=${search_word}" class="page-link">이전&nbsp;</a>
							</li>
						</c:if>
						
						<c:forEach var="a" begin="${startpage}" end="${endpage}">
							<c:if test="${a == page }">
								<li class="page-item " >
						   			<a class="page-link gray">${a}</a>
								</li>
							</c:if>
							<c:if test="${a != page }">
					    		<li class="page-item">
						   			<a href="ProductList.ad?page=${a}&search_field=${search_field}&search_word=${search_word}" 
						      		class="page-link">${a}</a>
					    		</li>	
							</c:if>
						</c:forEach>
						
					    <c:if test="${page >= maxpage }">
							<li class="page-item">
					   			<a class="page-link gray">&nbsp;다음</a> 
							</li>
						</c:if>
						<c:if test="${page < maxpage }">
				  			<li class="page-item">
								<a href="ProductList.ad?page=${page+1}&search_field=${search_field}&search_word=${search_word}"
					   				class="page-link">&nbsp;다음</a>
				  			</li>	
						</c:if>
					</ul>
	  			</c:if>
	  			
	  			<c:if test="${listcount == 0 && empty search_word}">
					<h1 class="ProductBody">상품이 없습니다.</h1>
				</c:if>
				
				<c:if test="${listcount == 0 && !empty search_word}">
					<h1 class="ProductBody">검색결과가 없습니다.</h1>
				</c:if>
				
				<!-- 상품 등록 모달창 -->
				<div class="modal fade" id="ProductAddModal">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
				      
					        <!-- Modal Header -->
							<div class="modal-header text-center">
								<h1 class="modal-title">상품 등록</h1>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>
				        
					        <!-- Modal body -->
					        <div class="modal-body">
				          		<form action="ProductAddAction.ad" id="productAddFrom" method="post" name="productaddForm" enctype="multipart/form-data">
						          	<!-- 상품코드 -->
						          	<div class="form-group text-left">
				      					<label for="product_code">상품코드</label>
				      					<input type="text" class="form-control" id="product_code" name="product_code">
				    				</div>
				    				
				    				<!-- 카테고리 -->
				    				<div class="form-group text-left">
				      					<label for="category">카테고리</label>
				      					<select class="form-control category" name="category_code">
										</select>
				    				</div>
				    				
				    				<!-- 상품명 -->
				    				<div class="form-group text-left">
				      					<label for="product_name">상품명</label>
				      					<input type="text" class="form-control" id="product_name" name="product_name">
				    				</div>
				    				
				    				<!-- 상품 가격 -->
				    				<div class="form-group text-left">
				      					<label for="product_price">가격</label>
				      					<input type="text" class="form-control" id="product_price" name="product_price">
				    				</div>
		    				
				    				<!-- 상품 상세정보 -->
				    				<div class="form-group text-left">
					      				<label for="product_details">상세정보</label>
					      				<textarea class="form-control" rows="3"
					      				id="product_details" name="product_details"></textarea>
				    				</div>
		    				
									<!-- 상품 재고 수 -->
									<div class="form-group text-left">
										<label for="product_stock">재고 수</label>
										<input type="text" class="form-control" id="product_stock" name="product_stock">
									</div>
		    				
									<!-- 상품 상태 -->
									<div class="form-group text-left" style="font-size: 25px;">
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
										<span id="imgvalue"></span>
										<img src="image/remove.png" alt="이미지삭제" width="30px" class="remove">
									</div>
						    
									<!-- 버튼 -->
									<div class="text-right">
										<button type="submit" class="btn btn-primary">등록</button>
										<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 선택삭제 모달창 -->
				<div class="modal fade" id="SelectionDeleteModal">
					<div class="modal-dialog modal-sm modal-dialog-centered">
						<div class="modal-content">
				      
					        <!-- Modal Header -->
							<div class="modal-header text-center">
								<h1 class="modal-title">선택삭제</h1>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>
				        
					        <!-- Modal body -->
					        <div class="modal-body">
				          		<h3>정말 삭제하시겠습니까??</h3>
							</div>
							
							<div class="modal-footer">
								<button type="button" class="btn btn-danger" id="SelectionDeletebtn">삭제</button>
					         	<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 선택삭제 성공 모달창 -->
				<div class="modal fade" id="SelectionDeleteSuccessModal">
					<div class="modal-dialog modal-sm modal-dialog-centered">
						<div class="modal-content">
				      
					        <!-- Modal Header -->
							<div class="modal-header text-center">
								<h1 class="modal-title">선택삭제</h1>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>
				        
					        <!-- Modal body -->
					        <div class="modal-body">
				          		<h3>삭제 성공</h3>
							</div>
							
							<div class="modal-footer">
								<button type="button" class="btn btn-primary" onClick="javascript:location.replace('ProductList.ad');">확인</button>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 선택삭제 실패 모달창 -->
				<div class="modal fade" id="SelectionDeleteFailModal">
					<div class="modal-dialog modal-sm modal-dialog-centered">
						<div class="modal-content">
				      
					        <!-- Modal Header -->
							<div class="modal-header text-center">
								<h1 class="modal-title">선택삭제</h1>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>
				        
					        <!-- Modal body -->
					        <div class="modal-body">
				          		<h3>삭제 실패</h3>
							</div>
							
							<div class="modal-footer">
								<button type="button" class="btn btn-primary"  onClick="javascript:location.replace('ProductList.ad');">확인</button>
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