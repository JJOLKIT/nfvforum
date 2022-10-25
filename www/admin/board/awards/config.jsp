<%@ page contentType="text/html; charset=utf-8" %>
<%
	String pageTitle = "수상인증";
	String tablename = "awards";
	int pageRows	 = 10;
	String uploadPath	 = "/upload/awards/";					// 파일, 동영상 첨부 경로
	
	int	maxSaveSize	 = 50*1024*1024;							// 50Mb
	boolean userCon = false;
	boolean isComment = false;									// 댓글 사용여부
%>