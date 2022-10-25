<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "/header.jsp"%>
<%@ page import="board.notice.*" %>
<%@ page import="property.SiteProperty" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%@ include file = "config.jsp" %>
<%
		HashMap<String, Object> param = new HashMap();
		param = BeanUtils.bindHashMap(request, param, pageRows);
		NoticeDAO dao = NoticeDAO.getInstance();
		HashMap<String, Object> data = dao.read(param, userCon);
		HashMap<String, Object> prev = dao.prev(param);
		HashMap<String, Object> next = dao.next(param);
		
		/*newicon*/
		java.text.SimpleDateFormat sf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		String now = sf.format(new java.util.Date());
%>

<section id="sub" class="notice">

	<%@ include file = "/include/sub_top.jsp"%>

	<!-- sub_contents -->
	<section class="sub_contents">
		<div class="container_wrap">
			<div class="container">
				<div class="size">
				<h3 class="sub_title"><span>공지사항</span></h3>
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
							if(!"".equals(Function.parseStr(data.get("relation_url")))){
						%>
						<dl class="link">
		                    <dd>
		                    	 <a href="<%=Function.parseStr(data.get("relation_url"))%>" target="_blank"><img src="/img/img/link_ico.png"><%=Function.parseStr(data.get("relation_url"))%></a>
		                    </dd>
		                </dl>
						<%}%>
						<!-- //link--->

		                <%
		                	if(data.get("filename_org") != null && !"".equals(data.get("filename_org"))){
		                %>
		                <dl class="file">
		                    <!-- <dt>첨부파일</dt> -->
		                    <dd>
		                    	 <a href="/include/download.jsp?path=<%=Function.encodeUTF8(uploadPath)%>&vf=<%=Function.parseStr(data.get("filename"))%>&af=<%=Function.parseStr(data.get("filename_org"))%>" target="_blank"><img src="/img/img/file_ico.png"><%=Function.parseStr(data.get("filename_org"))%></a>
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
		</div>
	</section>
</section>

<%@ include file = "/footer.jsp"%>