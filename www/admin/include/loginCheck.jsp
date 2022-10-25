<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="property.*" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="environment.admin.*" %>
<%
	boolean loginCheck = false;
	HashMap<String, Object> adminLoginSession = (HashMap<String, Object>)session.getAttribute("adminInfo");

	if (adminLoginSession != null) {
		loginCheck = true;
	}
%>