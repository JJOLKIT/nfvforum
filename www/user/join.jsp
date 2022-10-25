<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "/header.jsp"%>
<%@ page import="property.SiteProperty" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<SCRIPT type="text/javascript">
	$(function(){
		$('.mem_ck').on('click',function(){
			window.open("/member/","","");
		});
	});
function goSave() {
	if ($("#s_agree").is(":checked")==false) {
		alert("이용약관 및 개인정보 수집 이용에 동의해 주세요");
		$("#s_agree").focus();
		return false;
	}
	if ($("#id").val().trim() == "") {
		alert("아이디를 입력해 주세요.");
		$("#id").focus();
		return false;
	}
	$.ajax({
		type : "POST",
		url: "/include/id_check.jsp",
		async: false,
		data: {
			id : $("#id").val()
		},
		success: function( data ) {
			var r = data.trim();
			if (r == "false") {
				alert("중복된 아이디입니다.");
				$("#id").focus();
				$("#id_duplication").val("1");
			} else if (r == "true") {
				$("#id_duplication").val("0");
			}
		},
		error:function(e) {
			alert(e.responseText);
		}
	});
	
	if ($("#id_duplication").val() == "1") {
		alert("중복되지 않은 아이디를 입력해주세요.");
		return false;
	}
	if(!validPassword($("#password"))) return false;
	if ($("#password").val().trim() != $("#password2").val().trim()) {
		alert("비밀번호를 정확하게 입력해 주세요.");
		$("#password2").focus();
		return false;
	}
	if ($("#name").val().trim() == "") {
		alert("이름을 입력해 주세요.");
		$("#name").focus();
		return false;
	}
	if ($("#cell").val().trim() == "") {
		alert("연락처를 입력해 주세요.");
		$("#cell").focus();
		return false;
	}
	if ($("#email3").val().trim() == "") {
		alert("이메일을 입력해 주세요.");
		$("#email3").focus();
		return false;
	}
	if ($("#email2").val().trim() == "") {
		alert("나머지 이메일을 입력해 주세요.");
		$("#email2").focus();
		return false;
	}
	let emailMerge = $("#email3").val()+'@'+$("#email2").val();
	$("#email").val(emailMerge);

	console.log($("#email").val());

	$.ajax({
		type : "POST",
		url: "/include/email_check.jsp",
		async: false,
		data: {
			email : $("#email").val()
		},
		success: function( data ) {
			var r = data.trim();
			if (r == "false") {
				alert("이미 같은 이메일로 가입된 계정이 있습니다.\n회원이시면 로그인 하세요.");
				$("#email").focus();
				$("#email_duplication").val("1");
			} else if (r == "true") {
				$("#email_duplication").val("0");
			}
		},
		error:function(e) {
			alert(e.responseText);
		}
	});
	if ($("#email_duplication").val() == "1") {
		return false;
	}
	
	
	$("#board").submit();
}

function checkId(){
	if ($("#id").val().trim() == "") {
		alert("아이디를 입력해 주세요.");
		$("#id").focus();
		return false;
	} else {
		console.log($("#id").val());
		$.ajax({
			type : "POST",
			url: "/include/id_check.jsp",
			async: false,
			data: {
				id : $("#id").val()
			},
			success: function( data ) {
				var r = data.trim();
				console.log(r);
				if (r == "false") {
					alert("중복된 아이디입니다.");
					$("#id").focus();
					$("#id_duplication").val("1");
					console.log($("#id_duplication").val());
				} else if (r == "true") {
					alert("사용가능한 아이디입니다.");
					$("#id_duplication").val("0");
				}
			},
			error:function(e) {
				alert(e.responseText);
			}
		});
	}
}
</SCRIPT>
<section id="sub" class="join">
	<!-- sub_contents -->
	<section class="sub_contents">
		<div class="container_wrap">
			<div class="container">
				<h3 class="sub_title"><span>회원가입</span></h3>
				<div class="cont1">
					<strong>이용약관 및 개인정보 수집 이용 동의</strong>
					<div class="agree_area">
						<div class="agree_con">
							<div class="text_scroll">
								<div class="agree">
									<%@ include file = "/include/policy_2019.jsp" %>
								</div>
							</div>
						</div>
						<div class="agreement">
							<span>
								<input type="checkbox" name="s_agree" id="s_agree"><label for="s_agree">이용약관 및 개인정보수집 이용에 동의합니다.</label>			
							</span>
						</div>
					</div>
				</div>
				<div class="cont2">
					<table>
						<colgroup>
							<col width="200px">
							<col width="*">
							<col width="200px">
							<col width="*">
						</colgroup>
							<tbody>
								<form id="board" action="process.jsp" method="post">
								<tr>
									<th><span class="star">회원 구분</span></th>
									<td colspan="3">
										<span><input type="radio" id="u_agree" name="grade" value="1"><label for="u_agree">일반</label></span>
										<span><input type="radio" id="u_agree2" name="grade" value="3"><label for="u_agree2">회원사</label></span>
										<span><input type="button" class="mem_ck" value="회원사 확인"/></span>
									</td>
								</tr>
								<tr>
									<th><span class="star">아이디</span></th>
									<td colspan="3">
										<input type="text" class="u_id" name="id" id="id"/>
										<span><input type="button" value="중복확인" class="id_ck" onclick="checkId();"/></span>
									</td>
								</tr>
								<tr>
									<th><span class="star">이름</span></th>
									<td>
										<input type="text" name="name" id="name"/></label>
									</td>
									<th><span class="star">연락처</span></th>
									<td>
										<input type="text" name="cell" id="cell" class="ipt" value="" maxlength="13" onkeyup="isNumberOrHyphen(this);cvtPhoneNumber(this);"></label>
									</td>
								</tr>
								<tr>
									<th><span class="star">비밀번호</span></th>
									<td>
										<input type="password"/ name="password" id="password"></label>
									</td>
									<th><span class="star">비밀번호 확인</span></th>
									<td>
										<input type="password"/ name="password2" id="password2"></label>
									</td>
								</tr>
								<tr>
									<th><span class="star">소속</span></th>
									<td>
										<input type="text"/ name="division" id="division" ></label>
									</td>
									<th><span class="star">직위</span></th>
									<td>
										<input type="text"/ name="position" id="position"></label>
									</td>
								</tr>
								<tr>
									<th><span class="star">이메일</span></th>
									<td colspan="3" class="clear">
										<input type="text" class="u_email1" name="email3" id="email3">
										<i>@</i>
										<select class="u_email">
											<option value="">직접입력</option>
											<option value="naver.com"> naver.com</option>									
											<option value="gmail.com"> gmail.com</option>
											<option value="hanmail.net"> hanmail.net</option>									
											<option value="nate.com"> nate.com</option>
										</select>
										<input type="text" class="u_email2 pic" name="email2" id="email2">
									</td>
								</tr>
								<input type="hidden" name="cmd" value="write" />
								<input type="hidden" name="secession" value="0" />
								<input type="hidden" name="email" id="email" />
								<input type="hidden" name="id_duplication" id="id_duplication" value="1" />
								<input type="hidden" name="email_duplication" id="email_duplication" value="1" />
								</form>
							</tbody>
					</table>
				</div>
				<div class="btm_btn">
					<input type="reset" value="취소" class="btn_reset" onclick="history.back();">
					<input type="button" value="회원가입" class="btn_ok" onclick="goSave();">
				</div>
			</div>
		</div>
	</section>
</section>

<%@ include file = "/footer.jsp"%>