<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="property.*" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="environment.admin.*" %>
<%
	boolean loginCheck = false;
	HashMap adminLoginSession = (HashMap)session.getAttribute("adminInfo");

	if (adminLoginSession != null) {
		loginCheck = true;
	}
	if (!loginCheck) {
		//adminLoginSession = new AdminVO();
		String referurl = request.getRequestURI();
		String referparam = request.getQueryString();
		out.print("<script>");
		out.print("function setMenuCookie( name, value ) { ");
		out.print("	var expiredays = 1;");			// 1은 하루임
		out.print("	var todayDate = new Date();");
		out.print("	todayDate.setDate(todayDate.getDate() + expiredays);");
		out.print("	document.cookie = name + '=' + escape(value) + '; path=/; expires=' + todayDate.toGMTString() + ';'");
		out.print("}");

		out.print("setMenuCookie('depth1', '');");
		out.print("setMenuCookie('depth2', '');");
		out.print("setMenuCookie('depth3', '');");
		out.print("</script>");

		// 브라우저가 실행 안된 상태로 링크가 열릴 시 취소하면 문제 발생.
		if(!Function.checkNull(request.getHeader("referer")).equals("")){
			if ("GET".equals(request.getMethod())) {
				session.setAttribute("url", referurl);
				session.setAttribute("param", referparam);
				out.print(Function.returnURL("/admin/index.jsp", "로그인 후 이용해주세요"));
			} else {
				request.setAttribute("url", referurl.substring(0, referurl.lastIndexOf("/")));
				out.print(Function.returnURL("/admin/index.jsp", "로그인 후 이용해주세요"));
			}
		} else {
			if ("GET".equals(request.getMethod())) {
				session.setAttribute("url", referurl);
				session.setAttribute("param", referparam);
				out.print(Function.returnURL("/admin/index.jsp", "로그인 후 이용해주세요"));
			} else {
				request.setAttribute("url", referurl.substring(0, referurl.lastIndexOf("/")));
				out.print(Function.returnURL("/admin/index.jsp", "로그인 후 이용해주세요"));
			}
		}
	}
%>