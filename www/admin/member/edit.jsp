<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*" %>
<%@ page import="member.*" %>
<%@ page import="util.*" %>
<%@ include file="config.jsp" %>
<%@ include file="/admin/include/logingCheck.jsp" %>
<%
	HashMap<String, Object> param = new HashMap();
	param = BeanUtils.bindHashMap(request, param, pageRows);
	MemberDAO dao = MemberDAO.getInstance();
	HashMap<String, Object> data = dao.read(Function.getIntParameter(param.get("no")));
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/admin/include/headHtml.jsp" %>
<script>
function goSave() {
	
	if ($("#name").val().trim() == "") {
		alert("이름을 입력해 주세요.");
		$("#name").focus();
		return false;
	}
	
	if($('#password').val().trim() != "" ){
		
		if(!validPassword($("#password"))) return false;
		if ($("#password").val().trim() != $("#password2").val().trim()) {
			alert("비밀번호를 정확하게 입력해 주세요.");
			$("#password2").focus();
			return false;
		}
	
	}
	if ($("#email").val().trim() == "") {
		alert("이메일을 입력해 주세요.");
		$("#email").focus();
		return false;
	}
	if ($("#email").val().trim() != "") {
		if(!isValidEmail(getObject("email"))) {
			alert("잘못된 이메일 형식입니다.\\n올바로 입력해 주세요.\\n ex)abcdef@naver.com");
			$("#email").focus();
			return false;
		}
	}
	if ($("#cell").val().trim() == "") {
		alert("휴대폰 번호를 입력해 주세요.");
		$("#cell").focus();
		return false;
	}

	$("#frm").submit();
}

function checkId(){
	if ($("#id").val().trim() == "") {
		alert("아이디를 입력해 주세요.");
		$("#id").focus();
		return false;
	} else {
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

</script>
<!-- 다음우편번호API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function zipcodeapi() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $('#zipcode').val(data.zonecode); //5자리 새우편번호 사용
                $('#addr0').val(fullAddr);

                // 커서를 상세주소 필드로 이동한다.
                $('#addr1').focus();
            }
        }).open();
    }
</script>
</head>
<body> 
<%@ include file="/admin/include/common.jsp" %>
<%@ include file="/admin/include/header.jsp" %>
<div id="warp">
	<div class="contents">
		<h2 class="fl_l"><%=pageTitle%> - [수정]</h2>
		<div class="information">
			<ul>
				<li>※ 회원ID는 수정이 불가합니다.</li>
			
			</ul>
		</div>
		<div class="write">
			<form method="post" name="frm" id="frm" action="<%=Function.getSslCheckUrl(request.getRequestURL())%>/process.jsp" enctype="multipart/form-data" >
			<table>
					<colgroup>
						<col width="8%">
						<col width="42%">
						<col width="8%">
						<col width="42%">
					</colgroup>
					<tbody>
					<tr>
						<th>구분</th>
						<td colspan="3">
							<%
								for(int i = 1; i <= 4; i ++){
							%>
							<input type="radio" name="grade" id="grade<%=i %>" value="<%=i%>" <%=Function.getChecked(i, Function.parseInt(data.get("grade"))) %>/><label for="grade<%=i%>"><%=CodeUtil.getMemberGradeName(i) %></label>
							<%} %>
							<!-- <a href="" style="border:1px solid #aaa; padding:2.5px 5px; display:inline-block; vertical-align:middle;">회원사 확인</a> -->
						</td>
					</tr>
					<tr>
						<th>아이디</th>
						<td><%=Function.parseStr(data.get("id")) %></td>
						<th>이름</th>
						<td><input type="text" name="name" id="name" value="<%=Function.parseStr(data.get("name")) %>" class="wid200" /></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="password" id="password" value=""  class="wid200"/></td>
						<th>비밀번호 확인</th>
						<td><input type="password" name="password2" id="password2" value=""  class="wid200"/></td>
					</tr>
					<tr>
						<th>소속</th>
						<td><input type="text" name="division" id="division" value="<%=Function.parseStr(data.get("division")) %>" class="wid400"/></td>
						<th>직위</th>
						<td><input type="text" name="position" id="position" value="<%=Function.parseStr(data.get("position")) %>" class="wid400"/></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td><input type="text" name="email" id="email" value="<%=Function.parseStr(data.get("email")) %>" class="wid400" onkeyup="isValidEmailing(this);"/></td>
						<th>휴대전화</th>
						<td><input type="text" name="cell" id="cell" value="<%=Function.parseStr(data.get("cell")) %>" class="wid200" maxlength="13" onkeyup="isNumberOrHyphen(this);cvtPhoneNumber(this);"/></td>
					</tr>
					<tr>
						<th>탈퇴</th>
						<td colspan="3">
							<input type="radio" id="secession1" name="secession" value="1" title="예" <%=Function.getChecked(1, Function.parseInt(data.get("secession"))) %>/> 예 &nbsp;
							<input type="radio" id="secession0" name="secession" value="0" title="예" <%=Function.getChecked(0, Function.parseInt(data.get("secession"))) %>/> 아니오
						</td>
					</tr>
				</tbody>
			</table>
				<input type="hidden" name="stype" id="stype" value="<%=param.get("stype")%>"/>
				<input type="hidden" name="sval" id="sval" value="<%=param.get("sval")%>"/>
				<input type="hidden" name="cmd" id="cmd" value="edit"/>
				<input type="hidden" name="no" id="no" value="<%=data.get("no")%>"/>
			</form>
		<div class="btnSet">
			<a class="btn" href="<%=dao.getTargetURLParam("index.jsp", param, "")%>"><strong>목록</strong></a>
			<a class="btn" href="javascript:goSave();"><strong>저장</strong></a>
		</div>
		<!-- //btnSet -->
	</div>
	<!-- //contents -->
</div>
<!-- e:warp -->

</body>
</html>