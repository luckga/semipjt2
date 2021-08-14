$(function(){
	var selectedValue=$(".search_field").val();
	
	if(selectedValue!='-1'){
		$("#viewcount").val(selectedValue);
	}
	
	// 검색 버튼 클릭한 경우
	$('#search').click(function(){
		// 검색어 유효성 검사를 한다.
		if($("input").val()==''){
			$("#ErrorModal").modal('show');
			$('#ErrorModal-Title').text('검색');
			$("#ErrorModal-body").html("<h3>검색어를 입력해주세요.</h3>");
			return false;
		}
	});
	
	$('#viewcount').change(function(){
		selectedValue = $(this).val();
		$("input").val('');
		message = ["제목", "작성일"];
		$("input").attr("placeholder", message[selectedValue] + " 입력하세요");
	});
	
	var chkObj = $("input[name='RowCheck']");
	var rowCnt = chkObj.length;
	
	$('input[name="allCheck"]').click(function(){
		var chk_listArr = $('input[name="RowCheck"]');
		for(var i = 0; i < chk_listArr.length; i++){
			chk_listArr[i].checked = this.checked;
		}
	});
	
	$('input[name="RowCheck"]').click(function(){
		if($('input[name="RowCheck"]:checked').length == rowCnt){
			$("input[name='allCheck']")[0].checked = true;
		}else{
			$("input[name='allCheck']")[0].checked = false;
		}
	});
	
	function deleteValue(){
		 var valueArr = new Array();
		 var list = $("input[name='RowCheck']");
		 for(var i = 0; i < list.length; i++){
			 if(list[i].checked){
				 valueArr.push(list[i].value);
			 }
		 }
		 if(valueArr.length == 0){
			$("#ErrorModal").modal('show');
			$('#ErrorModal-Title').text('선택 삭제');
			$("#ErrorModal-body").html("<h3>선택한 글이 없습니다.</h3>");
		 }else{
			 $("#SelectionDeleteModal").modal('show');
			 $("#SelectionDeletebtn").click(function(){
				 $("#SelectionDeleteModal").modal('hide');
				 $.ajax({
					url : 'NoticeSelectionDelete.ad',
					type : 'post',
					traditional : true,
					data : {valueArr : valueArr},
					success : function(data){
						if(data == valueArr.length){
							$("#SelectionDeleteSuccessModal").modal('show');
						}else{
							$("#SelectionDeleteFailModal").modal('show');
						}
					}
				 });
			 });
		 }
	}
	
	$('#selectionDelete').click(function(){
		deleteValue();
	});
	
	$("#noticeAddFrom").submit(function(){
		if($.trim($("#notice_title").val()) == ""){
			$("#ErrorModal").modal('show');
			$('#ErrorModal-Title').text('공지사항 등록');
			$("#ErrorModal-body").html("<h3>제목을 입력해주세요.</h3>");
			return false;
		}
		
		if($.trim($("#notice_content").val()) == ""){
			$("#ErrorModal").modal('show');
			$('#ErrorModal-Title').text('공지사항 등록');
			$("#ErrorModal-body").html("<h3>내용을 입력해주세요.</h3>");
			return false;
		}
	});
});