<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="member.*" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%@ include file="config.jsp" %>
<%@ include file="/admin/include/logingCheck.jsp" %>
<%
if(Function.checkReferer(request.getHeader("referer"))){
%>
<%
	HashMap<String, Object> vo = new HashMap();
	vo = BeanUtils.bindHashMap(request, vo, pageRows);
	if (Function.getContentType(request.getContentType())) {
		vo = BeanUtils.bindHashMap(request, vo, pageRows, uploadPath, maxSaveSize);
	}
	MemberDAO dao = MemberDAO.getInstance();
	String cmd = Function.parseStr(vo.get("cmd"));
	
	if ("excel".equals(cmd)) {
		String r = dao.excelDownload(vo);
		
		if(!"".equals(r)){
			//out.print("<script>location.href='/include/download.jsp?path="+uploadPath+"&af="+r+"&vf="+r+"'; </script>");
			out.print(r);
		}else{
			out.print("fail");
		}
	}else{
		out.print("error");
	}
%>
<%
}else{
	out.print("error");
}
%>