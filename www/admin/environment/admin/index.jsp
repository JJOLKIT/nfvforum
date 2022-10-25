<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*" %>
<%@ page import="environment.admin.*" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%@ include file="/admin/include/logingCheck.jsp" %>
<%@ include file="config.jsp" %>
<%
HashMap<String, Object> param = new HashMap();
param = BeanUtils.bindHashMap(request, param, pageRows);

AdminDAO ad = AdminDAO.getInstance();
ArrayList<HashMap> list = ad.list(param);
int[] rowPageCount = ad.count(param);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/admin/include/headHtml.jsp" %>
<script>
function groupDelete() {	
	if ( isSeleted(document.frm.USER_KEY) ){
		document.frm.submit();
	} else {
		alert("삭제할 항목을 하나 이상 선택해 주세요.");
	}
}
</script>
</head>
<body> 
<%@ include file="/admin/include/common.jsp" %>
<%@ include file="/admin/include/header.jsp" %>
<div id="warp">
	<div class="contents">
		<h2 class="fl_l"><%=pageTitle %></h2>
		<div class="search_warp">
			<form name="searchForm" id="searchForm" action="index.jsp" method="post">
			<table class="searchTable">
				<colgroup>
					<col width="10%" />
					<col width="10%" />
					<col width="20%" />
					<col width="*" />
				</colgroup>
				<tbody>
					<tr>
						<th class="bno">검색어</th>
						<td class="bno">
							<select name="stype" title="검색을 선택해주세요">
								<option value="all" <%=Function.getSelected(Function.parseStr(param.get("stype")), "all") %>>전체</option>
								<option value="id" <%=Function.getSelected(Function.parseStr(param.get("stype")), "id") %>>아이디</option>
								<option value="name" <%=Function.getSelected(Function.parseStr(param.get("stype")), "name") %>>이름</option>
							</select>
						</td>
						<td class="bno">
							<input type="text" name="sval" value="<%=Function.parseStr(param.get("sval"))%>" />
						</td>
						<td class="bno">
							<input type="submit" value="검색" class="btn_search" />
						</td>
					</tr>
				</tbody>
			</table>
			</form>
			<!-- //search --> 			
		</div>
		<!-- //search_warp -->
		<div class="list">
			<p>전체 <strong><%=rowPageCount[0]%></strong>명 [<%=param.get("reqPageNo")%>/<%=rowPageCount[1]%>페이지]</p>
			<form name="frm" id="frm" action="process.jsp" method="post">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" summary="관리자 관리목록입니다.">
				<colgroup>
					<col class="w3" />
					<col class="w5" />
					<col class="w10" />
					<col class="w10" />
					<col class="" />
					<col class="w20" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col" class="first"><input type="checkbox" name="allChk" id="allChk" onClick="check(this, document.frm.no)"/></th>
						<th scope="col">아이디</th>
						<th scope="col">이름</th>
						<th scope="col">연락처</th>
						<th scope="col">이메일</th>
						<th scope="col" class="last">등록일</th>
					</tr>
				</thead>
				<tbody>
				<% if (list.size() == 0) { %>
					<tr>
						<td class="first" colspan="8">등록된 관리자가 없습니다.</td>
					</tr>
				<%
					 } else {
						String targetUrl = "";
						for (int i=0; i<list.size(); i++) {
							targetUrl = "style='cursor:pointer;' onclick=\"location.href='"+ad.getTargetURLParam("edit.jsp", param, Function.parseStr(list.get(i).get("no")))+"'\"";
				%>
					<tr class="cp">
						<td class="first"><input type="checkbox" name="no" id="no" value="<%=list.get(i).get("no")%>"/></td>
						<td <%=targetUrl%>><%=list.get(i).get("id")%></td>
						<td <%=targetUrl%>><%=list.get(i).get("name")%></td>
						<td <%=targetUrl%>><%=list.get(i).get("tel")%></td>
						<td <%=targetUrl%>><%=list.get(i).get("email")%></td>
						<td <%=targetUrl%>><%=Function.parseDateTime(list.get(i).get("registdate"))%></td>
					</tr>
				<%
						}
					 }
				%>
				</tbody>
			</table>
			<input type="hidden" name="cmd" id="cmd" value="groupDelete"/>
			<input type="hidden" name="sgrade" id="sgrade" value="<%//=param.getSgrade()%>"/>
			<input type="hidden" name="stype" id="stype" value="<%=Function.parseStr(param.get("stype"))%>"/>
			<input type="hidden" name="sval" id="sval" value="<%=Function.parseStr(param.get("sval"))%>"/>
			</form>
		</div>
		<!-- //blist -->
		<!-- //list -->
		<div class="sBtn fl_l mt10">
			<input type="button" value="삭제"  name=""  onclick="groupDelete();"/>
		</div>
		<!-- 페이징 처리 -->
		<div class="pagenate btnSet clear">
			<%=Page.indexList(Function.getIntParameter(Function.parseStr(param.get("reqPageNo"))), rowPageCount[1], request) %>
			<div class="right"><a href="write.jsp" class="btn">관리자등록</a></div>
		</div>
		<!-- //페이징 처리 -->
		<!-- //pagenate -->
	</div>
	<!-- //contents -->
</div>

</body>
</html>