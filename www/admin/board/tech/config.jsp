<%@ page contentType="text/html; charset=utf-8" %>
<%
	String pageTitle = "기술표준분과 자료실";
	String tablename = "tech";
	int pageRows	 = 20;
	String uploadPath	 = "/upload/tech/";					// 파일, 동영상 첨부 경로
	
	int	maxSaveSize	 = 50*1024*1024;							// 50Mb
	boolean userCon = false;
	boolean isComment = false;									// 댓글 사용여부
%>