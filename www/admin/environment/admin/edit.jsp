<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="environment.admin.*" %>
<%@ page import="java.util.*" %>
<%@ page import="util.*" %>
<%@ include file="config.jsp" %>
<%
HashMap<String, Object> param = new HashMap();
param = BeanUtils.bindHashMap(request, param, pageRows);
AdminDAO ad = AdminDAO.getInstance();
HashMap<String, Object> data = ad.read(Function.getIntParameter(Function.parseStr(param.get("USER_KEY"))));
%>
<%@ include file="/admin/include/logingCheck.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/admin/include/headHtml.jsp" %>
<script type="text/javascript">
	var oEditors; // 에디터 객체 담을 곳
	$(window).load(function() {
	});

	function goSave() {
		if ($("#name").val() == "") {
			alert("이름을 입력하세요");
			$("#name").focus();
			return false;
		}
		
		if ($("#password").val() != "") {
			// 비밀번호 유효성체크
			if(!validPassword($("#password"))) return false;
			if ($("#password").val() != $("#password2").val()) {
				alert("비밀번호를 확인해주세요");
				$("#password2").val("");
				$("#password2").focus();
				return false;
			}
		}
		
		$("#frm").submit();
	}
</script>
</head>
<body> 
<%@ include file="/admin/include/common.jsp" %>
<%@ include file="/admin/include/header.jsp" %>
<!-- s:warp -->
<div id="warp">
	<div class="contents">
		<h2 class="fl_l"><%=pageTitle %></h2>
		<div class="write">
			<form name="frm" id="frm" action="<%=Function.getSslCheckUrl(request.getRequestURL())%>/process.jsp" method="post">
				<div class="wr_box">
					<h3>관리자 기본정보</h3>
					<table>
						<colgroup>
							<col width="8%">
							<col width="42%">
							<col width="8%">
							<col width="42%">
						</colgroup>
						<tbody>
						<tr>
							<th>아이디</th>
							<td><%=data.get("id")%></td>
							<th>이름</th>
							<td><input type="text" name="name" id="name" value="<%=data.get("name")%>" class="wid200" /></td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input type="password" name="password" id="password" value=""  class="wid200"/></td>
							<th>비밀번호 확인</th>
							<td><input type="password" name="password2" id="password2" value=""  class="wid200"/></td>
						</tr>
						<tr>
							<th>연락처</th>
							<td colspan="3"><input type="text" name="tel" id="tel" value="<%=data.get("tel") %>" class="wid200"/></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td colspan="3"><input type="text" name="email" id="email" value="<%=data.get("email")%>" class="wid200"/></td>
						</tr>
						</tbody>
					</table>
				</div>
				<input type="hidden" name="cmd" value="edit" />
				<input type="hidden" name="stype" id="stype" value="<%=Function.parseStr(param.get("stype"))%>"/>
				<input type="hidden" name="sval" id="sval" value="<%=Function.parseStr(param.get("sval"))%>"/>
				<input type="hidden" name="no" id="no" value="<%=data.get("no")%>"/>				
			</form>
		</div>
		<!-- //write -->
		<div class="btnSet">
			<a href="<%=ad.getTargetURLParam("index.jsp", param, "")%>" class="btn">목록</a>
			<a href="javascript:;" class="btn" onClick="goSave();">저장</a>
		</div>
		<!-- //btnSet -->
	</div>
	<!-- //contents -->
</div>
<!-- e:warp --> 

</body>
</html>