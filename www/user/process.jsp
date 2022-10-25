<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="member.*" %>
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
	MemberDAO dao = MemberDAO.getInstance();
	String cmd = Function.parseStr(vo.get("cmd"));
	

	if ("write".equals(cmd)) {	// 저장시
		


		int r = dao.insert(vo); 
		if (r > 0) {
			if("3".equals(Function.parseStr(vo.get("grade")))) {
				
				String title = "["+SiteProperty.COMPANY_NAME+"]"+Function.parseStr(vo.get("name"))+"님의 회원사 가입신청입니다.";
				String contents = "";
				contents += "";
				
				String mailForm = MakeMailForm.getURLMakeMailForm(SiteProperty.COMPANY_URL, SiteProperty.EMAIL_FORM1, "");	// 이메일폼을 읽어온다.
				mailForm = Function.replace(mailForm, ":SUBJECT", Function.parseStr(vo.get("name"))+"님의 회원사 가입신청입니다.");													// :SUBJECT을 title로 변경한다.
				//mailForm = Function.replace(mailForm, ":CONTENT", Function.parseStr(vo.get("contents"))); 												// :CONTENT을 content로 변경한다.
				mailForm = Function.replace(mailForm, ":CONTENT", Function.parseStr(vo.get("id")));				
		
				//out.println(mailForm);
				//out.println(""+SiteProperty.COMPANY_EMAIL+Function.parseStr(vo.get("email"))+title);
				
				try {
					//int t = SendMail.sendEmail(SiteProperty.COMPANY_EMAIL, "sanggong0102@naver.com", title, mailForm);						// ID, PW 메일 발송
					int t = SendMail.sendEmail(SiteProperty.COMPANY_EMAIL, "sdnnfv21@gmail.com", title, mailForm);						// ID, PW 메일 발송
					//out.println(r == 1 ? "발송 성공" : "발송 실패");
					out.print(Function.returnURL(dao.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", vo, ""), "정상적으로 등록되었습니다. \\n(회원사 회원은 관리자 승인 후, 가입완료됩니다.)"));
					//out.print(Function.returnURL(Function.getRemoviSslUrl(request.getRequestURL())+"/qna.jsp", "입력하신 정보가 담당자 이메일로 발송되었습니다."));
					//out.print(Function.returnURL(param.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/idpwFind.jsp", null, 0), UsingProperties.getMsg("alert.email.success")));
				} catch (Exception e) {
					out.print(Function.returnURL(Function.getRemoviSslUrl(request.getRequestURL())+"/qna.jsp", "요청처리중 장애가 발생하였습니다."));
				}
				
				
				
				
				//out.print(Function.returnURL(dao.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", vo, ""), "정상적으로 등록되었습니다.(회원사 회원은 관리자 승인 후, 가입완료됩니다.)"));
			} else {
				out.print(Function.returnURL(dao.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", vo, ""), "정상적으로 등록되었습니다. "));				
			}
		} else {
			out.print(Function.returnURL(dao.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", vo, ""), "요청처리중 장애가 발생하였습니다."));
		}
		
	} else if ("edit".equals(cmd)) {
		int r = dao.updateUser(vo);
		if (r > 0) {
			out.print(Function.returnURL(dao.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/my_info.jsp", vo, ""), "정상적으로 수정되었습니다."));
		} else {
			out.print(Function.returnURL(dao.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/my_info.jsp", vo, ""), "요청처리중 장애가 발생하였습니다."));
		}	
	} else if ("secession".equals(cmd)) {
		int no =  Function.parseInt(request.getParameter("no"));
		int r = dao.secession(no);
		if (r > 0) {
			out.print(Function.returnURL(dao.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/complete.jsp", vo, ""), "정상적으로 탈퇴 되었습니다. 이용해 주셔서 감사합니다."));
			session.invalidate();
		} else {
			out.print(Function.returnURL(dao.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", vo, ""), "요청처리중 장애가 발생하였습니다."));
		}
	} else if ("delete".equals(cmd)) {
		int no =  Function.parseInt(request.getParameter("no"));
		
		int r = dao.delete(no);
		if (r > 0) {
			out.print(Function.returnURL(dao.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", vo, ""), "정상적으로 삭제되었습니다."));
		} else {
			out.print(Function.returnURL(dao.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", vo, ""), "요청처리중 장애가 발생하였습니다."));
		}
	} else if("idsearch".equals(cmd)){
		HashMap<String, Object> data = new HashMap();		
		
		data = dao.idsearch(vo);
		
		if(data == null){
			out.print(Function.returnURL(dao.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/id_search.jsp", vo, ""), "요청처리중 장애가 발생하였습니다. 이메일이나 아이디가 중복됩니다"));
		}else{
		

			String title = "["+SiteProperty.COMPANY_NAME+"]"+Function.parseStr(data.get("name"))+"님의 아이디입니다.";
			String contents = "";
			contents += data.get("name")+"님의 아이디는 <b style='color: #df1b51;'>"+data.get("id")+"</b> 입니다.<br><br>";
			
			String mailForm = MakeMailForm.getURLMakeMailForm(SiteProperty.COMPANY_URL, SiteProperty.EMAIL_FORM, "");	// 이메일폼을 읽어온다.
			mailForm = Function.replace(mailForm, ":SUBJECT", title);													// :SUBJECT을 title로 변경한다.
			mailForm = Function.replace(mailForm, ":CONTENT", contents); 												// :CONTENT을 content로 변경한다.
			mailForm = Function.replace(mailForm, ":CONTENT", Function.nl2br(contents));				

			//out.println(mailForm);

			//out.println(""+SiteProperty.COMPANY_EMAIL+Function.parseStr(vo.get("email"))+title);
			
			
			try {
				int r = SendMail.sendEmail(property.SiteProperty.COMPANY_EMAIL, Function.parseStr(vo.get("email")), title, mailForm);						// ID, PW 메일 발송
				//out.println(r == 1 ? "발송 성공" : "발송 실패");
				out.print(Function.returnURL(Function.getRemoviSslUrl(request.getRequestURL())+"/login.jsp", "아이디 정보가 가입 당시 입력한 이메일로 발송되었습니다."));
				//out.print(Function.returnURL(param.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/idpwFind.jsp", null, 0), UsingProperties.getMsg("alert.email.success")));
			} catch (Exception e) {
				//out.println(e.toString());
				out.print(Function.returnURL(Function.getRemoviSslUrl(request.getRequestURL())+"/login.jsp", "요청처리중 장애가 발생하였습니다. 메일 발송에 실패하였습니다."));
			}
			
			
		} 
			
	} else if("pwsearch".equals(cmd)){
		HashMap<String, Object> data = new HashMap();
		
		data = dao.pwsearch(vo);
		
		if(data == null){
			out.print(Function.returnURL(dao.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/pw_search.jsp", vo, ""), "일치하는 회원이 없습니다."));
		}else{			
			
			String temppass = dao.tempPass(); //임시비밀번호 생성
			boolean chPw = dao.updateTempPass(Function.parseInt(data.get("no")), temppass);

			//DB업뎃
			 if(chPw){//pwutil 암호화(실db)
				String title = "["+SiteProperty.COMPANY_NAME+"]"+vo.get("name")+"님의 임시비밀번호입니다.";			// 메일 제목				
				String contents = "<br>임시비밀번호 : "+temppass;													// 메일 내용				
				
				//성공 -> 메일내용 임시비밀번호(실제)
				title = "["+SiteProperty.COMPANY_NAME+"]"+data.get("name")+"님의 임시비밀번호 입니다.";
				contents = "";
				contents += data.get("name")+"님의 임시비밀번호는 <b style='color: #df1b51;'>"+temppass+"</b> 입니다.<br><br>";
				
				String mailForm = MakeMailForm.getURLMakeMailForm(SiteProperty.COMPANY_URL, SiteProperty.EMAIL_FORM, "");	// 이메일폼을 읽어온다.
				mailForm = Function.replace(mailForm, ":SUBJECT", title);													// :SUBJECT을 title로 변경한다.
			    mailForm = Function.replace(mailForm, ":CONTENT", contents); 												// :CONTENT을 content로 변경한다.
			    //mailForm = Function.replace(mailForm, ":CONTENT", Function.nl2br(contents));
				
				//발송
				try {
					SendMail.sendEmail(SiteProperty.COMPANY_EMAIL, Function.parseStr(vo.get("email")), title, mailForm);						// 임시 PW 메일 발송
					out.print(Function.returnURL(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", "임시 비밀번호가 가입 당시 입력한 이메일로 발송되었습니다."));
					//out.print(Function.returnURL(param.getTargetURLParam(Function.getRemoviSslUrl(request.getRequestURL())+"/idpwFind.jsp", null, 0), UsingProperties.getMsg("alert.email.success")));
				} catch (Exception e) {
					out.print(Function.returnURL(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", "요청처리중 장애가 발생하였습니다. 메일 발송에 실패하였습니다."));
				}
			} 
		}
	}
%>
<%
}else{
	out.print(Function.returnURL(Function.getRemoviSslUrl(request.getRequestURL())+"/index.jsp", "요청처리중 장애가 발생하였습니다."));
}
%>

