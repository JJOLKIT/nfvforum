<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*" %>
<%@ page import="board.foreigndata.*" %>
<%@ page import="util.*" %>
<%@ include file="config.jsp" %>
<%@ include file="/admin/include/logingCheck.jsp" %>
<%
	HashMap<String, Object> param = new HashMap();
	param = BeanUtils.bindHashMap(request, param, pageRows);
	
	ForeignDataDAO dao = ForeignDataDAO.getInstance();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/admin/include/headHtml.jsp" %>
<script>
	var oEditors; // 에디터 객체 담을 곳
	jQuery(window).load(function(){
		oEditors = setEditor("contents"); // 에디터 셋팅
		initCal({id:"registdate",type:"day",today:"y",timeYN:"y"});
	});
	
	function goSave() {
		if ($("#registdate").val() != "") {
			var regex2=/[0-9]{4}[\-][0-1][0-9][\-][0-3][0-9]\s[0-2][0-9]:[0-6][0-9]:[0-6][0-9]$/i; 
			if(!regex2.test($("#registdate").val())){
				alert('잘못된 날짜 형식입니다.\\n올바로 입력해 주세요.\\n ex)2013-02-14 03:28:85');
				$("#registdate").focus();
				return false;
			} 
		}
		if ($("#title").val() == "") {
			alert('제목을 입력해 주세요');
			$("#title").focus();
			return false;
		}
		var sHTML = oEditors.getById["contents"].getIR();
		if (sHTML == "") {
			alert('내용을 입력해 주세요');
			$("#contents").focus();
			return false;
		} else {
			oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
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
		<div class="information">
			<ul>
				<li>※ 첨부파일 및 이미지 파일은 10mb 이하로 업로드 가능합니다.</li>
				<li>※ 이미지 파일은 장당 10mb 이하로 업로드 가능하며, <b>가로사이즈 1200px 이하, 1mb 이하</b>를 권장합니다.</li>
				<li>※ 이미지 사이즈 수정은 그림판, 포토샵 등 여러 그래픽 프로그램을 통해 수정 가능합니다.</li>
				<li>※ 이미지 용량이 너무 클 경우, <em>사이트 느려짐 현상과 트래픽 초과, 하드 용량 초과</em>의 주 원인이 될 수 있습니다.</li>
				<li>※ 잘못 업로드 하신 파일로 인해 발생한 홈페이지 문제에 대해서는 유지보수 비용이 청구될 수 있습니다.</li>
			</ul>
		</div>
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
						<th>
							작성일
						</th>
						<td>
							<input type="text" name="registdate" id="registdate"  value="" class="dateTime" />
							<span id="CalregistdateIcon" style="height:22px; line-height:22px;vertical-align:middle;">
							<img src="/admin/img/ico_calendar.gif" id="CalregistdateIconImg" style="cursor:pointer;"/>
							</span>
						</td>
						<th>
							노출설정
						</th>
						<td>
							<input type="checkbox" name="top" id="top" value="1" /> <label for="top">탑공지 (상단노출)</label> <!-- <span class="h_line"></span>
							<input type="checkbox" name="newicon" id="newicon" value="1" /> <label for="newicon">새글 (New 아이콘 노출)</label> -->
						</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td colspan="3"><input type="text" name="name" id="name" value="<%=adminLoginSession.get("name")%>"/></td>
					</tr>
					<tr>
						<th scope="row"><label for="">*제목</label></th>
						<td colspan="3">
							<input type="text" id="title" name="title" class="w50" title="제목을 입력해주세요" />	
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td colspan="3">
							<textarea id="contents" name="contents" title="내용을 입력해주세요" style="width:100%;height:500px;"></textarea>	
						</td>
					</tr>
					
					<tr>
						<th scope="row">첨부파일</th>
						<td colspan="3">
							<input type="file" id="filename" name="filename" class="w50" title="첨부파일을 업로드 해주세요." />	
						</td>
					</tr>
					<tr>
						<th scope="row">첨부파일2</th>
						<td colspan="3">
							<input type="file" id="filename2" name="filename2" class="w50" title="첨부파일을 업로드 해주세요." />	
						</td>
					</tr>
					<tr>
						<th scope="row">첨부파일3</th>
						<td colspan="3">
							<input type="file" id="filename3" name="filename3" class="w50" title="첨부파일을 업로드 해주세요." />	
						</td>
					</tr>
					<tr>
						<th scope="row">첨부파일4</th>
						<td colspan="3">
							<input type="file" id="filename4" name="filename4" class="w50" title="첨부파일을 업로드 해주세요." />	
						</td>
					</tr>
					<tr>
						<th scope="row">첨부파일5</th>
						<td colspan="3">
							<input type="file" id="filename5" name="filename5" class="w50" title="첨부파일을 업로드 해주세요." />	
						</td>
					</tr>
					<tr>
						<th scope="row">첨부파일6</th>
						<td colspan="3">
							<input type="file" id="filename6" name="filename6" class="w50" title="첨부파일을 업로드 해주세요." />	
						</td>
					</tr>
					<tr>
						<th scope="row">첨부파일7</th>
						<td colspan="3">
							<input type="file" id="filename7" name="filename7" class="w50" title="첨부파일을 업로드 해주세요." />	
						</td>
					</tr>
					 
					
				</tbody>
			</table>
			<input type="hidden" name="cmd" value="write" />
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