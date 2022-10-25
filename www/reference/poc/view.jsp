<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="board.poc.*" %>
<%@ page import="util.*" %>
<%@ include file="config.jsp" %>


<%@ include file = "/header.jsp"%>

<%
	HashMap<String, Object> param = new HashMap();
	param = BeanUtils.bindHashMap(request, param, pageRows);
	PocDAO dao = PocDAO.getInstance();
	HashMap<String, Object> data = dao.read(param, userCon);
	HashMap<String, Object> prev = dao.prev(param);
	HashMap<String, Object> next = dao.next(param);
	
	/*newicon*/
	java.text.SimpleDateFormat sf = new java.text.SimpleDateFormat("yyyy-MM-dd");
	String now = sf.format(new java.util.Date());
	
	if(!loginCheck || "1".equals(Function.parseStr(memberInfo.get("grade"))) || "3".equals(Function.parseStr(memberInfo.get("grade")))) { //비로그인 이거나 회원사가 아니라면 
%>

<script>
	alert('회원사만 이용 가능합니다. 로그인 후 다시 접속하세요.');
	history.back();
</script>

<% } else { %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


</head>
<body> 
<section id="sub">
	<%@ include file = "/include/sub_top.jsp"%>
	<!-- sub_contents -->
	<section class="sub_contents">
		<div class="container_wrap">
			<div class="container">
				<h3 class="sub_title"><span>서비스POC분과 자료실</span></h3>
				<article class="sub_cont">
					<h4 class="sub_des_title"></h4>
					<div id="warp">
						<div class="contents">
							<!-- 여기서부터 삽입--->
		        <div class="bbs">
		            <div class="view">
		                <div class="title">
		                    <dl class="clear">
		                        <dt>
		                        	<%=data.get("title") %>
		                        	<% String inputDate = sf.format(data.get("registdate"));
								   	   if(inputDate.equals(now)){
									 %>
									    <img src="/img/ico_new.png" class="ico_new" alt="새글" />
									<%} %>
	                        	</dt>
		                        <dd class="date"><span>Date.</span><%=Function.parseDate(data.get("registdate")) %></dd>
		                        <dd class="hit"><span>Hit.</span><%=data.get("readno") %></dd>
		                    </dl>
		                </div>
		                <!-- //title--->
		                <%--
						<div class="cont"><%=Function.parseStr(data.get("contents")).replaceAll("\n", "<br/>") %></div>
						--%>
		                <div class="cont"><%=Function.parseStr(data.get("contents")) %></div>
		                <!-- //cont--->
		                <%
		                if(!"".equals(Function.parseStr(data.get("filename_org"))) || !"".equals(Function.parseStr(data.get("filename2_org"))) || !"".equals(Function.parseStr(data.get("filename3_org"))) || !"".equals(Function.parseStr(data.get("filename4_org"))) || !"".equals(Function.parseStr(data.get("filename5_org"))) || !"".equals(Function.parseStr(data.get("filename6_org"))) || !"".equals(Function.parseStr(data.get("filename7_org")))){
		                %>
		                <dl class="file">
		                    <!-- <dt>첨부파일</dt> -->
		                    <dd>
								<%if(!"".equals(Function.parseStr(data.get("filename_org")))){%>
		                    	 <a href="/include/download.jsp?path=<%=uploadPath%>&vf=<%=data.get("filename")%>&af=<%=data.get("filename_org")%>" target="_blank"><img src="/img/img/file_ico.png"><%=data.get("filename_org")%></a>
								 <%}%>
								 <%if(!"".equals(Function.parseStr(data.get("filename2_org")))){%>
		                    	 <a href="/include/download.jsp?path=<%=uploadPath%>&vf=<%=data.get("filename2")%>&af=<%=data.get("filename2_org")%>" target="_blank"><img src="/img/img/file_ico.png"><%=data.get("filename2_org")%></a>
								 <%}%>
								 <%if(!"".equals(Function.parseStr(data.get("filename3_org")))){%>
		                    	 <a href="/include/download.jsp?path=<%=uploadPath%>&vf=<%=data.get("filename3")%>&af=<%=data.get("filename3_org")%>" target="_blank"><img src="/img/img/file_ico.png"><%=data.get("filename3_org")%></a>
								 <%}%>
								 <%if(!"".equals(Function.parseStr(data.get("filename4_org")))){%>
		                    	 <a href="/include/download.jsp?path=<%=uploadPath%>&vf=<%=data.get("filename4")%>&af=<%=data.get("filename4_org")%>" target="_blank"><img src="/img/img/file_ico.png"><%=data.get("filename4_org")%></a>
								 <%}%>
								 <%if(!"".equals(Function.parseStr(data.get("filename5_org")))){%>
		                    	 <a href="/include/download.jsp?path=<%=uploadPath%>&vf=<%=data.get("filename5")%>&af=<%=data.get("filename5_org")%>" target="_blank"><img src="/img/img/file_ico.png"><%=data.get("filename5_org")%></a>
								 <%}%>
								 <%if(!"".equals(Function.parseStr(data.get("filename6_org")))){%>
		                    	 <a href="/include/download.jsp?path=<%=uploadPath%>&vf=<%=data.get("filename6")%>&af=<%=data.get("filename6_org")%>" target="_blank"><img src="/img/img/file_ico.png"><%=data.get("filename6_org")%></a>
								 <%}%>
								 <%if(!"".equals(Function.parseStr(data.get("filename7_org")))){%>
		                    	 <a href="/include/download.jsp?path=<%=uploadPath%>&vf=<%=data.get("filename7")%>&af=<%=data.get("filename7_org")%>" target="_blank"><img src="/img/img/file_ico.png"><%=data.get("filename7_org")%></a>
								 <%}%>
		                    </dd>
		                </dl>
		                <%} %>
		                <!-- //file--->
		                
		                <%
		                	if(prev != null && !"".equals(prev.get("title"))){
		                %>
					 	<dl class="prev">
		                    <dt>이전글</dt>
		                    <dd><a href="view.jsp?no=<%=prev.get("no")%>&stype=<%=Function.parseStr(param.get("stype"))%>&sval=<%=Function.parseStr(param.get("sval"))%>"><%=prev.get("title") %></a></dd>
		                </dl>
		                <%} %>
		                
		                <%
		                	if(next != null && !"".equals(next.get("title"))){
		                %>
		                <dl class="next">
		                    <dt>다음글</dt>
		                    <dd><a href="view.jsp?no=<%=next.get("no")%>&stype=<%=Function.parseStr(param.get("stype"))%>&sval=<%=Function.parseStr(param.get("sval"))%>"><%=next.get("title") %></a></dd>
		                </dl>
		                <%} %>
		                <!--<dl class="link">
		                    <dt>관련링크 </dt>
		                    <dd><a href="" target="_blank">www.antock.com</a></dd>
		                </dl>-->
		                <!-- //linke---> 
		            </div>
		            <div class="btnSet clear">
		                    <a href="<%=dao.getTargetURLParam("index.jsp", param, "")%>" class="btn">목록으로</a>
		                </div>
		        </div>
		        <!-- //view--->
		    </div>
		    <!-- //여기까지 삽입--->
					</div>
					<!-- e:warp -->
					</article>
				</div>
			</div>
		</section>

<% } %>
		
<%@ include file = "/footer.jsp"%>
		
</body>
</html>