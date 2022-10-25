<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "/header.jsp"%>

<%@ page import="property.SiteProperty" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="environment.member.*" %>

<SCRIPT type="text/javascript">
$(document).ready(function(e){

	$("#id").focus();
    
	$("#password").bind("keydown", function(e) {
		if (e.keyCode == 13) { // enter key
			$("#board").submit();
			return false
		}
	});
});

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
	   document.cookie = "cookie_userid=" + f.id.value + ";path=/;expires=Sat, 31 Dec 2050 23:59:59 GMT;";
	} else {
	   var now = new Date();	
	   document.cookie = "cookie_userid=null;path=/;expires="+now.getTime();
	}
	return true;
}

function userid_chk() {
	var f=document.board;
	var useridname = CookieVal("cookie_userid");
	console.log("useridname"+useridname);
	if (useridname=="null"){	
		f.id.focus();
		f.id.value="";
	} else {
		f.password.focus();
		f.id.value=useridname;
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

$(function(){
	userid_chk();
});
</SCRIPT>

<%
boolean memberLoginCheck = false;
HashMap<String, Object> memberLoginSession = (HashMap<String, Object>)session.getAttribute("memberInfo");

if (memberLoginSession != null) {
	memberLoginCheck = true;
}

if (!memberLoginCheck) {
	String url = (String)session.getAttribute("url");
	url = Function.getReqParameter(url, SiteProperty.START_PAGE);
	String param = Function.checkNull((String)session.getAttribute("param"));
%>


<section id="sub" class="login">
	<!-- sub_contents -->
	<section class="sub_contents">
		<div class="container">
			<h3 class="sub_title"><span>로그인</span></h3>
			<div class="cont1">
				<div class="inner">
					<div class="top">
						<h4 class="user_title">Members Login</h4>
						<span>로그인을 해주세요.</span>
					</div>
					<form name="board" id="board" method="post" action="/include/login.jsp" onsubmit="return loginCheck();" class="login_form">
						<div class="mid clear">
							<div class="left">
								<input type="text" class="u_id" name="id" id="id" placeholder="아이디"/>
								<input type="password" class="u_pw" name="password" id="password" placeholder="비밀번호"/>
							</div>
							<div class="right">
								<input type="submit" value="로그인" onclick="document.getElementById('board').submit();">
							</div>
						</div>
						<div class="btm">
							<p><input type="checkbox" id="reg" name="reg"><label for="reg">아이디 저장</label></p>
							<ul>
								<li><a href="/user/join.jsp">회원가입</a></li>
								<li><a href="/user/id_search.jsp">아이디 찾기</a></li>
								<li><a href="/user/pw_search.jsp">비밀번호 찾기</a></li>
							</ul>
						</div>
					</form>
				</div>
			</div>
	</section>
</section>

<%
} else {
out.print(Function.returnURL(SiteProperty.START_PAGE));
}
%>

<%@ include file = "/footer.jsp"%>

