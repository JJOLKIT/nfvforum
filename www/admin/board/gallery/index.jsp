<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="board.gallery.*" %>
<%@ page import="property.SiteProperty" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%@ include file="config.jsp" %>
<%@ include file="/admin/include/logingCheck.jsp" %>
<%
	HashMap<String, Object> param = new HashMap();
	param = BeanUtils.bindHashMap(request, param, pageRows);
	GalleryDAO dao = GalleryDAO.getInstance();
	
	ArrayList<HashMap<String, Object>> list = dao.list(param);
	int[] rowPageCount = dao.count(param);
	
	String today = DateUtil.getToday();
	String yesterday = DateUtil.getDayDateAdd(-1, today);
	String oneweek = DateUtil.getDayDateAdd(-7, today);
	String onemonth = DateUtil.getMonthDateAdd(-1, today);
	String twomonth = DateUtil.getMonthDateAdd(-2, today);
	String threemonth = DateUtil.getMonthDateAdd(-3, today);
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
function searchDate(startDay, endDay) {
	var f = document.searchForm;
	f.sstartdate.value = startDay;
	f.senddate.value = endDay;

	goSearch();
}

$(window).load(function() {
	initCal({id:"sstartdate",type:"day",today:"y"});			
	initCal({id:"senddate",type:"day",today:"y"});
	
	$("input[type=text][name*=sval]").keypress(function(e){
		if(e.keyCode == 13){
			goSearch();
		}
	});
	
});
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
					<col width="10%"/>
					<col width="*"/>
					<col width="10%" />
					<col width="10%" />
					<col width="20%" />
					<col width="7%" />
				</colgroup>
				<tbody>
					<tr>
						<th class="bno">
							날짜
						</th>
						<td class="bno">
							<input type="text" name="sstartdate" id="sstartdate"  value="<%=Function.parseStr(param.get("sstartdate")) %>" class="date" onKeyUp="cvtDate(this);isNumberOrHyphen(this);" maxlength="10"/>
							<span id="CalsstartdateIcon" style="height:22px; line-height:22px;vertical-align:middle;">
							<img src="/admin/img/ico_calendar.gif" id="CalsstartdateIconImg" style="cursor:pointer;"/>
							</span> ~ 
							<input type="text" name="senddate"  id="senddate" value="<%=Function.parseStr(param.get("senddate")) %>" class="date" onKeyUp="cvtDate(this);isNumberOrHyphen(this);" maxlength="10"/>
							<span id="CalsenddateIcon" style="height:22px; line-height:22px;vertical-align:middle;margin-right:5px;">
							<img src="/admin/img/ico_calendar.gif" id="CalsenddateIconImg" style="cursor:pointer;"/>
							</span>
							<input type="button" value="검색" class="" onclick="goSearch();"/>
							<input type="button" name="" value="1M" class="" onClick="searchDate('<%=onemonth %>','<%=today%>');"/>
							<input type="button" name="" value="2M" class="" onClick="searchDate('<%=twomonth %>','<%=today%>');"/>
							<input type="button" name="" value="3M" class="" onClick="searchDate('<%=threemonth %>','<%=today%>');"/>
						</td>
						<th class="bno">검색어</th>
						<td class="bno">
							<select name="stype" id="stype" title="검색을 선택해주세요">
								<option value="all" <%=Function.getSelected(Function.parseStr(param.get("stype")), "all") %>>전체</option>
								<option value="title" <%=Function.getSelected(Function.parseStr(param.get("stype")), "title") %>>제목</option>
								<option value="contents" <%=Function.getSelected(Function.parseStr(param.get("contents")), "contents") %>>내용</option>
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
			<div class="gallery">
			<% if (rowPageCount[0] == 0) { %>
				<div class="bbsno">
					<p>등록된 글이 없습니다.</p>
				</div>
			<% } else { %>
				<ul>
				<%
				String targetUrl = "";
				String topClass = "";
				HashMap<String, Object> data;
				for (int i=0; i<list.size(); i++) {
					data = list.get(i);
					targetUrl = "style='cursor:pointer;' onclick=\"location.href='"+dao.getTargetURLParam("edit.jsp", param, Function.parseStr(data.get("no")))+"'\"";
				%>
				
					<li>
						<p class="ipts">
							<input type="checkbox" name="no" id="no" value="<%=data.get("no")%>"/> 
							
							<%=Function.parseStr(data.get("no")) %>
							<% if ("1".equals(Function.parseStr(data.get("display")))) { %>
								<span style="color:red;">메인 노출중</span>
							<% } %>
						</p>
						<a href="<%=dao.getTargetURLParam("edit.jsp", param, Function.parseStr(data.get("no")))%>">
							<div class="imgs">
								<%if(data.get("filename") != null && !"".equals(Function.parseStr(data.get("filename")))){%>
								<p style="background:url('<%=uploadPath+data.get("filename")%>') no-repeat center center/cover;"><img src="/admin/img/no_image.gif" style="opacity:0; visibility:hidden; width:100%; height:auto; "/></p>
								<%} else{%>
								<p style="background:url('/admin/img/no_image.gif') no-repeat center center/contain;"><img src="/admin/img/no_image.gif" style="opacity:0; visibility:hidden; width:100%; height:auto; "/></p>
								<%} %>
							</div>
							<div class="txts">
								<p class="titles"><%=Function.parseStr(data.get("title")) %></p>
								<span><%=Function.parseDateTime(data.get("registdate")) %></span>
							</div>
						</a>
					</li>
					
				<%
						}
					 }
				%>
				</ul>
			</div>
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