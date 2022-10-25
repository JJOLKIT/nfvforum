<%@ page contentType="text/html; charset=utf-8" %>
<%
	String pageTitle = "QnA";
	String tablename = "qna";
	int pageRows	 = 10;
	String uploadPath	 = "/upload/qna/";					// 파일, 동영상 첨부 경로
	
	int	maxSaveSize	 = 10*1024*1024;							// 10Mb
	boolean userCon = false;
	boolean isComment = false;									// 댓글 사용여부
%>