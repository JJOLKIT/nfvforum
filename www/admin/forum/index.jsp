<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="forum.*" %>
<%@ page import="property.SiteProperty" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%@ include file="config.jsp" %>
<%@ include file="/admin/include/logingCheck.jsp" %>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="java.util.Calendar"%>
<%
	HashMap<String, Object> param = new HashMap();
	param = BeanUtils.bindHashMap(request, param, pageRows);
	ForumDAO dao = ForumDAO.getInstance();
	
	//ArrayList<HashMap<String, Object>> list = dao.list(param);
	//int[] rowPageCount = dao.count(param);
	
	String today = DateUtil.getToday();
	String yesterday = DateUtil.getDayDateAdd(-1, today);
	String oneweek = DateUtil.getDayDateAdd(-7, today);
	String onemonth = DateUtil.getMonthDateAdd(-1, today);
	String twomonth = DateUtil.getMonthDateAdd(-2, today);
	String threemonth = DateUtil.getMonthDateAdd(-3, today);

Calendar cal = Calendar.getInstance();
String strYear = Function.parseStr(param.get("syear"));
String strMonth = Function.parseStr(param.get("smonth"));



//req.put("sregistdate", sUseDate.substring(0,4)+'-'+sUseDate.substring(4,6)+"-"+sUseDate.substring(6,8));


if("".equals(strYear)){
	strYear = today.substring(0,4);
}

if("".equals(strMonth)){
	strMonth = DateUtil.getMonthDateAdd(-1, today).substring(5,7);
	int temp = 0;
	if(Function.parseInt(strMonth) > 11) { 
		temp = Function.parseInt(strMonth) - 12;
		strMonth = Function.parseStr(temp);
	}
}

int year = cal.get(Calendar.YEAR);

int month = cal.get(Calendar.MONTH);

int date = cal.get(Calendar.DATE);

 

if(strYear != null){
  year = Function.parseInt(strYear);
  month = Function.parseInt(strMonth);
}else{
	
}

//년도/월 셋팅

cal.set(year, month, 1);

int startDay = cal.getMinimum(java.util.Calendar.DATE);
int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
int start = cal.get(java.util.Calendar.DAY_OF_WEEK);
int newLine = 0;
//오늘 날짜 저장.

