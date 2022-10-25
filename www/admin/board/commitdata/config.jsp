<%@ page contentType="text/html; charset=utf-8" %>
<%
	String pageTitle = "운영위원회 자료실";
	String tablename = "commitdata";
	int pageRows	 = 20;
	String uploadPath	 = "/upload/commitdata/";					// 파일, 동영상 첨부 경로
	
	int	maxSaveSize	 = 50*1024*1024;							// 50Mb
	boolean userCon = false;
	boolean isComment = false;									// 댓글 사용여부
%>