<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "/header.jsp"%>
<%@ page import="forum.*" %>
<%@ page import="property.SiteProperty" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%@ include file="config.jsp" %>
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

<style>
	.close_tooltip {position:fixed !important; right:inherit !important;}
</style>
<section id="sub" class="forum">

	<%@ include file = "/include/sub_top.jsp"%>
	<!-- sub_contents -->
    <section class="sub_contents">
        <div class="container_wrap">
            <div class="container">
                <h3 class="sub_title"><span>포럼일정</span></h3>
                <div class="calendar">
                	<a class="spr forum_icn_calendar_arrow_left" 
                		<%
                			if(month!=0) { %> 
                				href="index.jsp?syear=<%=year%>&amp;smonth=<%=month-1%>"target="_self"
               			<%} else { %> 
               					href="index.jsp?syear=<%=year-1%>&amp;smonth=<%=month+11%>"target="_self" 
               			<% } %>></a>
                    <span><strong><%=year%></strong>년 <strong><%=month+1%></strong>월</span>
                    <a class="spr forum_icn_calendar_arrow_right" 
	                   	<%
	               			if(month!=11) {%>
	               				href="index.jsp?syear=<%=year%>&amp;smonth=<%=month+1%>"target="_self"
	          				<%} else { %> 
	          					href="index.jsp?syear=<%=year+1%>&amp;smonth=<%=month-11%>"target="_self" 
	   					<% } %> ></a>
                    <div class="calendar_table_wrap">
                        <table class="calendar_table">
                            <caption>포럼 일정 관련 표</caption>
                            <thead>
                                <tr>
                                    <th scope="col" class="sunday">일</th>
                                    <th scope="col">월</th>
                                    <th scope="col">화</th>
                                    <th scope="col">수</th>
                                    <th scope="col">목</th>
                                    <th scope="col">금</th>
                                    <th scope="col" class="saturday">토</th>
                                </tr>
                            </thead>
                            <tbody>
                            <tr>
								<%
								//처음 빈공란 표시
									for(int index = 1; index < start ; index++ ){
										out.println("<td>&nbsp;</td>");
									  newLine++;
									}
									for(int index = 1; index <= endDay; index++){
										
										String color = "";
										
										if(newLine == 0){
											color = " sunday";
										}else if(newLine == 6){
											color = " saturday";
										}else{
											color = ""; 
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
										
										out.println("<td class='sch_td"+color+"'>");
										%>
										
										<i><%=index %></i>
										
										<%if(rowPageCount[0] == 0){  %>
										<%} else{
									        	HashMap<String, Object> data;
									        	for(int k = 0 ; k < list.size(); k++ ){
									        		data = list.get(k);
									    %>
									    	
									    <!-- <a href="javascript:;" class="forum_edit_btn" onclick="viewData('<%=snowdate%>' ,this);"><%=Function.parseStr(data.get("title")) %></a> -->
									    
										<p class="txt_l" style="padding:0 15px; box-sizing:border-box;"><%=Function.parseStr(data.get("title")) %></p>
									  			  <% } %>
									    <div style="display:none;">
									  	<%
									  		HashMap<String, Object> data2;
									  		for(int j = 0; j < list.size(); j ++){
									  			data2 = list.get(j);
									  	%>
										    <dl class="info2">
												 <dt><%=Function.parseStr(data2.get("title")) %></dt>
												 <dd>
													 <span>날짜 : <%=Function.parseStr(data2.get("startdate"))%> ~ <%=Function.parseStr(data2.get("enddate"))%></span>
													 <span>시각 : <%=Function.parseStr(data2.get("starttime")).substring(0, 5)%> ~ <%= Function.parseStr(data2.get("endtime")).substring(0, 5)%></span>
													 <span>장소 : <%=Function.parseStr(data2.get("place"))%></span>
												 </dd>
											 </dl>
								
									    
									   		<%} %>
									   		</div>
									    <%} %> <!-- rowPageCountEnd -->
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
									}
								%>
								</tr>
								<%--
								<tr>
									 <td class="sunday"></td>
									 <td></td>
									 <td><i>1</i></td>
									 <td><i>2</i></td>
									 <td><i>3</i></td>
									 <td class="scheduled"><i>4</i>
										 <span>·기술정책분과 제2회</span>
										 <dl class="scheduled_tooltip">
											 <dt>sdn/nfv포럼 20년 제2회 분과장회의</dt>
											 <dd>
												 <span>날짜 : 6월 14일 수요일</span>
												 <span>시각 : 16:00~18:00</span>
												 <span>장소: 서울역 5층 KTX6 회의실</span>
											 </dd>
										 </dl>
									 </td> 
									 <td class="saturday"><i>5</i></td>
								</tr>
								 --%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </section>
</section>
<!-- 팝업 -->


<div class="cal_pop">
	<a href="javascript:;" class="cal_close"><img src="/img/img/close_ico.png"></a>
	<div class="info2"></div>
</div>

<a href="javascript:;" class="close_tooltip"></a>
<%@ include file = "/footer.jsp"%>