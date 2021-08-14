<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<jsp:include page="../main/header.jsp" />
		<jsp:include page="AdminNav.jsp" />
		<title>관리자 페이지 - 공지사항 목록</title>
		<link href="css/admin/adminNav.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="js/notice/noticeList.js"></script>
		<link href="css/notice/noticeList.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<div class="container">
			<c:if test="${id == 'admin' }">
				<h1 class="NoticeTitle"><a href="NoticeList.ad">공지사항 관리</a></h1>
				<form action="NoticeList.ad" method="post">
				    <div class="input-group">
				        <select id="viewcount" name="search_field">
				            <option value="0" selected>제목</option>
				            <option value="1">작성일</option>
				        </select>
				        <input name="search_word" type="text" class="form-control"
				               placeholder="제목 입력하세요" value="${search_word}">
				        <button id="search" class="btn btn-primary" type="submit">검색</button>
				    </div>
				</form>
				<input type="hidden" value="${search_field }" class="search_field">
				<h2>글 개수 : ${listcount }</h2>
				<button class="btn btn-primary" id="noticeAddbtn" data-toggle="modal" data-target="#ProductAddModal">공지사항 쓰기</button>
				<c:if test="${listcount > 0}">
					<table class="table table-hover table-striped table-bordered text-center">
					    <thead>
					        <tr>
					        	<th class="col-md-1">전체선택<br><input type="checkbox" id="allCheck" name="allCheck"></th>
					            <th class="align-middle">번호</th>
					            <th class="align-middle">제목</th>
					            <th class="align-middle">작성일</th>
					            <th class="align-middle">조회수</th>
					        </tr>
					    </thead>
					    <tbody>
					    	<c:set var="num" value="${listcount-(page-1)*limit }" />
					    	<c:forEach var="n" items="${noticelist }">
					    		<tr>
					    			<td><input name="RowCheck" type="checkbox" value="${n.notice_num }"></td>
					    			<td>
					    				<c:out value="${num }" />
					    				<c:set var="num" value="${num-1 }"/>
					    			</td>
					    			<td>
					    				<a href="NoticeDetail.ad?num=${n.notice_num}">
					 						<c:out value="${n.notice_title}" />  
										</a>
									</td>
					    			<td>${n.notice_date}</td>
					    			<td>${n.notice_readcount}</td>
					    		</tr>
					    	</c:forEach>
					    </tbody>
					</table>
					<input type="button" value="선택삭제" class="btn btn-danger" id="selectionDelete">
					
					<ul class="pagination justify-content-center">
						<c:if test="${page <= 1 }">
							<li class="page-item">
								<a class="page-link gray">이전&nbsp;</a>
							</li>
						</c:if>
						<c:if test="${page > 1 }">
							<li class="page-item">
								<a href="NoticeList.ad?page=${page-1}&search_field=${search_field}&search_word=${search_word}" class="page-link">이전&nbsp;</a>
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
						   			<a href="NoticeList.ad?page=${a}&search_field=${search_field}&search_word=${search_word}" 
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
								<a href="NoticeList.ad?page=${page+1}&search_field=${search_field}&search_word=${search_word}" 
					   				class="page-link">&nbsp;다음</a>
				  			</li>	
						</c:if>
					</ul>
				</c:if>
				
				<c:if test="${listcount == 0 && empty search_word}">
					<h1 class="NoticeBody">공지사항이 없습니다.</h1>
				</c:if>
				
				<c:if test="${listcount == 0 && !empty search_word}">
					<h1 class="NoticeBody">검색결과가 없습니다.</h1>
				</c:if>
				
				<!-- 공지사항 등록 모달창 -->
				<div class="modal fade" id="ProductAddModal">
					<div class="modal-dialog modal-lg modal-dialog-centered">
						<div class="modal-content">
				      
					        <!-- Modal Header -->
							<div class="modal-header text-center">
								<h1 class="modal-title">공지사항 등록</h1>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>
				        
					        <!-- Modal body -->
					        <div class="modal-body">
				          		<form action="NoticeAdd.ad" id="noticeAddFrom" method="post" name="noticeAddFrom">
						          	<!-- 제목 -->
						          	<div class="form-group text-left">
				      					<label for="notice_title">제목</label>
				      					<input type="text" class="form-control" id="notice_title" name="notice_title">
				    				</div>
				    				
				    				<!-- 내용 -->
				    				<div class="form-group text-left">
				      					<label for="notice_content">내용</label>
				      					<textarea class="form-control" rows=3 id="notice_content" name="notice_content"></textarea>
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
								<button type="button" class="btn btn-primary" onClick="javascript:location.replace('NoticeList.ad');">확인</button>
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
								<button type="button" class="btn btn-primary"  onClick="javascript:location.replace('NoticeList.ad');">확인</button>
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