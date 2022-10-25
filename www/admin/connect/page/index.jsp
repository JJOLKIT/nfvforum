<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="pagelog.*" %>
<%@ page import="property.SiteProperty" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%@ include file="/admin/include/logingCheck.jsp" %>
<%
	HashMap<String, Object> param = new HashMap();
	param = BeanUtils.bindHashMap(request, param, 9999);
	PagelogDAO dao = PagelogDAO.getInstance();
	
	ArrayList<HashMap<String, Object>> list = dao.list(param);
	int[] rowPageCount = dao.count(param);

	String today = DateUtil.getToday();
	String yesterday = DateUtil.getDayDateAdd(-1, today);
	String oneweek = DateUtil.getDayDateAdd(-7, today);
	String onemonth = DateUtil.getMonthDateAdd(-1, today);
	String twomonth = DateUtil.getMonthDateAdd(-2, today);
	String threemonth = DateUtil.getMonthDateAdd(-3, today);
	
	
	ArrayList<HashMap<String, Object>> eachData = dao.pageCount(param);
	ArrayList<HashMap<String, Object>> deviceData = dao.deviceCount(param);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/admin/include/headHtml.jsp" %>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
google.charts.load('current', {'packages':['corechart']});
  google.charts.setOnLoadCallback(drawChart);
  google.charts.setOnLoadCallback(drawChart2);
function drawChart(){
	var data = google.visualization.arrayToDataTable([
		['페이지', '방문 수'],
		<%
			HashMap<String, Object> ed; 
			for(int i = 0 ; i < eachData.size(); i++){
				ed = eachData.get(i);
			if(i > 0){
				out.println(",");
			}
		%>['<%=ed.get("ppage")%>', <%=ed.get("cnt")%>]<%}%>
		
	

	]);
	console.log(data);
	var options = {
		title : '페이지별 방문자 통계',
			 pieHole: 0.4
		
	};

	var chart = new google.visualization.PieChart(document.getElementById('chart'));
	chart.draw(data,options);
}

function drawChart2(){
	var data = google.visualization.arrayToDataTable([
		['접속기기', '접속 수'],
		<%
			HashMap<String, Object> dd;
			for(int i = 0 ; i < deviceData.size(); i++){
				dd = deviceData.get(i);
			if(i > 0){
				out.println(",");
			}
		%>['<%=dd.get("user_agent")%>', <%=dd.get("cnt")%>]<%}%>
		
	

	]);
	var options = {
		title : '접속기기별 방문자 통계',
			 pieHole: 0.4,
		tooltip: {trigger : 'selection'}
		
	};

	var chart = new google.visualization.PieChart(document.getElementById('chart2'));
	chart.draw(data,options);
}
</script>

<script>
//달력부분
$(window).load(function() {
	initCal({id:"sdate",type:"day",today:"y"});			
	initCal({id:"edate",type:"day",today:"y"});
	
	$("input[type=text][name*=sval]").keypress(function(e){
		if(e.keyCode == 13){
			goSearch();
		}
	});
	
	
});

function goSearch() {
	$("#search").attr("action","index.php");
	$("#search").submit();
}

function searchDate(startDay, endDay) {
	var f = document.search;
	f.sdate.value = startDay;
	f.edate.value = endDay;

	goSearch();
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
		<h2 class="fl_l">페이지 내역</h2>
		<div class="search_warp">
		<form method="get" name="searchForm" id="searchForm" action="index.jsp">
			<table class="searchTable">
				<caption> 검색 </caption>
				<colgroup>
					<col width="10%" />
					<col width="60%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
				</colgroup>
				<tbody>
					<tr>
						<th class="bno">접속일시</th>
						<td  class="bno">
							<input type="text" name="sdate" id="sdate"  value="<%=Function.parseStr(param.get("sdate"))%>" class="date" onkeyup="cvtDate(this);isNumberOrHyphen(this);" maxlength="10"/>
							<span id="CalsdateIcon" style="height:22px; line-height:22px;vertical-align:middle;">
							<img src="../../img/ico_calendar.gif" id="CalsdateIconImg" style="cursor:pointer;"/> ~
							</span>
							<input type="text" name="edate"  id="edate" value="<%=Function.parseStr(param.get("edate")) %>" class="date" onkeyup="cvtDate(this);isNumberOrHyphen(this);" maxlength="10"/>
							<span id="CaledateIcon" style="height:22px; line-height:22px;vertical-align:middle;margin-right:5px;">
							<img src="../../img/ico_calendar.gif" id="CaledateIconImg" style="cursor:pointer;"/>
							</span>
							<input type="button" value="검색" class="" onclick="goSearch();"/>
							<input type="button" name="" value="오늘" class="" onclick="searchDate('<%=today %>','<%=today%>');"/>
							<input type="button" name="" value="어제" class="" onclick="searchDate('<%=yesterday %>','<%=yesterday%>');"/>
							<input type="button" name="" value="1주" class="" onclick="searchDate('<%=oneweek %>','<%=today%>');"/>
							<input type="button" name="" value="1M" class="" onclick="searchDate('<%=onemonth%>','<%=today%>');"/>
							<input type="button" name="" value="2M" class="" onclick="searchDate('<%=twomonth %>','<%=today%>');"/>
							<input type="button" name="" value="3M" class="" onclick="searchDate('<%=threemonth %>','<%=today%>');"/>
						</td>
						<th class="bno">검색어</th>
						<td class="bno">
							<input type="text" name="sval" id="sval" value="<%=Function.parseStr(param.get("sval")) %>" />
						</td>
						<td class="bno">
							<input type="submit" value="검색" class="btn_search" />
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<div class="eachResult" style="overflow:hidden;">
			<div id="chart" style="width:50%; height:400px; float:left;"></div>
			<div id="chart2" style="width:50%; height:400px; float:left;"></div>
		</div>
		</div>
		<!-- //search_warp -->
		<div class="list">
			<p>전체 <strong><%=rowPageCount[0]%></strong>건 [<%=param.get("reqPageNo")%>/<%=rowPageCount[1]%>페이지]</p>

			<form name="frm" id="frm" action="process.jsp" method="post">
				<table>
					<caption> 목록 </caption>
						<colgroup>
							<col width="50px" />
						<col width="100px" />
						<col width="15%" />
						<col width="150px" />
						<col width="120px" />
						<col width="*"/>
						<col width="200px" />
						</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
						<th scope="col">접속기기</th>
						<th scope="col">브라우저</th>
						<th scope="col">OS</th>
						<th scope="col">아이피</th>
						<th scope="col">페이지</th>
						<th scope="col">일시</th>
						</tr>
					</thead>
					<tbody>
					<% if (rowPageCount[0] == 0) { %>
						<tr>
							<td colspan="6">등록된 데이터가 없습니다.</td>
						</tr>
					<%
						 } else {
			
						HashMap<String, Object> data;
						for (int i=0; i<list.size(); i++) {
							data = list.get(i);
				%>
						<tr>
							<td><%=rowPageCount[0] - (Function.getIntParameter(Function.parseStr(param.get("reqPageNo")))-1)*9999 - i%></td>
							<td class="txt_l"><%=Function.parseStr(data.get("user_agent"))%></td>					
							<td class="txt_l"><%=Function.parseStr(data.get("browser"))%></td>
							<td><%=Function.parseStr(data.get("os")) %></td>
							<td><%=Function.parseStr(data.get("ip")) %></td>
							<td><%=Function.parseStr(data.get("page")) %></td>
							<td class="txt_l wbreak"><%=Function.parseDateTime(data.get("registdate")) %></td>
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