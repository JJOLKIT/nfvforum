<%@ page contentType="text/html; charset=utf-8" %>
<%
	String pageTitle = "회원관리";
	String tablename = "member";
	int pageRows	 = 10;
	String uploadPath	 = "/upload/member/";					// 파일, 동영상 첨부 경로
	
	int	maxSaveSize	 = 10*1024*1024;							// 10Mb
	boolean userCon = false;
	boolean isComment = false;									// 댓글 사용여부
%>