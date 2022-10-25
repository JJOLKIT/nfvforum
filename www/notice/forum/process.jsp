<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="forum.*" %>
<%@ page import="util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>

<%@ include file="config.jsp" %>
<%
	if("read".equals(request.getParameter("cmd"))){

		HashMap<String, Object> param = new HashMap();
		param = BeanUtils.bindHashMap(request, param, pageRows);
		ForumDAO dao = ForumDAO.getInstance();
		ArrayList<HashMap<String, Object>> list = dao.list(param);
		int[] rowPageCount = dao.count(param);

		
		%>
		
		
		<%
			if(rowPageCount[0] == 0){
		
			out.println("fail");
		}else{
			HashMap<String,Object> data;
			
		%>
		<div class="scheduled_tooltip">

		<%
			for(int i = 0; i < list.size(); i ++){	
				data = list.get(i);
		%>
		

		
			

	    	<dl class="">
				 <dt><%=Function.parseStr(data.get("title")) %></dt>
				 <dd>
					 <span>날짜 : <%=Function.parseStr(data.get("startdate"))%> ~ <%=Function.parseStr(data.get("enddate"))%></span>
					 <span>시각 : <%=data.get("starttime")%> ~ <%= data.get("endtime")%></span>
					 <span>장소 : <%=Function.parseStr(data.get("place"))%></span>
				 </dd>
			 </dl>
			

		
		<%
			}
		%>
		 </div>

		<%
		}
	}else{
		out.println("fail");
	}
%>
