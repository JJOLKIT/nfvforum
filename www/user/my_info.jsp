<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="property.*" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%@ page import="member.*" %>
<%@ include file = "/header.jsp"%>


<%if(!loginCheck) { %>
<script>
	alert('로그인 후 이용 가능합니다');
	location.href="/index.jsp";
</script>
<%} else {
	MemberDAO dao = MemberDAO.getInstance();
	HashMap<String, Object> data = dao.read(Function.parseInt(memberInfo.get("no")));
%>
<script>
	$(function(){
		$('.ch_pw').on('click',function(){
			$('.new_pw').css('display','table-row');
		});
	});
	function goSave(){
		if($('#password').val().trim() != ""){
			if(!validPassword($("#password"))) return false;
			if ($("#password").val().trim() != $("#password2").val().trim()) {
				alert("비밀번호를 정확하게 입력해 주세요.");
				$("#password2").focus();
				return false;
			}
		}
		document.board.submit();
	}
	function goSecession(){
		var result = confirm("정말 탈퇴하시겠습니까?");
		if(result){
			if($('#password').val().trim() != ""){
				if(!validPassword($("#password"))) return false;
				if ($("#password").val().trim() != $("#password2").val().trim()) {
					alert("가입하실 때 입력한 비밀번호를 입력해 주세요.");
					$('.new_pw').css('display','table-row');
					$("#password2").focus();
					return false;
				}
			}
			$("#cmd").val("secession");
			document.board.submit();
		}else{
			return false;
		}
	}
</script>

<section id="sub" class="my_info join">
	<!-- sub_contents -->
	<section class="sub_contents">
		<div class="container_wrap">
			<div class="container">
				<h3 class="sub_title"><span>마이 페이지</span></h3>
				<article class="sub_cont">
					<!-- <h4 class="sub_des_title">qna 입니다.</h4> -->
					<div class="cont1">
						<form name="board" id="board" method="post" action="process.jsp">
						<table>
							<colgroup>
								<col width="200px">
								<col width="*">
								<col width="200px">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th>구분</th>
									<td colspan="3">
										<p>
										<%=Function.parseStr(data.get("grade")).equals("1") ? "일반" : ""%>
										<%=Function.parseStr(data.get("grade")).equals("2") ? "회원사" : ""%>
										<%=Function.parseStr(data.get("grade")).equals("3") ? "회원사 가입대기(일반)" : ""%>
										<%=Function.parseStr(data.get("grade")).equals("4") ? "운영위원" : ""%>
										</p>
									
									</td>
									<!-- <th><span class="star">E-mail</span></th>
									<td>
										<input type="text" class="u_email1">
										<i>@</i>
										<select class="u_email">
											<option value="">직접입력</option>
											<option value="naver.com"> naver.com</option>									
											<option value="gmail.com"> gmail.com</option>
											<option value="hanmail.net"> hanmail.net</option>									
											<option value="nate.com"> nate.com</option>
										</select>
										<input type="text" class="u_email2 pic">
									</td> -->
								</tr>
								<tr>
									<th>아이디</th>
									<td>
										<p><%=data.get("id")%><p>
									</td>
									<th>이름</th>
									<td>
										<p><%=data.get("name") %><p>
									</td>
								</tr>
								<tr>
									<th>비밀번호</th>
									<td colspan="3">
										<input type="button" class="ch_pw" value="비밀번호 변경">
									</td>
								</tr>
								<tr class="new_pw" style="display: none;">
									<th>새 비밀번호</th>
									<td>
										<input type="password" name="password" id="password">
									</td>
									<th>새 비밀번호 확인</th>
									<td>
										<input type="password" id="password2">
									</td>
								</tr>
								<tr>
									<th>소속</th>
									<td>
										<input type="text" name="division" value='<%=Function.parseStr(data.get("division"))%>'>
									</td>
									<th>직위</th>
									<td>
										<input type="text" name="position"  value='<%=Function.parseStr(data.get("position"))%>'>
									</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td>
										<input type="text" name="email" value='<%=Function.parseStr(data.get("email"))%>'>
									</td>
									<th>연락처</th>
									<td>
										<input type="text" name="cell"  value='<%=Function.parseStr(data.get("cell"))%>' class="ipt" value="" maxlength="13" onkeyup="isNumberOrHyphen(this);cvtPhoneNumber(this);">
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="btm_btn">
						<a href="javascript:;" onclick="goSave();">수정</a>
						<a href="javascript:;" class="btn_out" onclick="goSecession();">회원탈퇴</a>
					</div>
					
						<input type="hidden" name="no" value="<%=data.get("no")%>"/>
						<input type="hidden" id="cmd" name="cmd" value="edit"/>
					</form>
				</article>
			</div>
		</div>
	</section>
</section>
<%}%>	


<%@ include file = "/footer.jsp"%>