<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="environment.admin.*" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%@ include file="config.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<%@ include file="/admin/include/logingCheck.jsp" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/admin/include/headHtml.jsp" %>
</head>
<body>
<%
if(Function.checkReferer(request.getHeader("referer"))){
	HashMap<String, Object> param = new HashMap();
	param = BeanUtils.bindHashMap(request, param, 1);
	
	AdminDAO ad = AdminDAO.getInstance();
	String cmd = request.getParameter("cmd");
	
	if ("write".equals(cmd)) {	// 저장시
		int r = ad.insert(param); 
		if (r > 0) {
			out.print(
					Function.returnURL(ad.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", param, ""), "정상적으로 등록되었습니다."));
		} else {
			out.print(Function.returnURL(ad.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", param, ""), "요청처리중 장애가 발생하였습니다."));
		}
	} else if ("edit".equals(cmd)) {
		int r = ad.update(param);
		if (r > 0) {
			out.print(Function.returnURL(ad.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", param, ""), "정상적으로 수정되었습니다."));
		} else {
			out.print(Function.returnURL(ad.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", param, ""), "요청처리중 장애가 발생하였습니다."));
		}	
	} else if (("groupDelete").equals(cmd)) {
		String[] no = request.getParameterValues("no");
		int r = 0;
		for (int i=0; i<no.length; i++) {
			int nos = Integer.parseInt(no[i]);
			r += ad.delete(nos);
			
		}
		if (r == no.length) {
			out.print(Function.returnURL(ad.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", param, ""), "정상적으로 삭제되었습니다."));
		} else {
			out.print(Function.returnURL(ad.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", param, ""), "요청처리중 장애가 발생하였습니다."));
		}
	}
}else{
	out.print(Function.returnURL(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", "요청처리중 장애가 발생하였습니다."));
}
%>
</body>
</html>