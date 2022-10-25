<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="board_nav">
	<ul class="pc_nav clear">
		<%
		for(int i = 1; i <= 5; i++){
		%>
		<li><a href="/reference/tech/?scategory=<%=i%>" <% if(scategory == i){ out.println("class='on'"); }%>><%=CodeUtil.getTechCategoryName(i)%></a></li>
		<%}%>
	</ul>
	<div class="m_nav">
		<a href="javascript:;" class="top_view"><%=CodeUtil.getTechCategoryName(scategory)%></a>			
		<ul>
			<%
			for(int i = 1; i <= 5; i++){
			%>
			<li><a href="/reference/tech/?scategory=<%=i%>" <% if(scategory == i){ out.println("class='on'"); }%>><%=CodeUtil.getTechCategoryName(i)%></a></li>
			<%}%>
		</ul>
	</div>
</div>