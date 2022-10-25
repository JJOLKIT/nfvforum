<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="environment.admin.*" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%@ include file="config.jsp" %>
<%@ include file="/admin/include/logingCheck.jsp" %>
<%
HashMap<String, Object> param = new HashMap();
param = BeanUtils.bindHashMap(request, param, pageRows);

AdminDAO ad = AdminDAO.getInstance();

int[] rowPageCount = ad.countLoginHistory(param);
ArrayList<HashMap> list = ad.listLoginHistory(param);
%>
<!doctype html>
<html lang="ko">
<head>
<%@ include file="/admin/include/headHtml.jsp" %>
</head>
<body> 
<%@ include file="/admin/include/common.jsp" %>
<%@ include file="/admin/include/header.jsp" %>
<div id="warp">
	<div class="contents">
		<h2 class="fl_l"><%=pageTitle %></h2>
		<div class="list">
			<p style="clear:both;">전체 <strong><%=rowPageCount[0]%></strong>건 [<%=param.get("reqPageNo")%>/<%=rowPageCount[1]%>페이지]</p>
			<table summary="관리자접속기록 목록입니다.">
				<colgroup>
					<col class="w10" />
					<col class="" />
					<col class="w20" />
					<col class="w20" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col" class="first">번호</th>
						<th scope="col">아이디</th> 
						<th scope="col">아이피</th> 
						<th scope="col">접속일</th> 
					</tr>
				</thead>
				<tbody>
				<% if (list.size() == 0) { %>
					<tr>
						<td class="first" colspan="4">등록된 데이터가 없습니다.</td>
					</tr>
				<%
					} else { 
						for (int i=0; i<list.size(); i++) {
				%>
					<tr>
						<td class="first"><%=rowPageCount[0]-(Function.getIntParameter(Function.parseStr(param.get("reqPageNo")))-1*pageRows)-i%></td>
						<td><%=list.get(i).get("id")%></td>
						<td><%=list.get(i).get("ip")%></td>
						<td class="last"><%=Function.parseDateTime(list.get(i).get("logindate"))%></td>
					</tr>
				<%
						}
					}
				%>
				</tbody>
			</table>
			<!--//btn-->
		</div>
		<!-- //blist -->
		<div class="pagenate btnSet clear">
			<%=Page.indexList(Function.getIntParameter(Function.parseStr(param.get("reqPageNo"))), rowPageCount[1], request) %>
		</div>
		<form name="searchForm" id="searchForm" action="index.jsp" method="post">
			<div class="search">
				<select name="stype" title="검색을 선택해주세요">
					<option value="all" <%=Function.getSelected(Function.parseStr(param.get("stype")), "all") %>>전체</option>
					<option value="id" <%=Function.getSelected(Function.parseStr(param.get("stype")), "id") %>>아이디</option>
					<option value="name" <%=Function.getSelected(Function.parseStr(param.get("stype")), "name") %>>이름</option>
				</select>
				<input type="text" name="sval" value="<%=Function.parseStr(param.get("sval"))%>" title="검색할 내용을 입력해주세요" />
				<input type="submit" value="검색" class="btn_search" />
			</div>
		</form>
		
	</div>
	<!--//contents -->
</div>
<!--//wrap -->

</body>
</html>