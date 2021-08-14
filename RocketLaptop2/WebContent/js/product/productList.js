$(function(){
	var selectedValue=$('.search_field').val();
	
	if(selectedValue!='-1'){
		$("#viewcount").val(selectedValue);
	}
	
	// 검색 버튼 클릭한 경우
	$('#search').click(function(){
		// 검색어 유효성 검사를 한다.
		if($("input").val()==''){
			$('#ErrorModal').modal('show');
			$('#ErrorModal-Title'). text("검색어 입력");
			$('#ErrorModal-body').html("<h4>검색어를 입력해주세요</h4>");
			return false;
		}
	});
	
	// 검색창 select가 바뀌면 placholder 바뀐다
	$('#viewcount').change(function(){
		selectedValue = $(this).val();
		$("input").val('');
		message = ["상품코드", "상품명", "카테고리", "상품상태"];
		$("input").attr("placeholder", message[selectedValue] + " 입력하세요");
	});
	
	// 선택삭제 부분
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
			$("#ErrorModal-body").html("<h3>선택한 상품이 없습니다.</h3>");
		 }else{
			 $("#SelectionDeleteModal").modal('show');
			 $("#SelectionDeletebtn").click(function(){
				 $("#SelectionDeleteModal").modal('hide');
				 $.ajax({
					url : 'ProductSelectionDelete.ad',
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
	
	// 상품등록 버튼 클릭하면 모달창이 뜬다.
	$("#productAddbtn").click(function(){
		$.ajax({
			url : "CategoryList.ad",
			type : 'post',
			dataType : 'json',
			cache : false,
			success : function(data){
				$(".category > option").remove();
				$(data.categorylist).each(function(index, item){
					$(".category").append("<option value='" + this.category_code
							+ "'>" + this.category_name + "</option>");
				});
			}
		});
		
		$('#ProductAddModal').modal('show');
	});
	
	// Modal창 안에 상품등록 폼이 submit할때 유효성 검사
	$('#productAddFrom').submit(function(){
		if($.trim($('#product_code').val()) == ''){
			$('#ErrorModal').modal('show');
			$('#ErrorModal-Title').text("상품 등록");
			$('#ErrorModal-body').html("<h4>상품 코드를 입력해주세요</h4>");
			return false;
		}
		
		if($.trim($('.category').val()) == ''){
			$('#ErrorModal').modal('show');
			$('#ErrorModal-Title').text("상품 등록");
			$('#ErrorModal-body').html("<h4>카테고리를 선택해주세요</h4>");
			return false;
		}
		
		if($.trim($('#product_name').val()) == ''){
			$('#ErrorModal').modal('show');
			$('#ErrorModal-Title').text("상품 등록");
			$('#ErrorModal-body').html("<h4>상품명을 입력해주세요</h4>");
			return false;
		}
		
		if($.trim($('#product_price').val()) == ''){
			$('#ErrorModal').modal('show');
			$('#ErrorModal-Title').text("상품 등록");
			$('#ErrorModal-body').html("<h4>상품 가격을 입력해주세요</h4>");
			return false;
		}
		
		if($.trim($('#product_details').val()) == ""){
			$('#ErrorModal').modal('show');
			$('#ErrorModal-Title').text("상품 등록");
			$('#ErrorModal-body').html("<h4>상품 상세정보를 입력해주세요</h4>");
			return false;
		}
		
		if($.trim($('#product_stock').val()) == ''){
			$('#ErrorModal').modal('show');
			$('#ErrorModal-Title').text("상품 등록");
			$('#ErrorModal-body').html("<h4>상품 재고 수를 입력해주세요</h4>");
			return false;
		}
		
		if($.trim($('input[name="productStatus"]:checked').val()) == ''){
			$('#ErrorModal').modal('show');
			$('#ErrorModal-Title').text("상품 등록");
			$('#ErrorModal-body').html("<h4>상품 상태를 체크해주세요</h4>");
			return false;
		}
		
		if($.trim($('#imgUpload').val()) == ''){
			$('#ErrorModal').modal('show');
			$('#ErrorModal-Title').text("상품 등록");
			$('#ErrorModal-body').html("<h4>이미지를 첨부해주세요</h4>");
			return false;
		}
	});
	
	// 가격, 재고 수는 숫자만 입력 숫자 입력 안하면 value초기화
	$("#product_price").keyup(function(){
		if(!($.isNumeric($('#product_price').val()))){
			$("#product_price").val('');
		}
	});
	
	$("#product_stock").keyup(function(){
		if(!($.isNumeric($('#product_stock').val()))){
			$("#product_stock").val('');
		}
	});
	
	// 이미지 첨부 부분
	function show(){
		if($('#imgvalue').text() == ''){
			$(".remove").css('display', 'none');
		} else {
			$(".remove").css('display', 'inline-block');
		}
	}
	
	show();
	
	$('#imgUploadbtn').click(function(e){
		e.preventDefault();
		$('#imgUpload').click();
	});
	
	$('#imgUpload').change(function(){
		var inputimg = $(this).val().split("\\");
		var filename = inputimg[inputimg.length - 1];
		var pattern = /(gif|jpg|jpeg|png)$/i;
		if(pattern.test(filename)){
			$('#imgvalue').text(filename);
			show();
		}else{
			$('#ErrorModal').modal('show');
			$('#ErrorModal-Title').text("이미지 첨부");
			$('#ErrorModal-body').html("<h6>확장자는 gif, jpg, jpeg, png가 가능합니다.</h6>");
			return false;
		}
	});
	
	$('.remove').click(function(){
		$("#imgvalue").text('');
		show();
	});
});