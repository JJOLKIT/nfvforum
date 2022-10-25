<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="board.qna.*" %>
<%@ page import="property.SiteProperty" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%@ include file="config.jsp" %>
<%@ include file="/admin/include/logingCheck.jsp" %>
<%
	HashMap<String, Object> param = new HashMap();
	param = BeanUtils.bindHashMap(request, param, pageRows);
	QnaDAO dao = QnaDAO.getInstance();
	
	HashMap<String, Object> data = dao.read(param, userCon);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/admin/include/headHtml.jsp" %>
<script>
	/*var oEditors; // 에디터 객체 담을 곳
	jQuery(window).load(function(){
		oEditors = setEditor("contents"); // 에디터 셋팅
		initCal({id:"registdate",type:"day",today:"y",timeYN:"y"});
	});*/
	
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
		<h2 class="fl_l"><%=pageTitle%></h2>
		<div class="write">
			<!-- //wr_box -->
			<div class="wr_box">
				<h3>사용자 정보</h3>
				<table>
					<colgroup>
						<col width="8%">
						<col width="50%">
					</colgroup>
					<tbody>
					<tr>
						<th>이름</th>
						<td>
							<%=Function.parseStr(data.get("name"))%>
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>
							<%=Function.parseStr(data.get("email"))%>
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>
							<%=Function.parseStr(data.get("title"))%>
						</td>
					</tr>
					</tbody>
				</table>
			</div>
			<!-- //wr_box -->
			
			<!-- //wr_box -->
			<div class="wr_box">
				<h3>내용</h3>
				<table>
					<colgroup>
						<col width="100%">
					</colgroup>
					<tbody>
					<tr>
						<td>
							<%=Function.parseStr(data.get("contents"))%>
						</td>
					</tr>
					</tbody>
				</table>
			</div>
			<!-- //wr_box -->
		<div class="btnSet">
			<a class="btn" href="<%=dao.getTargetURLParam("index.jsp", param, "")%>"><strong>목록</strong></a>
		</div>
		<!-- //btnSet -->
	</div>
	<!-- //contents -->
</div>
<!-- e:warp -->

</body>
</html>