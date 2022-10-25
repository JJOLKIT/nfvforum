<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="util.*" %>
<%@ page import="property.*" %>
<%@ page import="pagelog.*" %>
<%@ page import ="java.net.*" %>
<%
HashMap<String, Object> page_param = new HashMap();
page_param = BeanUtils.bindHashMap(request, page_param, 9999);
PagelogDAO pagedao = PagelogDAO.getInstance();

String browser = Function.getBrowserInfo(request);
String os = Function.getClientOS(request);
int isMobile = Function.getMobileCheck(request);

String user_agent = "";
if(isMobile > 0){
	user_agent = "M";
}else{
	user_agent = "PC";
}

String advertise = "";
if(request.getRequestURL().indexOf("?n_media=") > 0){
	advertise = "1";
}

String ip = Function.getClientIP(request);
page_param.put("os", os);
page_param.put("browser", browser);
page_param.put("ip", ip);
page_param.put("page", Function.parseStr(request.getRequestURL()));
page_param.put("advertise", advertise);
page_param.put("user_agent", user_agent);


pagedao.insert(page_param);

%>