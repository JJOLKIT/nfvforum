<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*" %>
<%@ page import="contents.history.*" %>
<%@ page import="util.*" %>
<%@ include file="config.jsp" %>
<%@ include file="/admin/include/logingCheck.jsp" %>
<%
	HashMap<String, Object> param = new HashMap();
	param = BeanUtils.bindHashMap(request, param, pageRows);
	HistoryDAO dao = HistoryDAO.getInstance();
	HashMap<String, Object> data = dao.read(param, userCon);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/admin/include/headHtml.jsp" %>
<script>
	var oEditors; // 에디터 객체 담을 곳
	jQuery(window).load(function(){
		//oEditors = setEditor("contents"); // 에디터 셋팅
		//initCal({id:"registdate",type:"day",today:"y",timeYN:"y"});
		initCal({id:"historydate",type:"day",today:"y"});
		//initCal({id:"enddate",type:"day",today:"y"});
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
		
		return true;
	}
</script>
</head>
<body> 
<%@ include file="/admin/include/common.jsp" %>
<%@ include file="/admin/include/header.jsp" %>
<div id="warp">
	<div class="contents">
		<h2 class="fl_l"><%=pageTitle%> - [수정]</h2>
		<div class="write">
			<form method="post" name="frm" id="frm" action="<%=Function.getSslCheckUrl(request.getRequestURL())%>/process.jsp" enctype="multipart/form-data" onsubmit="return goSave();">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" summary="관리자 관리 기본내용입니다.">
				<colgroup>
					<col width="15%" />
					<col width="35%" />
					<col width="15%" />
					<col width="35%" />
				</colgroup>
				<tbody>
					<tr>
						<th>
							날짜
						</th>
						<td colspan="3">
							<input type="text" name="historydate" id="historydate"  value="<%=data.get("historydate")%>" class="dateTime" readonly/>
							<span id="CalhistorydateIcon" style="height:22px; line-height:22px;vertical-align:middle;">
							<img src="/admin/img/ico_calendar.gif" id="CalhistorydateIconImg" style="cursor:pointer;"/>
							</span> 
						</td>
                        <!--
						<th>
							노출설정
						</th>
						<td>
							<input type="checkbox" name="top" id="top" value="1" <%=Function.getChecked("1", Function.parseStr(data.get("top")))%>/> <label for="top">탑공지 (상단노출)</label> <span class="h_line"></span>
							<input type="checkbox" name="newicon" id="newicon" value="1" <%=Function.getChecked("1", Function.parseStr(data.get("newicon")))%>/> <label for="newicon">새글 (New 아이콘 노출)</label>
						</td>
                        -->
					</tr>
					<tr>
						<th scope="row"><label for="">*제목</label></th>
						<td colspan="3">
							<input type="text" id="title" name="title" class="w50" title="제목을 입력해주세요" value="<%=data.get("title")%>" />	
						</td>
					</tr>
				</tbody>
			</table>
				<input type="hidden" name="stype" id="stype" value="<%=param.get("stype")%>"/>
				<input type="hidden" name="sval" id="sval" value="<%=param.get("sval")%>"/>
				<input type="hidden" name="cmd" id="cmd" value="edit"/>
				<input type="hidden" name="no" id="no" value="<%=data.get("no")%>"/>
				<input type="hidden" name="registdate" id="registdate" value="<%=Function.parseDateTime(data.get("registdate"))%>" />
			</form>
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