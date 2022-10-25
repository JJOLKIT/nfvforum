<%@ page contentType="text/html; charset=utf-8" %>
<%
	String pageTitle = "행사안내";
	String tablename = "event";
	int pageRows	 = 4;
	String uploadPath	 = "/upload/event/";					// 파일, 동영상 첨부 경로
	
	int	maxSaveSize	 = 50*1024*1024;							// 50Mb
	boolean userCon = false;
	boolean isComment = false;									// 댓글 사용여부
%>