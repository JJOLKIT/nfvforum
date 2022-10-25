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
%>
<section id="sub">

	<%@ include file = "/include/sub_top.jsp"%>

	<!-- sub_contents -->
	<section class="sub_contents">
		<div class="container_wrap">
			<div class="container">
				<h3 class="sub_title"><span>공지사항</span></h3>

		</div>
	</section>
</section>

<%@ include file = "/footer.jsp"%>

