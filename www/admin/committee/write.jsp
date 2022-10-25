<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*" %>
<%@ page import="committee.*" %>
<%@ page import="util.*" %>
<%@ include file="config.jsp" %>
<%@ include file="/admin/include/logingCheck.jsp" %>
<%
	HashMap<String, Object> param = new HashMap();
	param = BeanUtils.bindHashMap(request, param, pageRows);
	
	CommitteeDAO dao = CommitteeDAO.getInstance();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/admin/include/headHtml.jsp" %>
<script>
	var oEditors; // 에디터 객체 담을 곳
	jQuery(window).load(function(){
		//oEditors = setEditor("contents"); // 에디터 셋팅
		initCal({id:"registdate",type:"day",today:"y",timeYN:"y"});
	});
	
	function goSave() {

		if ($("#category").val() == "") {
			alert('카테고리를 선택해 주세요');
			$("#category").focus();
			return false;
		}
		
		if ($("#filename").val() == "") {
			alert('액셀파일을 업로드해주세요.');
			$("#filename").focus();
			return false;
		}
		
		return true;
	}
	
	
</script>
</head>
<body> 
<%@ include file="/admin/include/common.jsp" %>
<%@ include file="/admin/include/header.jsp" %>
<div id="warp">
	<div class="contents">
		<h2 class="fl_l"><%=pageTitle%> - [쓰기]</h2>
		<div class="write">
			<form method="post" name="frm" id="frm" action="<%=Function.getSslCheckUrl(request.getRequestURL())%>/process.jsp" enctype="multipart/form-data" onsubmit="return goSave();">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" summary="관리자 관리 기본내용입니다.">
				<colgroup>
					<col width="12%" />
					<col width="38%" />
					<col width="12%" />
					<col width="38%" />
				</colgroup>
				<tbody>
					<tr>
						<th>카테고리</th>
						<td>
							<select name="category" id="category">
							<%=CodeUtil.getCommitteeCategoryOption(param.get("scategory")) %>
								<!-- <option value = "">전체</option>
								<option value = "1">운영위원회</option>
								<option value = "6">자문위원회</option>
								<option value = "2">기술표준분과</option>
								<option value = "3">정책협력분과</option>
								<option value = "4">대외협력분과</option>	
								<option value = "5">서비스PoC분과</option> -->
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">엑셀파일</th>
						<td colspan="3">
							<input type="file" id="filename" name="filename" class="w50" title="첨부파일을 업로드 해주세요." />	
						</td>
					</tr>					
				</tbody>
				<tfoot>
					<tr>
						<td colspan="4"><a href="/include/download.jsp?path=/admin/committee/&af=committee_sample.xlsx&vf=committee_sample.xlsx" target="_blank" style="border:1px solid #333; padding:5px 10px; display:inline-block;">엑셀 샘플 다운로드</a></td>
					</tr>
				</tfoot>
			</table>
			<input type="hidden" name="cmd" value="write" />
		</form>
		</div>
		<!-- //write -->
		<div class="btnSet">
			<a class="btn" href="<%=dao.getTargetURLParam("index.jsp", param, "")%>"><strong>목록</strong></a>
			<a class="btn" href="javascript:$('#frm').submit();"><strong>저장</strong></a>
		</div>
		<!-- //btnSet -->
	</div>
	<!-- //contents -->
</div>
<!-- e:warp -->
</body>
</html>