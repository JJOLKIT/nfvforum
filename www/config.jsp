<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String pageTitle = "공지사항";
	/* String tablename = "notice"; */
	String tablenameG = "gallery";
	String tablenameN = "notice";
	String tablenameS = "forum";
	
	int pageRows	 = 5;
	int pageRowsG	 = 10;
	int pageRowsS	 = 3;
	
	/* String uploadPath	 = "/upload/notice/";					// 파일, 동영상 첨부 경로 */
	String uploadPathG	 = "/upload/gallery/";					// 파일, 동영상 첨부 경로
	String uploadPathN	 = "/upload/notice/";					// 파일, 동영상 첨부 경로
	String uploadPathS	 = "/upload/forum/";					// 파일, 동영상 첨부 경로
	
	int	maxSaveSize	 = 50*1024*1024;							// 50Mb
	boolean userCon = true;
	boolean isComment = false;									// 댓글 사용여부
%>