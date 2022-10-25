<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "/header.jsp"%>

<%@ page import="property.SiteProperty" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="member.*" %>

<SCRIPT type="text/javascript">
$(document).ready(function(e){
	$("#id").focus();
});
</SCRIPT>

<script>
	function goSave(){
		var frm = document.board;
			
		if(frm.name.value.trim() == ""){
			alert('이름을 입력해 주세요.');
			frm.name.focus();
			return false;
		}
		if(frm.email3.value.trim() == ""){
			alert('이메일을 입력해 주세요.');
			frm.email3.focus();
			return false;
		}
		if(frm.email2.value.trim() == ""){
			alert('나머지 이메일을 입력해 주세요.');
			frm.email2.focus();
			return false;
		}
		
		let emailMerge = $("#email3").val()+'@'+$("#email2").val();
		$("#email").val(emailMerge);
		
		$("#board").submit();
		/* $.post("process.jsp", { cmd : "idsearch", userName: userName, userEmail: userEmail, type : "post"}, function(data){idMailSend_proc(data);}); */
		
	}
</script>

<section id="sub" class="pw_s id_s login">
	<!-- sub_contents -->
	<section class="sub_contents">
		<div class="container">
			<!-- <h3 class="sub_title"><span>로그인</span></h3> -->
			<div class="cont1">
				<div class="inner">
					<div class="top">
						<h4 class="user_title">아이디 찾기</h4>
						<span>가입하신 이메일주소를 확인하여 해당 메일로 아이디를 안내드립니다.</span>
					</div>
					<form name="board" id="board" method="post" action="process.jsp">
					<div class="mid clear">
						<input type="text" class="u_name" placeholder="이름" name="name" />
						<div class="email">
							<input type="text" class="u_email1" id="email3" name="email3">
							<i>@</i>
							<select class="u_email">
								<option value="">직접입력</option>
								<option value="naver.com"> naver.com</option>									
								<option value="gmail.com"> gmail.com</option>
								<option value="hanmail.net"> hanmail.net</option>									
								<option value="nate.com"> nate.com</option>
							</select>
							<input type="text" class="u_email2 pic" id="email2" name="email2">
						</div>
					</div>
					<div class="btm">
						<input type="button" value="확인" onclick="goSave();">
						<ul>
							<li><a href="/user/login.jsp">로그인</a></li>
							<li><a href="/user/id_search.jsp">아이디 찾기</a></li>
							<li><a href="/user/pw_search.jsp">비밀번호 찾기</a></li>
						</ul>
					</div>
					<input type="hidden" name="email" id="email">
					<input type="hidden" name="cmd" value="idsearch">
					</form>
				</div>
			</div>
	</section>
</section>

<%@ include file = "/footer.jsp"%>