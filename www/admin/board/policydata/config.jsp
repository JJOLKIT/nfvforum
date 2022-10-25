<%@ page contentType="text/html; charset=utf-8" %>
<%
	String pageTitle = "정책협력분과 자료실";
	String tablename = "policydata";
	int pageRows	 = 20;
	String uploadPath	 = "/upload/policydata/";					// 파일, 동영상 첨부 경로
	
	int	maxSaveSize	 = 50*1024*1024;							// 50Mb
	boolean userCon = false;
	boolean isComment = false;									// 댓글 사용여부
%>