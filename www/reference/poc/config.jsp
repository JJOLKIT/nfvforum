<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String pageTitle = "서비스PoC분과 자료실";
	String tablename = "poc";
	int pageRows	 = 10;
	String uploadPath	 = "/upload/poc/";					// 파일, 동영상 첨부 경로
	
	int	maxSaveSize	 = 50*1024*1024;							// 50Mb
	boolean userCon = true;
	boolean isComment = false;									// 댓글 사용여부
%>