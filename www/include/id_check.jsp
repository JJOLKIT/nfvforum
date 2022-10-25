<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="property.*" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="member.*" %>
<%
	boolean loginCheck = false;
	HashMap<String, Object> param = new HashMap();
	param = BeanUtils.bindHashMap(request, param, 999);
	MemberDAO dao = MemberDAO.getInstance();
	
	
	if(!"".equals(param.get("id"))){
		int r = dao.idcheck(param); //id정보와 동일한 회원 있으면 1 숫자 반환
				
		if(r > 0){
			out.println("false"); //겹치는 회원 없는 경우
		}else{
			out.println("true"); // 겹치는 회원 있는 경우
		}
		
	}
%>