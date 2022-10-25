<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="property.*" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="environment.admin.*" %>
<!doctype html>
<html lang="ko">
<%
boolean loginCheck = false;
HashMap<String, Object> adminLoginSession = (HashMap<String, Object>)session.getAttribute("adminInfo");

if (adminLoginSession != null) {
	loginCheck = true;
}

if (!loginCheck) {
	String url = (String)session.getAttribute("url");
	url = Function.getReqParameter(url, SiteProperty.START_PAGE);
	String param = Function.checkNull((String)session.getAttribute("param"));
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/admin/include/headHtml.jsp" %>
<script>
function loginCheck(){
	if ( getObject("id").value.length < 1 ) {
		alert("아이디를 입력해주세요.");
		getObject("id").focus();
		return false;
	}
	if ( getObject("password").value.length < 1 ) {
		alert("비밀번호를 입력해주세요.");
		getObject("password").focus();
		return false;
	}
	var f = document.board;
	if (f.reg.checked==true) {
	   document.cookie = "cookie_userid=" + f.USER_ID.value + ";path=/;expires=Sat, 31 Dec 2050 23:59:59 GMT;";
	} else {
	   var now = new Date();	
	   document.cookie = "cookie_userid=" + f.USER_ID.value + ";path=/;expires="+now.getTime();
	}
	return true;
}

function userid_chk() {
	var f=document.board;
	var useridname = CookieVal("cookie_userid");
	
	if (useridname=="null"){	
		f.USER_ID.focus();
		f.USER_ID.value="";
	} else {
		f.USER_PWD.focus();
		f.USER_ID.value=useridname;
		f.reg.checked=true;
	}
}

function CookieVal(cookieName) {
	thisCookie = document.cookie.split("; ");
	for (var i = 0; i < thisCookie.length;i++) {
		if (cookieName == thisCookie[i].split("=")[0]) {
			return thisCookie[i].split("=")[1];
		}
	}
	return "null" ;
}
//-->

</script>
</head>
<body onload="$('#id').focus();">
<div id="warp">
	<h1><img src="/admin/img/logo_img.png" alt=""></h1>
	<div class="login">
		<form name="board" id="board" method="post" action="/admin/include/login.jsp" onsubmit="return loginCheck();">
		<fieldset class="login_form">
			<legend class="blind">로그인</legend>
				<dl>
					<dt><label for="id">아이디</label></dt>
					<dd><input type="text" id="id" name="id" value="" /></dd>
				</dl>
				<dl>
					<dt><label for="pw">비밀번호</label></dt>
					<dd><input type="password" id="password" name="password" value="" /></dd>
				</dl>
				<div class="id_save">
					<input type="checkbox" value="" name="reg"/> 아이디 저장
				</div>
				<div class="login_btn">
					<input type="submit" title="로그인" alt="로그인" value="로그인" class=""/>
				</div>
		</fieldset>
		<input type="hidden" name="url" id="url" value=""/>
		<input type="hidden" name="param" id="param" value=""/>
		</form>
	</div>
	<div class="footer">
		<p>Copyright <%=SiteProperty.CREATE_YEAR %> <a href="<%=SiteProperty.COMPANY_URL%>" target="_blank"><%=SiteProperty.COMPANY_URL%></a>. All Rights Reserved.</p>
	</div>
</div>
</body>
<%
} else {
out.print(Function.returnURL(SiteProperty.START_PAGE));
}
%>
</html>