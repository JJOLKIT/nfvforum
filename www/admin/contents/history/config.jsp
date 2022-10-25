<%@ page contentType="text/html; charset=utf-8" %>
<%
	String pageTitle = "연혁";
	String tablename = "history";
	int pageRows	 = 10;
	String uploadPath	 = "/upload/history/";					// 파일, 동영상 첨부 경로
	
	int	maxSaveSize	 = 50*1024*1024;							// 50Mb
	boolean userCon = false;
	boolean isComment = false;									// 댓글 사용여부
%>