<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*" %>
<%@ page import="forum.*" %>
<%@ page import="util.*" %>
<%@ include file="config.jsp" %>
<%@ include file="/admin/include/logingCheck.jsp" %>
<%
	HashMap<String, Object> param = new HashMap();
	param = BeanUtils.bindHashMap(request, param, pageRows);
	
	ForumDAO dao = ForumDAO.getInstance();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/admin/include/headHtml.jsp" %>
<script>
	//var oEditors; // 에디터 객체 담을 곳
	jQuery(window).load(function(){
		//oEditors = setEditor("contents"); // 에디터 셋팅
		//initCal({id:"registdate",type:"day",today:"y",timeYN:"y"});
		$( "#startdate" ).datepicker({
			dateFormat: 'yy-mm-dd',
			prevText: '이전 달',
			nextText: '다음 달',
			monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			dayNames: ['일','월','화','수','목','금','토'],
			dayNamesShort: ['일','월','화','수','목','금','토'],
			dayNamesMin: ['일','월','화','수','목','금','토'],
			showMonthAfterYear: true,
			changeMonth: true,
			changeYear: true,
			yearSuffix: '년',
			//minDate : '+0d',
			isRTL: false,
			
		});
		
		$( "#enddate" ).datepicker({
			dateFormat: 'yy-mm-dd',
			prevText: '이전 달',
			nextText: '다음 달',
			monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			dayNames: ['일','월','화','수','목','금','토'],
			dayNamesShort: ['일','월','화','수','목','금','토'],
			dayNamesMin: ['일','월','화','수','목','금','토'],
			showMonthAfterYear: true,
			changeMonth: true,
			changeYear: true,
			yearSuffix: '년',
			//minDate : '+0d',
			isRTL: false,
			
		});
	});
	
	function goSave() {
		/*
		if ($("#registdate").val() != "") {
			var regex2=/[0-9]{4}[\-][0-1][0-9][\-][0-3][0-9]\s[0-2][0-9]:[0-6][0-9]:[0-6][0-9]$/i; 
			if(!regex2.test($("#registdate").val())){
				alert('잘못된 날짜 형식입니다.\\n올바로 입력해 주세요.\\n ex)2013-02-14 03:28:85');
				$("#registdate").focus();
				return false;
			} 
		}
		
		var sHTML = oEditors.getById["contents"].getIR();
		if (sHTML == "") {
			alert('내용을 입력해 주세요');
			$("#contents").focus();
			return false;
		} else {
			oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		}
		*/
		if ($("#title").val() == "") {
			alert('제목을 입력해 주세요');
			$("#title").focus();
			return false;
		}
		
		if( $('#startdate').val().trim() == ""){
			alert('행사 일정을 입력해 주세요.');
			$('#startdate').focus();
			return false;
		}
		
		if($('#enddate').val().trim() == ""){
			alert('행사 일정을 입력해 주세요.');
			$('#enddate').focus();
			return false;
		}
		
		if($('#starttime').val() == ""){
			alert('행사 시간을 입력해 주세요.');
			$('#starttime').focus();
			return false;
		}
		
		if($('#endtime').val() == ""){
			alert('행사 시간을 입력해 주세요.');
			$('#endtime').focus();
			return false;
		}
		
		if($('#place').val().trim() == ""){
			alert('장소를 입력해 주세요.');
			$('#place').focus();
			return false;
		}
		
		
		return true;
	}
	
	
</script>
</head>
<body> 
<%@ include file="/admin/include/common.jsp" %>
<%@ include file="/admin/include/header.jsp" %>
<div id="warp">
	<div class="contents">
		<h2 class="fl_l"><%=pageTitle%> - [쓰기]</h2>
		<div class="write">
			<form method="post" name="frm" id="frm" action="<%=Function.getSslCheckUrl(request.getRequestURL())%>/process.jsp" enctype="multipart/form-data" onsubmit="return goSave();">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" summary="관리자 관리 기본내용입니다.">
				<colgroup>
					<col width="12%" />
					<col width="38%" />
					<col width="12%" />
					<col width="38%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="">*제목</label></th>
						<td colspan="3">
							<input type="text" id="title" name="title" class="w50" title="제목을 입력해주세요" />	
						</td>
					</tr>
					<tr>
						<th>날짜</th>
						<td>
							<input type="text" name="startdate" id="startdate" class="wid200" readonly autocomplete="off"/> ~ 
							<input type="text" name="enddate" id="enddate" class="wid200" readonly autocomplete="off"/>
						</td>
						<th>시간</th>
						<td>
							<select name="starttime" id="starttime" class="wid200">
								<%=CodeUtil.getTimeList2(null) %>
							</select>
							<select name="endtime" id="endtime" class="wid200">
								<%=CodeUtil.getTimeList2(null) %>
							</select>
						</td>
					</tr>
					<tr>
						<th>장소</th>
						<td colspan="3"><input type="text" name="place" id="place" value=""/></td>
					</tr>
					
					
				</tbody>
			</table>
			<input type="hidden" name="cmd" value="write" />
			<input type="hidden" name="name" value="<%=adminLoginSession.get("name")%>"/>
		</form>
		</div>
		<!-- //write -->
		<div class="btnSet">
			<a class="btn" href="<%=dao.getTargetURLParam("index.jsp", param, "")%>"><strong>목록</strong></a>
			<a class="btn" href="javascript:$('#frm').submit();"><strong>저장</strong></a>
		</div>
		<!-- //btnSet -->
	</div>
	<!-- //contents -->
</div>
<!-- e:warp -->
</body>
</html>