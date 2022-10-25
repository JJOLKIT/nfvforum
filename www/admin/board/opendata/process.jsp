<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="board.opendata.*" %>
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
%>
<%
	HashMap<String, Object> vo = new HashMap();
	vo = BeanUtils.bindHashMap(request, vo, pageRows);
	if (Function.getContentType(request.getContentType())) {
		vo = BeanUtils.bindHashMap(request, vo, pageRows, uploadPath, maxSaveSize);
	}
	OpenDataDAO dao = OpenDataDAO.getInstance();
	String cmd = Function.parseStr(vo.get("cmd"));
	
	if ("write".equals(cmd)) {	// 저장시
		int r = dao.insert(vo); 
		if (r > 0) {
			out.print(Function.returnURL(dao.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", vo, ""), "정상적으로 등록되었습니다."));
		} else {
			out.print(Function.returnURL(dao.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", vo, ""), "요청처리중 장애가 발생하였습니다."));
		}
	} else if ("edit".equals(cmd)) {
		int r = dao.update(vo);
		if (r > 0) {
			out.print(Function.returnURL(dao.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", vo, ""), "정상적으로 수정되었습니다."));
		} else {
			out.print(Function.returnURL(dao.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", vo, ""), "요청처리중 장애가 발생하였습니다."));
		}	
	} else if (("groupDelete").equals(cmd)) {
		String[] no = request.getParameterValues("no");
		int r = 0;
		for (int i=0; i<no.length; i++) {
			int nos = Integer.parseInt(no[i]);
			vo.put("no", nos);
			r += dao.delete(vo);
		}
		if (r == no.length) {
			out.print(Function.returnURL(dao.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", vo, ""), "총 "+r+"건이 삭제되었습니다."));
		} else {
			out.print(Function.returnURL(dao.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", vo, ""), "요청처리중 장애가 발생하였습니다."));
		}
	} else if ("delete".equals(cmd)) {
		int r = dao.delete(vo);
		if (r > 0) {
			out.print(Function.returnURL(dao.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", vo, ""), "정상적으로 삭제되었습니다."));
		} else {
			out.print(Function.returnURL(dao.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", vo, ""), "요청처리중 장애가 발생하였습니다."));
		}
	}
%>
<%
}else{
	out.print(Function.returnURL(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", "요청처리중 장애가 발생하였습니다."));
}
%>
</body>
</html>