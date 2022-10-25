<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String pageTitle = "포토갤러리";
	String tablename = "gallery";
	int pageRows	 = 12;
	String uploadPath	 = "/upload/gallery/";					// 파일, 동영상 첨부 경로
	
	int	maxSaveSize	 = 50*1024*1024;							// 50Mb
	boolean userCon = true;
	boolean isComment = false;									// 댓글 사용여부
%>