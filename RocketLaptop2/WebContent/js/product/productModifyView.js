$(function(){
	$("input[value="+$(".product_status").val()+"]").prop('checked', true);
	
	// 수정 폼 submit할때 유효성 검사
	$('#productModifyFrom').submit(function(){
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
		
		if($.trim($('#imgUpload').val()) == ''){
			$('#ErrorModal').modal('show');
			$('#ErrorModal-Title').text("상품 등록");
			$('#ErrorModal-body').html("<h4>이미지를 첨부해주세요</h4>");
			return false;
		}
	});
	
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
			
			var reader = new FileReader();
			reader.readAsDataURL(event.target.files[0]);
			reader.onload = function(event){
				$("#showImage").html('<img width="100%" height="100%" src="' + event.target.result + '">');
			}
	
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
		$("#showImage > img").remove();
		show();
	});
});