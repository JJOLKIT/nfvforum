<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="board_nav">
	<ul class="pc_nav clear">
		<!--
		<li><a href="index.jsp" <%if(scategory == 0){ out.println("class='on'"); }%>>All</a></li>
		-->
		<%
		for(int i = 1; i <= 6; i ++){
		%>
		<li><a href="index.jsp?scategory=<%=i%>" <% if(scategory == i){ out.println("class='on'"); }%>><%=CodeUtil.getPocCategoryName(i)%></a></li>
		<%}%>
	</ul>
	<div class="m_nav">
		<a href="javascript:;">
			<%=CodeUtil.getPocCategoryName(scategory)%>
		</a>			
		<ul>
			<%
			for(int i = 1; i <= 6; i ++){
			%>
			<li><a href="index.jsp?scategory=<%=i%>"><%=CodeUtil.getPocCategoryName(i)%></a></li>
			<%}%>
		</ul>
	</div>
</div>