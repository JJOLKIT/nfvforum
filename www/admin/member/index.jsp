<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="member.*" %>
<%@ page import="property.SiteProperty" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%@ include file="config.jsp" %>
<%@ include file="/admin/include/logingCheck.jsp" %>
<%
	HashMap<String, Object> param = new HashMap();
	param = BeanUtils.bindHashMap(request, param, pageRows);
	MemberDAO dao = MemberDAO.getInstance();
	
	ArrayList<HashMap<String, Object>> list = dao.list(param);
	int[] rowPageCount = dao.count(param);
	
	String today = DateUtil.getToday();
	String oneMonth = DateUtil.getMonthDateAdd(-1, today);
	String twoMonth = DateUtil.getMonthDateAdd(-2, today);
	String threeMonth = DateUtil.getMonthDateAdd(-3, today);
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

//달력부분
$(window).load(function() {
	initCal({id:"sstartdate",type:"day",today:"y"});			
	initCal({id:"senddate",type:"day",today:"y"});
	
	$("input[type=text][name*=sval]").keypress(function(e){
		if(e.keyCode == 13){
			goSearch();
		}
	});
	
});

function goExcel(){
	$('.processbg').stop().fadeIn(100);
	
	$.ajax({
		url:'excelProcess.jsp',
		data : {
			'cmd' : 'excel',
			'sgrade' : '<%=Function.parseStr(param.get("sgrade"))%>',
			'stype' : '<%=Function.parseStr(param.get("stype"))%>',
			'sval' : encodeURIComponent('<%=Function.parseStr(param.get("sval"))%>'),
			
		},
		success : function(data){
			var r = data.trim();
			console.log(r);
			if(r == "error"){
				alert('잘못된 접근입니다.');
			}else if(r == "fail"){
				alert('요청처리 중 장애가 발생했습니다.');
			}else{
				if(r.indexOf(".xlsx") > 0){
					window.open("/include/download.jsp?path=<%=uploadPath%>&af="+r+"&vf="+r, '_blank');
					$('.processbg').stop().fadeOut(100);
				}
			}
		}
		
	});
	
	//location.href='excelProcess.jsp?cmd=excel&sgrade=<%=Function.parseStr(param.get("sgrade"))%>&stype=<%=Function.parseStr(param.get("stype"))%>&sval='+encodeURIComponent("<%=Function.parseStr(param.get("sval"))%>")+'';
	//window.open('excelProcess.jsp?cmd=excel&sgrade=<%=Function.parseStr(param.get("sgrade"))%>&stype=<%=Function.parseStr(param.get("stype"))%>&sval='+encodeURIComponent("<%=Function.parseStr(param.get("sval"))%>"), '_blank');
}
</script>
<style>
	.processbg {display:none; position:absolute; left:0; top:0; width:100%; height:100%; background:rgba(3,3,3,.25); z-index:10;}
	.processbg p {display:table; width:100%; height:100%; }
	.processbg p span {display:table-cell; text-align:center; vertical-align:middle; font-size:20px; font-weight:bold; color:#fff;}
</style>
</head>
<body> 
<%@ include file="/admin/include/common.jsp" %>
<!-- S T A R T :: headerArea-->
<%@ include file="/admin/include/header.jsp" %>
<!-- E N D :: headerArea--> 
<!-- s:warp -->
<div class="processbg">
		<p><span>파일 생성 중입니다...잠시만 기다려 주세요</span></p>
	</div>

<div id="warp">
	
	<div class="contents">
		<h2 class="fl_l"><%=pageTitle%></h2>
		
		<div class="search_warp">
		<form method="get" name="searchForm" id="searchForm" action="index.jsp">
			<table class="searchTable">
				<caption> 게시글검색 </caption>
				<colgroup>
					<col width="10%"/>
					<col width="30%"/>
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="20%" />
					<col width="*" />
				</colgroup>
				<tbody>
					<tr>
						<th class="bno">회원구분</th>
						<td class="bno">
							<select name="sgrade" id="sgrade" onchange="goSearch();" style="width:200px;">
								<%=CodeUtil.getMemberGradeOption(param.get("sgrade")) %>
							</select>
						</td>
						<th class="bno">회원상태</th>
						<td class="bno">
							<select name="ssecession" id="ssecession" title="검색을 선택해주세요">
								<option value="all" <%=Function.getSelected(Function.parseStr(param.get("ssecession")), "all") %>>전체</option>
								<option value="0" <%=Function.getSelected(Function.parseStr(param.get("ssecession")), "0") %>>회원</option>
								<option value="1" <%=Function.getSelected(Function.parseStr(param.get("ssecession")), "1") %>>탈퇴신청</option>
							</select>	
						</td>
						<td></td>
						<td><span class="fl_r" ><input type="button" value="엑셀 다운로드(<%=Function.parseInt(rowPageCount[0]) %>건)" onclick="goExcel();"/></span>	</td>
					</tr>
					<tr>
						<th class="bno">날짜</th>
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
							<input type="button" name="" value="1M" class="" onClick="searchDate('<%=oneMonth%>','<%=today%>');"/>
							<input type="button" name="" value="2M" class="" onClick="searchDate('<%=twoMonth%>','<%=today%>');"/>
							<input type="button" name="" value="3M" class="" onClick="searchDate('<%=threeMonth%>','<%=today%>');"/>
						</td>
						<th class="bno">검색어</th>
						<td class="bno">
							<select name="stype" id="stype" title="검색을 선택해주세요">
								<option value="all" <%=Function.getSelected(Function.parseStr(param.get("stype")), "all") %>>전체</option>
								<option value="id" <%=Function.getSelected(Function.parseStr(param.get("stype")), "id") %>>회원ID</option>
								<option value="name" <%=Function.getSelected(Function.parseStr(param.get("stype")), "name") %>>이름</option>
								<option value="cell" <%=Function.getSelected(Function.parseStr(param.get("stype")), "cell") %>>휴대폰번호</option>
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
					<col width="100px" />
					<col width="120px"/>
					<col width="*" />
					<col width="9%" />
					<col width="9%" />
					<col width="9%" />
					<col width="12%" />
					<col width="15%" />
					<col width="12%" />
					<col width="8%"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col"><input type="checkbox" name="allChk" id="allChk" onClick="check(this, document.frm.no)"/></th>
						<th scope="col">번호</th>
						<th scope="col">구분</th>
						<th scope="col">ID</th>
						<th scope="col">이름</th>
						<th scope="col">소속</th>
						<th scope="col">직위</th>
						<th scope="col">휴대폰</th>
						<th scope="col">이메일</th>
						
						<th scope="col">가입일</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
				<% if (rowPageCount[0] == 0) { %>
					<tr>
						<td class="first" colspan="11">등록된 회원이 없습니다.</td>
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
						<td <%=targetUrl%>><%=rowPageCount[0] - (Function.getIntParameter(Function.parseStr(param.get("reqPageNo")))-1)*pageRows - i%></td>
						<td <%=targetUrl %>><%=CodeUtil.getMemberGradeName(Function.parseInt(data.get("grade"))) %></td>
						<td <%=targetUrl%>><%=Function.parseStr(data.get("id")) %></td>
						<td <%=targetUrl%>><%=Function.parseStr(data.get("name")) %></td>
						<td <%=targetUrl %>><%=Function.parseStr(data.get("division")) %></td>
						<td <%=targetUrl %>><%=Function.parseStr(data.get("position")) %></td>
						<td <%=targetUrl %>><%=Function.parseStr(data.get("cell"))%></td>
						<td <%=targetUrl %>><%=Function.parseStr(data.get("email"))%></td>
						<td <%=targetUrl%>><%=Function.parseDateTime(data.get("registdate"))%></td>
						<td <%=targetUrl %>><%if("1".equals(data.get("secession"))){ %><font color='red'>탈퇴</font><%}else{ %>일반<%} %></td>
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
			 <div class="right"><a href="write.jsp" class="btn">회원등록</a></div> 
		</div>
		<!-- //pagenate -->			
		<!--//btn-->
	</div>
	<!-- //contents -->
</div>
<!-- e:warp --> 
</body>
</html>