<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="environment.admin.*" %>
<%@ page import="java.util.*" %>
<%@ include file="config.jsp" %>
<%
HashMap<String, Object> param = new HashMap();
param = BeanUtils.bindHashMap(request, param, pageRows);
%>
<%@ include file="/admin/include/logingCheck.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/admin/include/headHtml.jsp" %>
<script>
var oEditors; // 에디터 객체 담을 곳
$(window).load(function() {
});

function goSave() {
	if ($("#id").val() == "") {
		alert("아이디를 입력하세요");
		$("#id").focus();
		return false;
	}
	$.ajax ({
		type:'POST',
		url:"id_check.jsp",
		data:$("[name=frm]").serialize(),
		async:false,
		success:function(data) {
			var val = data.trim();
			if (val == "0") {
				$("#idcheck").val("1");
			} else {
				alert("존재하는 아이디입니다.");
				$("#idcheck").val("0");
			}
		}
	});
	if ($("#idcheck").val() == "0") {
		return false;
	}
	if ($("#name").val() == "") {
		alert("이름을 입력하세요");
		$("#name").focus();
		return false;
	}
	
	// 비밀번호 유효성체크
	if(!validPassword($("#password"))) return false;

	if ($("#password").val() != $("#password2").val()) {
		alert("비밀번호를 확인해주세요");
		$("#password2").val("");
		$("#password2").focus();
		return false;
	}
	
	$("#frm").submit();
}

function idCheck() {
	if ($("#id").val() == "") {
		alert("아이디를 입력하세요");
		$("#id").focus();
		return false;
	}
	$.ajax ({
		type:'POST',
		url:"id_check.jsp",
		data:$("[name=frm]").serialize(),
		async:false,
		success:function(data) {
			var val = data.trim();
			if (val == "0") {
				alert("사용 가능한 아이디입니다.");
			} else {
				alert("존재하는 아이디입니다.");
			}
		}
	});
}
</script>
</head>
<body> 
<%@ include file="/admin/include/common.jsp" %>
<%@ include file="/admin/include/header.jsp" %>
<!-- s:warp -->
<div id="warp">
	<div class="contents">
		<h2 class="fl_l"><%=pageTitle%></h2>
		<div class="write">
			<form name="frm" id="frm" action="<%=Function.getSslCheckUrl(request.getRequestURL())%>/process.jsp" method="post">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" summary="관리자 관리 기본내용입니다.">
				<colgroup>
					<col width="15%" />
					<col width="35%" />
					<col width="15%" />
					<col width="35%" />
				</colgroup>
				<tbody>
					<tr>
						<th>아이디</th>
						<td><input type="text" name="id" id="id" value="" class="wid200" /> <input type="button" value="중복확인"  name="" onclick="idCheck();"/></td>
						<th>이름</th>
						<td><input type="text" name="name" id="name" value="" class="wid200" /></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="password" id="password" value=""  class="wid200"/></td>
						<th>비밀번호 확인</th>
						<td><input type="password" name="password2" id="password2" value=""  class="wid200"/></td>
					</tr>
					<tr>
						<th>연락처</th>
						<td colspan="3"><input type="text" name="tel" id="tel" value="" class="wid200"/></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td colspan="3"><input type="text" name="email" id="email" value="" class="wid200"/></td>
					</tr>
				</tbody>
			</table>
				<input type="hidden" name="grade" value="1" />
				<input type="hidden" name="cmd" value="write"/>
				<input type="hidden" name="stype" id="stype" value="<%=Function.parseStr(param.get("stype"))%>"/>
				<input type="hidden" name="sval" id="sval" value="<%=Function.parseStr(param.get("sval"))%>"/>
			</form>
		</div>
		<!-- //write -->
		<div class="btnSet">
			<a href="index.jsp" class="btn">목록</a>
			<a href="javascript:;" class="btn" onclick="goSave();">저장</a>
		</div>
		<!-- //btnSet -->
	</div>
	<!-- //contents -->
</div>
<!-- e:warp --> 
</body>
</html>