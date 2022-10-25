<%@ page contentType="text/html; charset=utf-8" %>
<%--
<style>
	#excel_reg { 
		display:inline-block; position:fixed; bottom:50px; right:50px; width:120px; height:40px; border-radius:10px; background-color:#037893; z-index:100; text-align:center;
		box-shadow: 3px 2px 10px #888888; transition:box-shadow 300ms ease-in-out;
	}
	#excel_reg:hover {
		box-shadow: 3px 5px 25px #aaa;
	}
	button { color:white; font-weight:bolder; font-size:15px;  }
	#excel_reg button { line-height:40px; vertical-align:middle; width:100%; height:100%; }
	
	#excel_upload_area { position:fixed; width: 100%; height: 100%; top:0; left:0; z-index:101; text-align:center; display:none; }
	#excel_upload_area .upload_bg { position: absolute; width:100%; height: 100%; top:0; left:0; z-index:110; background-color:gray; opacity:0.4; }
	#excel_upload_area .form_area_wrap { position: absolute; top:0; left:0; bottom:0; right:0; margin:auto; width: 400px; height:230px; z-index:120; background-color:white; border-radius:15px; box-shadow:0px 8px 25px 5px rgba(5, 5, 5, 0.4); padding:20px; }
	
	#excel_upload_area .form_area_wrap div { width:100%; display:block; overflow:hidden; }
	#excel_upload_area .form_area_wrap .text_area {
		line-height:1.2; margin:20px auto 10px auto; height:50px; font-size:20px; text-align:center; font-weight: bolder; word-wrap:break-word; word-break:keep-all;
	}
	#excel_upload_area .form_area_wrap .text_area.error {
		color:orangered;
	}
	#excel_upload_area .form_area_wrap .warning { margin-bottom: 10px; display: inline-block; color: orangered; font-weight: bold; }
	#excel_upload_area .form_area_wrap .input_area { width:100%; height:40px; }
	#excel_upload_area .form_area_wrap .input_area input[type=file] { width:90%; height:35px; font-size:15px; padding:3px; background-color:white; border:1px dotted darkgray; }
	
	#excel_upload_area .form_area_wrap .btn_area {
		text-align:right; padding:5px 0; width:100%; height:auto; overflow:visible;
	}
	#excel_upload_area .form_area_wrap .btn_area button {
		width: 70px; height: 40px; background-color:cornflowerblue; color:#f3f3f3; border-radius:5px;
	}
	
	#excel_upload_area .form_area_wrap .progress_bar_wrap { width:100%; border:1px solid #060648; height: 35px; background-color:#d6d6d6; display:none; }
	#excel_upload_area .form_area_wrap .progress_bar_wrap #bar { display:inline-block; height:100%; float:left; width:0px; background-color:#288c87;}
	
	#excel_upload_area .form_area_wrap .loader { display: none; width:100%; height:120px; }
	#excel_upload_area .form_area_wrap .loader img {/*  display:none;  */} 
</style>
<script>
	function viewForm(){
		$('#excel_upload_area').fadeIn(350);
	}
	
	function closeForm(){
		$("#excel").val('');
		$('#excel_upload_area').fadeOut(350);
	}
	
	function uploadExcel(){
		var nowWhere = '';
		$("#frm").ajaxForm({
			dataType : 'json',
			beforeSubmit : function(data, form, opt){
				nowWhere = 'beforeSubmit';
				
				if( $("#excel").val().trim() == '' ){
					alert('파일을 첨부하여 주세요.');
					$("#excel").focus();
					return false;
				}
				
				$("#excel_upload_area .before_upload").fadeOut(150);
				$("#excel_upload_area .progress_bar_wrap").fadeIn(200);
				$("#excel_upload_area .form_area_wrap").stop().animate({height:170}, 200);
				$("#excel_upload_area .text_area").text('파일 업로드 중입니다.');
			},
		   	uploadProgress: function(event, position, total, percentComplete) {
				nowWhere = 'uploadProgress';
				
		        var percentVal = percentComplete + '%';
		        $("#bar").stop().animate({width:percentVal}, 100);
		    },			
			success : function( res ){
				nowWhere = 'success';
				
				if(res.rst == 'success'){
					$.post("/admin/include/excelConvert.jsp", res, function( res2 ){
						if(res2.rst == 'success'){
							$("#excel_upload_area .text_area").css("width", "100%").text("처리가 완료 되었습니다.");
							$("#excel_upload_area .loader").fadeOut(200);
							$("#excel_upload_area .form_area_wrap").stop().animate({height:100}, 200);
							
							document.location.href = "/admin/company/";
							setTimeout(closeForm, 2000);
						} else {
							
						}
					}, 'json').error(function( e ){
						console.log('error');
					});
					
					$("#excel_upload_area .text_area").css("width", "70%").text("업로드된 기업 정보를 변환하고 있습니다.");
					$("#excel_upload_area .progress_bar_wrap").fadeOut(1);
					$("#excel_upload_area .loader").fadeIn(200);
					$("#excel_upload_area .form_area_wrap").stop().animate({height:250}, 200);
				} else if(res.rst == 'error'){
					
				}
			},
			error : function( e ){
				$(".text_area").addClass("error");
				
				if(nowWhere == 'beforeSubmit'){
					
				} else if(nowWhere == 'uploadProgress') {
					$("#excel_upload_area .text_area").text("데이터 변환작업 중 오류가 발생하였습니다.");
					
				}
				
				setTimeout(function(){
					$("#excel_upload_area .text_area").removeClass('error').text('기업 정보의 Excel 파일을 등록하시겠습니까?');
					$("#excel_upload_area .before_upload").fadeIn(200);
					$("#excel_upload_area .form_area_wrap").stop().animate({height:230}, 200);
					$("#excel_upload_area .progress_bar_wrap").fadeOut(150, function(){
						$("#bar").width(0);
					});
				}, 2000);
			}
		});
		
		$("#frm").submit();
	}
</script>

<div id="excel_reg"><button onclick="viewForm();">기업정보등록</button></div>

<div id="excel_upload_area">
	<div class="form_area_wrap">
		<div class="text_area">기업 정보의 Excel 파일을 등록하시겠습니까?</div>
		<span class="warning before_upload">※기존에 등록되었던 기업 정보는 초기화 됩니다.</span>
		<div class="input_area before_upload">
			<form action="/admin/include/uploadExcel.jsp" id="frm" method="post" enctype="multipart/form-data">
				<input type="file" name="excel" id="excel" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"/>
			</form>
		</div>
		<div class="btn_area before_upload">
			<button onclick="uploadExcel();">등록</button>
			<button onclick="closeForm();">취소</button>
		</div>
		<div class="progress_bar_wrap"><span id="bar"></span></div>
		<div class="loader"><img src="/img/default.gif" /></div>
	</div>
	
	<div class="upload_bg"></div>
</div>
--%>

<!-- s:footer -->
<div id="footer"> Copyright 2020 sanggong. All Rights Reserved. </div>
<!-- e:footer -->