Calendar todayCal = Calendar.getInstance();
SimpleDateFormat sdf = new SimpleDateFormat("yyyMMdd");
int intToday = Integer.parseInt(sdf.format(todayCal.getTime()));
//int intToday = Function.parseInt(DateUtil.getFullToday());
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
<style>
	#calender_content {position:relative;  margin-top:40px;}
	.today_btn {display:inline-block; background:#313234; color:#fff !important;  font-size:16px; padding:5px 10px; position:absolute; left:0;}
	
	.calender_nav {width:100%; margin-bottom:30px;}
	.calender_nav a {display:inline-block; font-size:15px; line-height:30px; vertical-align:middle;margin:0 10px; border:1px solid #333; width:40px;}
	.calender_nav span {display:inline-block; font-size:18px; line-height:30px; vertical-align:middle;}
	.forum_edit_btn {height:25px !important; line-height:25px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;  text-align:left;}
	.forum_edit_btn:hover {color:blue;}
	.list table tbody tr:hover{background:transparent !important;}
	.list table thead tr:hover {background:#eaeaea !important;}
	.list table.calender_con {border-left:0; border-right:0; border-top:0; border-bottom:0;}
	.list table.calender_con thead tr td {border-top:1px solid #c4c4c4; font-size:14px;}
</style>
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
		<!-- 
		<div class="search_warp">
		<form method="get" name="searchForm" id="searchForm" action="index.jsp">
			<table class="searchTable">
				<caption> 게시글검색 </caption>
				<colgroup>
					<col width="10%" />
					<col width="* "/>
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
		 -->
		<!-- //search_warp -->
		<div class="list">
			<%-- <p>전체 <strong><%=rowPageCount[0]%></strong>건 [<%=param.get("reqPageNo")%>/<%=rowPageCount[1]%>페이지]</p>--%>
			<form name="frm" id="frm" action="process.jsp" method="post">
			

	<div id="calender_content" style="width:100%; overflow:hidden;">
		<a href="index.jsp" class="today_btn">오늘</a>
		<div class="txt_c calender_nav " >
			<a href="index.jsp?syear=<%=year-1%>&amp;smonth=<%=month%>" target="_self">
				<b>&lt;&lt;</b><!-- 이전해 -->
			</a>
			<%if(month > 0 ){ %>
			<a href="index.jsp?syear=<%=year%>&amp;smonth=<%=month-1%>" target="_self">
			      <b>&lt;</b><!-- 이전달 -->			      
			</a>
			<%} else {%>
			<a href="index.jsp?syear=<%=year-1%>&amp;smonth=<%=month+11%>" target="_self">
			      <b>&lt;</b><!-- 이전달 -->			      
			</a>
			<%} %>
			&nbsp;&nbsp;
			<span>
			<%=year%>년
			<%=month+1%>월
			</span>
			
			&nbsp;&nbsp;
			
			<%if(month < 11 ){ %>			
			<a href="index.jsp?syear=<%=year%>&amp;smonth=<%=month+1%>" target="_self">
			<!-- 다음달 --><b>&gt;</b>
			</a>
			<%}else{%>
			<a href="index.jsp?syear=<%=year+1%>&amp;smonth=<%=month-11%>" target="_self">
			<!-- 다음달 --><b>&gt;</b>
			</a>
			<%} %>
			<a href="index.jsp?syear=<%=year+1%>&amp;smonth=<%=month%>" target="_self">
			<!-- 다음해 --><b>&gt;&gt;</b>
			</a>
		</div>
<!--날짜 네비게이션  -->

		<table class="calender_con" style="table-layout:fixed;">
			<colgroup>
				<col width="14.285%"/>
				<col width="14.285%"/>
				<col width="14.285%"/>
				<col width="14.285%"/>
				<col width="14.285%"/>
				<col width="14.285%"/>
				<col width="14.285%"/>
			</colgroup>
			<thead>
				<tr bgcolor="#eaeaea">
					<td><font color="red">일</font></td>
					<td>월</td>
					<td>화</td>
					<td>수</td>
					<td>목</td>
					<td>금</td>
					<td><font color="#529dbc">토</font></td>
				</tr>
			</thead>
			<tbody>
				<tr>
			
			<%
			
			//처음 빈공란 표시
			
			for(int index = 1; index < start ; index++ ){
			  out.println("<td >&nbsp;</td>");
			  newLine++;
			}
			
			
			
			for(int index = 1; index <= endDay; index++){
				
				String color = "";
				
				if(newLine == 0){
					color = "RED";
				}else if(newLine == 6){
					color = "#529dbc";
				}else{
					color = "BLACK"; 
				}
			
				String sUseDate = Integer.toString(year); 
				sUseDate += Integer.toString(month+1).length() == 1 ? "0" + Integer.toString(month+1) : Integer.toString(month+1);
				sUseDate += Integer.toString(index).length() == 1 ? "0" + Integer.toString(index) : Integer.toString(index);
				int iUseDate = Integer.parseInt(sUseDate);
				String backColor = "#fff";
				if(iUseDate == intToday ) {
				      backColor = "#aad773";
				}
				
				//현재 날짜 넣고 리스트 출력
				String snowdate = sUseDate.substring(0,4) + "-" + sUseDate.substring(4,6) + "-" + sUseDate.substring(6,8);
				param.put("snowdate", snowdate);
				ArrayList<HashMap<String, Object>> list = dao.list(param);
				int[] rowPageCount = dao.count(param);
				
				out.println("<td valign='top' align='left' height='120px' bgcolor='"+backColor+"'>");
				%>
				<b style="display:block; text-align:left; height:25px; color:<%=color%>"><%=index %></b>
				<%if(rowPageCount[0] == 0){  %>
				<%} else{
			        	HashMap<String, Object> data;
			        	for(int j = 0 ; j < list.size(); j++ ){
			        		data = list.get(j);
			    %>
			        <a href="<%=dao.getTargetURLParam("edit.jsp", param, Function.parseStr(data.get("no")))%>" class="forum_edit_btn"><%=Function.parseStr(data.get("title")) %></a>
			        	<%} %>
			    <%} %>
			    <%
			       //기능 제거 
			       out.println("</td>");
			       newLine++;
			       if(newLine == 7){
			         out.println("</tr>");
			         if(index <= endDay){
			        	 out.println("<tr>");
			         }
			         newLine=0;
			       }
			}
			//마지막 공란 LOOP
			while(newLine > 0 && newLine < 7){
			  out.println("<td>&nbsp;</td>");
			  newLine++;
			}
			if(newLine == 0){
				out.println("<td colspan='7' bgColor='#fff' style='border:0;'>&nbsp;</td>");
			}
			%>
				</tr>
			
			 
			
			</tbody>
		
		</table>

	</div>
	
				<input type="hidden" name="cmd" id="cmd" value="groupDelete"/>
				<input type="hidden" name="stype" id="stype" value="<%=param.get("stype")%>"/>
				<input type="hidden" name="sval" id="sval" value="<%=param.get("sval")%>"/>
			</form>
		</div>
		<div class="sBtn fl_l mt10">
			<!-- 
			<input type="button" value="삭제"  name=""  onclick="groupDelete();"/>
			 -->
		</div>
		<div class="pagenate btnSet clear">
		<%--
			<%=Page.indexList(Function.getIntParameter(Function.parseStr(param.get("reqPageNo"))), rowPageCount[1], request)%>
			 --%>
			<div class="right"><a href="write.jsp" class="btn">일정 등록</a></div>
		</div>
		<!-- //pagenate -->			
		<!--//btn-->
	</div>
	<!-- //contents -->
</div>
<!-- e:warp --> 
</body>
</html>