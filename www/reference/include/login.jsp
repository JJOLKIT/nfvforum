<%@ page contentType="text/html; charset=utf-8" %>
<%-- <%@ page import="environment.admin.*" %> --%>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<%@ include file="/reference/include/loginCheck.jsp" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<%
String url = request.getParameter("url");									// 전달 받은 주소
String param = Function.getReqParameter(request.getParameter("param"));		// 전달 받은 파라메터

// 파라메터가 있을 경우에는 url 뒷에 결합한다.
if (!"".equals(param)) {
	url = url+"?"+param;
} else {
	url = SiteProperty.START_PAGE;
}
HashMap<String, Object> hm = new HashMap();
hm = BeanUtils.bindHashMap(request, hm, 0);
 
AdminDAO dao = AdminDAO.getInstance();

if (dao.loginCheck(hm)) {
	HashMap memberInfo = dao.getLoginSessionInfo(hm);
	session.setAttribute("memberInfo", memberInfo);
	memberInfo.put("ip", request.getRemoteAddr());
	dao.insertLoginHistory(memberInfo);
	out.print(Function.returnURL(url));
} else {
	out.print(Function.returnHistory("아이디 패스워드가 일치하지 않습니다."));
}
%>
</body>
</html>