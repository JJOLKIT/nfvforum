<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="board.awards.*" %>
<%@ page import="property.SiteProperty" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%@ include file="config.jsp" %>
<%@ include file="/admin/include/logingCheck.jsp" %>
<%
	HashMap<String, Object> param = new HashMap();
	param = BeanUtils.bindHashMap(request, param, pageRows);
	AwardsDAO dao = AwardsDAO.getInstance();
	
	ArrayList<HashMap<String, Object>> list = dao.list(param);
	int[] rowPageCount = dao.count(param);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/admin/include/headHtml.jsp" %>
<script>
function groupDelete() {	
	if ( isSeleted(document.frm.no) ){
		document.frm.submit();
	} else {
		alert("삭제할 항목을 하나 이상 선택해 주세요.");
	}
}

function goSearch() {
	$("#searchForm").submit();
}

</script>
</head>
<body> 
<%@ include file="/admin/include/common.jsp" %>
<!-- S T A R T :: headerArea-->
<%@ include file="/admin/include/header.jsp" %>
<!-- E N D :: headerArea--> 
<!-- s:warp -->
<div id="warp">
	<div class="contents">
		<h2 class="fl_l"><%=pageTitle%></h2>
		<div class="search_warp">
		<form method="get" name="searchForm" id="searchForm" action="index.jsp">
			<table class="searchTable">
				<caption> 게시글검색 </caption>
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
							<select name="stype" id="stype" title="검색을 선택해주세요">
								<option value="all" <%=Function.getSelected(Function.parseStr(param.get("stype")), "all") %>>전체</option>
								<option value="title" <%=Function.getSelected(Function.parseStr(param.get("stype")), "title") %>>제목</option>
							</select>							
						</td>
						<td class="bno">
							<input type="text" name="sval" id="sval" value="<%=Function.parseStr(param.get("sval"))%>" />
						</td>
						<td class="bno">
							<input type="submit" value="검색" class="btn_search" />
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		</div>
		<!-- //search_warp -->
		<div class="list">
			<p>전체 <strong><%=rowPageCount[0]%></strong>건 [<%=param.get("reqPageNo")%>/<%=rowPageCount[1]%>페이지]</p>
			<form name="frm" id="frm" action="process.jsp" method="post">
			<table>
				<colgroup>
					<col width="50px" />
					<col width="50px" />
					<col width="20%" />
					<col width="*" />
					<col width="12%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col"><input type="checkbox" name="allChk" id="allChk" onClick="check(this, document.frm.no)"/></th>
						<th scope="col">번호</th>
						<th scope="col">이미지</th>
						<th scope="col">제목</th>
						<th scope="col">작성일</th>
					</tr>
				</thead>
				<tbody>
				<% if (rowPageCount[0] == 0) { %>
					<tr>
						<td class="first" colspan="5">등록된 게시글이 없습니다.</td>
					</tr>
				<%
					 } else {
						String targetUrl = "";
						String topClass = "";
						HashMap<String, Object> data;
						for (int i=0; i<list.size(); i++) {
							data = list.get(i);
							targetUrl = "style='cursor:pointer;' onclick=\"location.href='"+dao.getTargetURLParam("edit.jsp", param, Function.parseStr(data.get("no")))+"'\"";
				%>
					<tr>
						<td class="first"><input type="checkbox" name="no" id="no" value="<%=data.get("no")%>"/></td>
						<td <%=targetUrl%>>

							<%=rowPageCount[0] - (Function.getIntParameter(Function.parseStr(param.get("reqPageNo")))-1)*pageRows - i%>
			
						</td>
						<td <%=targetUrl%>><img src="<%=uploadPath%><%=data.get("filename") %>" style="max-width:100%; max-height:150px;"/></td>
						<td <%=targetUrl%> >
							<%=data.get("title")%>
						</td>
						<td <%=targetUrl%>><%=Function.parseDateTime(data.get("registdate"))%></td>
					</tr>
				<%
						}
					 }
				%>
				</tbody>
			</table>
				<input type="hidden" name="cmd" id="cmd" value="groupDelete"/>
				<input type="hidden" name="stype" id="stype" value="<%=param.get("stype")%>"/>
				<input type="hidden" name="sval" id="sval" value="<%=param.get("sval")%>"/>
			</form>
		</div>
		<div class="sBtn fl_l mt10">
			<input type="button" value="삭제"  name=""  onclick="groupDelete();"/>
		</div>
		<div class="pagenate btnSet clear">
			<%=Page.indexList(Function.getIntParameter(Function.parseStr(param.get("reqPageNo"))), rowPageCount[1], request)%>
			<div class="right"><a href="write.jsp" class="btn">글쓰기</a></div>
		</div>
		<!-- //pagenate -->			
		<!--//btn-->
	</div>
	<!-- //contents -->
</div>
<!-- e:warp --> 
</body>
</html>