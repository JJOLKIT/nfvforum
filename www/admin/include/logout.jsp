<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="environment.admin.*" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<%@ include file="/admin/include/loginCheck.jsp" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<% String pageTitle = "로그아웃"; %>
<%@ include file="/admin/include/headHtml.jsp" %>
</head>
<body>
<%
	String url = Function.getReqParameter(request.getParameter("url"), "/admin/index.jsp");		// 전달 받은 파라메터
	
	session.invalidate();
	out.println(Function.returnURL(url, "로그아웃되었습니다."));
%>
</body>
</html>