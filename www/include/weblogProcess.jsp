<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="util.*" %>
<%@ page import="property.*" %>
<%@ page import="weblog.*" %>
<%@ page import ="java.net.*" %>
<%

HashMap<String, Object> webparam = new HashMap();
webparam = BeanUtils.bindHashMap(request, webparam, 9999);
WeblogDAO webdao = WeblogDAO.getInstance();


int idx = 0;
String ref = Function.parseStr(webparam.get("ref"));


idx = ref.indexOf("//");
String tmp="";

if (idx > -1) {
	tmp = ref.substring(idx+2);
} else {
	tmp = ref;
}

idx = tmp.indexOf("/");

String refhost = "";
String refpage = "";


if (idx > -1) {
	refhost = tmp.substring(0, idx);
	refpage = tmp.substring(idx);
} else {
	refhost = tmp;
	refpage = "/";
}

idx = refpage.indexOf("?");
String refparam = "";


if (idx > -1) {
	refparam = refpage.substring(idx+1);
	refpage = ref.substring(0, idx);
} else {
	refparam = "";
}

String refsearch = "";
int offset = 0;

if (!"".equals(refparam)) {
	idx = refparam.indexOf("&query=");
	if (idx >= 0) offset = 7;
	
	if (idx == -1) {
		idx = refparam.indexOf("&Query=");
		offset = 7;
		if (idx== -1) {
			idx = refparam.indexOf("&q=");
			offset = 3;
			if (idx == -1) {
				idx = refparam.indexOf("&p=");
				offset = 3;
				if (idx == -1) {
					idx = refparam.indexOf("&keyword=");
					offset = 9;
					if (idx == -1) {
						idx = refparam.indexOf("&DMSKW=");
						offset = 7;
					}
				}
			}
		}
	}
	if (idx > -1) {
		tmp = refparam.substring(Function.parseInt(idx)+offset);
		idx = tmp.indexOf("&");
		if (idx > -1) {
			refsearch = tmp.substring(0, idx);
		} else {
			refsearch = tmp;
		}
	}
}



if (refhost != "" && refhost != SiteProperty.COMPANY_URL.replace("http://", "") && refhost != SiteProperty.COMPANY_URL.replace("http://www", ""))  {
	
	webparam.put("con_search", URLEncoder.encode(refsearch));
	webparam.put("con_ip", Function.getClientIP(request));
	webparam.put("con_host", ref);
	
	
	int r = webdao.insert(webparam);
	
	
	
	
}

%>