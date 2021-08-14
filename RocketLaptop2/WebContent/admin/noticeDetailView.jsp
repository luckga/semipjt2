<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<jsp:include page="../main/header.jsp" />
		<title>관리자 페이지 - 공지사항 상세보기</title>
		<script src="js/notice/noticeModify.js"></script>
		<link href="css/notice/noticeDetailView.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<div class="container">
			<c:if test="${id == 'admin' }">
				<h2 id="DetailTitle">공지사항 글 상세보기</h2>
				<div style="width : 60%; margin : 0 auto;">
					<!-- 번호 -->
					<div class="form-group text-left">
			      		<label for="notice_num">번호</label>
			      		<input type="text" class="form-control" 
			      			   id="detailNotice_num" name="detailNotice_num" value="${param.num}" readOnly>
			    	</div>
					  	
					<!-- 제목 -->
					<div class="form-group text-left">
			      		<label for="notice_title">제목</label>
			      		<input type="text" class="form-control" 
			      			   id="detailNotice_title" name="detailNotice_title" value="${n.notice_title }" readOnly>
			    	</div>
			    		
			    	<!-- 내용 -->
			    	<div class="form-group text-left">
			      		<label for="notice_content">내용</label>
			      		<textarea class="form-control" rows=3 id="detailNotice_content"
			      			      name="detailNotice_content" readOnly>${n.notice_content }</textarea>
			    	</div>
			    		
			    	<!-- 작성일 -->
					<div class="form-group text-left">
			      		<label for="notice_date">작성일</label>
			      		<input type="text" class="form-control"
			      			   id="detailNotice_date" name="detailNotice_date" value="${n.notice_date }" readOnly>
			    	</div>
			    		
			    	<!-- 조회수 -->
					<div class="form-group text-left">
			      		<label for="notice_readcount">조회수</label>
			      		<input type="text" class="form-control"
			      			   id="detailNotice_readcount" name="detailNotice_readcount" value="${n.notice_readcount }" readOnly>
			    	</div>
					   
					<!-- 버튼 -->
					<div class="text-right">
						<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#NoticeModifyModal">수정</button>
						<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#NoticeDeleteModal">삭제</button>
						<a class="btn btn-info" href="NoticeList.ad">목록</a>
					</div>
				</div>
				
				<!-- 공지사항 수정 모달 -->
				<div class="modal fade" id="NoticeModifyModal">
					<div class="modal-dialog modal-lg modal-dialog-centered">
				    	<div class="modal-content">
					    	<div class="modal-header">
					        	<h4 class="modal-title">공지사항 수정</h4>
					        	<button type="button" class="close" data-dismiss="modal">&times;</button>
					     	</div>
					       
					       	<div class="modal-body">
					       		<form action="NoticeModifyAction.ad" method="post" name="modifyform" id="noticeModifyFrom">
					       			<!-- 번호 -->
									<div class="form-group text-left">
							      		<label for="notice_num">번호</label>
							      		<input type="text" class="form-control" 
							      			   id="modifyNotice_num" name="modifyNotice_num" value="${n.notice_num}" readOnly>
							    	</div>
					       			
					       			<!-- 제목 -->
									<div class="form-group text-left">
							      		<label for="notice_title">제목</label>
							      		<input type="text" class="form-control" 
							      			   id="modifyNotice_title" name="modifyNotice_title" value="${n.notice_title }">
							    	</div>
							    		
							    	<!-- 내용 -->
							    	<div class="form-group text-left">
							      		<label for="notice_content">내용</label>
							      		<textarea class="form-control" rows=3 id="modifyNotice_content"
							      			      name="modifyNotice_content">${n.notice_content }</textarea>
							    	</div>
							    		
							    	<!-- 작성일 -->
									<div class="form-group text-left">
							      		<label for="notice_date">작성일</label>
							      		<input type="text" class="form-control"
							      			   id="modifyNotice_date" name="modifyNotice_date" value="${n.notice_date }" readOnly>
							    	</div>
							    		
							    	<!-- 조회수 -->
									<div class="form-group text-left">
							      		<label for="notice_readcount">조회수</label>
							      		<input type="text" class="form-control"
							      			   id="modifyNotice_readcount" name="modifyNotice_readcount" value="${n.notice_readcount }" readOnly>
							    	</div>
							    	<div class="text-right mt-4 mb-4">
						       			<input type="hidden" name="notice_num" value="${param.num }" id="notice_num">
						         		<button type="submit" class="btn btn-info">수정</button>
						         		<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					         		</div>
					         	</form>
					       	</div>
						</div>
					</div>
				</div>
				
				<!-- 공지사항 글 삭제 모달 -->
				<div class="modal fade" id="NoticeDeleteModal">
					<div class="modal-dialog modal-sm modal-dialog-centered">
				    	<div class="modal-content">
					    	<div class="modal-header">
					        	<h4 class="modal-title">공지사항 글 삭제</h4>
					        	<button type="button" class="close" data-dismiss="modal">&times;</button>
					     	</div>
					       
					       	<div class="modal-body">
					        	<h3>정말 삭제하시겠습니까??</h3>
					       		<form action="NoticeDeleteAction.ad" method="post" name="delform">
					       			<input type="hidden" name="notice_num" value="${param.num }" id="notice_num">
					         		<button type="submit" class="btn btn-danger">삭제</button>
					         		<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					         	</form>
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
		</div> <!-- .container end -->
	</body>
</html>