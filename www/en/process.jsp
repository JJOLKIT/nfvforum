<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="qna.*" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="property.*" %>
<%@ page import="email.*" %>
<%@ include file="config.jsp" %>
<%
if(Function.checkReferer(request.getHeader("referer"))){
%>
<%
	HashMap<String, Object> vo = new HashMap();
	vo = BeanUtils.bindHashMap(request, vo, pageRows);
	if (Function.getContentType(request.getContentType())) {
		vo = BeanUtils.bindHashMap(request, vo, pageRows, uploadPath, maxSaveSize);
	}
	QNADAO dao = QNADAO.getInstance();
	String cmd = Function.parseStr(vo.get("cmd"));

	if ("write".equals(cmd)) {	// 저장시
		
		//out.println(vo);
		
		int result = dao.insert(vo);
		
		//out.println(result);
		
		 if(result> 0 ){
			 
			String title = "["+SiteProperty.COMPANY_NAME+"]"+Function.parseStr(vo.get("name"))+"님의 1:1문의입니다.";
			String contents = "";
			contents = "<table>";
			contents += "제목 : "+Function.parseStr(vo.get("title"))+"<br/>";
			contents += "이름 : "+Function.parseStr(vo.get("name"))+"<br/>";
			contents += "이메일 : "+Function.parseStr(vo.get("email"))+"<br/>";
			contents += "내용 : <br/>"+Function.parseStr(vo.get("contents"))+"<br/><br/>";
						
			String mailForm = MakeMailForm.getURLMakeMailForm(SiteProperty.COMPANY_URL, SiteProperty.EMAIL_FORM, "");	// 이메일폼을 읽어온다.
			mailForm = Function.replace(mailForm, ":SUBJECT", Function.parseStr(vo.get("title")));													// :SUBJECT을 title로 변경한다.
			//mailForm = Function.replace(mailForm, ":CONTENT", contents); 												// :CONTENT을 content로 변경한다.
			mailForm = Function.replace(mailForm, ":CONTENT", Function.nl2br(contents));
			
	
			out.println(mailForm);
			//out.println(""+SiteProperty.COMPANY_EMAIL+Function.parseStr(vo.get("email"))+title);
				
			try {
				//int r = SendMail.sendEmail(SiteProperty.COMPANY_EMAIL, Function.parseStr(vo.get("email")), title, mailForm);						// ID, PW 메일 발송
				int t = SendMail.sendEmail(SiteProperty.COMPANY_EMAIL, "nhkim@kani.or.kr", title, mailForm);						// ID, PW 메일 발송
				//out.println(r == 1 ? "발송 성공" : "발송 실패");
				
				out.print(Function.returnURL(Function.getRemoviSslUrl(request.getRequestURL())+"/qna.jsp", "입력하신 정보가 담당자 이메일로 발송되었습니다."));
				//out.print(Function.returnURL(param.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/idpwFind.jsp", null, 0), UsingProperties.getMsg("alert.email.success")));
			} catch (Exception e) {
				out.print(Function.returnURL(Function.getRemoviSslUrl(request.getRequestURL())+"/qna.jsp", "요청처리중 장애가 발생하였습니다. 메일 발송에 실패하였습니다."));
			}
		} 			
			
	} if ("writeEng".equals(cmd)) {	// 영문 문의 저장시
		
		//out.println(vo);
		
		int result = dao.insert(vo);
		
		//out.println(result);
		
		 if(result> 0 ){
			 
			String title = "["+SiteProperty.COMPANY_NAME+"]"+Function.parseStr(vo.get("name"))+"님의 영문페이지 1:1문의입니다.";
			String contents = "";
			contents = "<table>";
			contents += "제목 : "+Function.parseStr(vo.get("title"))+"<br/>";
			contents += "이름 : "+Function.parseStr(vo.get("name"))+"<br/>";
			contents += "이메일 : "+Function.parseStr(vo.get("email"))+"<br/>";
			contents += "내용 : <br/>"+Function.parseStr(vo.get("contents"))+"<br/><br/>";
						
			String mailForm = MakeMailForm.getURLMakeMailForm(SiteProperty.COMPANY_URL, SiteProperty.EMAIL_FORM, "");	// 이메일폼을 읽어온다.
			mailForm = Function.replace(mailForm, ":SUBJECT", Function.parseStr(vo.get("title")));													// :SUBJECT을 title로 변경한다.
			//mailForm = Function.replace(mailForm, ":CONTENT", contents); 												// :CONTENT을 content로 변경한다.
			mailForm = Function.replace(mailForm, ":CONTENT", Function.nl2br(contents));
			
	
			out.println(mailForm);
			//out.println(""+SiteProperty.COMPANY_EMAIL+Function.parseStr(vo.get("email"))+title);
				
			try {
				//int r = SendMail.sendEmail(SiteProperty.COMPANY_EMAIL, Function.parseStr(vo.get("email")), title, mailForm);						// ID, PW 메일 발송
				int t = SendMail.sendEmail(SiteProperty.COMPANY_EMAIL, "nhkim@kani.or.kr", title, mailForm);						// ID, PW 메일 발송
				//out.println(r == 1 ? "발송 성공" : "발송 실패");
				
				out.print(Function.returnURL(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", "Your request has received. Thank you."));
				//out.print(Function.returnURL(param.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/idpwFind.jsp", null, 0), UsingProperties.getMsg("alert.email.success")));
			} catch (Exception e) {
				out.print(Function.returnURL(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", "Sorry. Error has occured. Please write mail form later."));
			}
		} 			
			
	} else{
		out.print(Function.returnURL(Function.getRemoviSslUrl(request.getRequestURL())+"/qna.jsp", "요청처리중 장애가 발생하였습니다."));
	}
	
%>
<%
}else{
	out.print(Function.returnURL(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", "요청처리중 장애가 발생하였습니다."));
}
%>
