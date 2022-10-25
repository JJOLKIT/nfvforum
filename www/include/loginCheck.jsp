<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="property.*" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="member.*" %>
<%
	boolean loginCheck = false;
	HashMap<String, Object> memberInfo = (HashMap<String, Object>)session.getAttribute("memberInfo");

	if (memberInfo != null) {
		loginCheck = true;
	}
%>