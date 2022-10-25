<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="environment.admin.*" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%
HashMap<String, Object> param = new HashMap();
param = BeanUtils.bindHashMap(request, param, 1);
	AdminDAO md = AdminDAO.getInstance();									// 	AdminDAO 인스턴스 생성
	String use = "";
	int cnt = 0;
	if(!"".equals(request.getParameter("USER_ID"))){
		cnt = md.idcheck(param);									//	ID체크 [cnt 값이 0이어야 ID 사용가능]
	}	
%><%=cnt%>