<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.popup.*" %>
<%@ page import="property.SiteProperty" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%
	String pop_pageTitle = "팝업";
	String pop_tablename = "popup";
	int pop_pageRows	 = 4;
	String pop_uploadPath	 = "/upload/popup/";					// 파일, 동영상 첨부 경로
	
	int	pop_maxSaveSize	 = 50*1024*1024;							// 50Mb

	HashMap<String, Object> pop_param = new HashMap();
	pop_param = BeanUtils.bindHashMap(request, pop_param, pop_pageRows);
	PopupDAO pdao = PopupDAO.getInstance();
	
	String nowDate = Function.parseDate(DateUtil.getFullToday());
	
	
	pop_param.put("sstartdate", nowDate);
	pop_param.put("senddate", nowDate);
	pop_param.put("sdisplay", "0");
	
	pop_param.put("slang", "KR");
	int[] pop_rowPageCount = pdao.count(pop_param);
	ArrayList<HashMap<String, Object>> poplist = pdao.list(pop_param);
	
	
%>

<script>


//쿠키 설정
	function setCookie(name, value, expire){
		var todayDate = new Date();
		todayDate.setDate( todayDate.getDate() + expire );
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	}
	//오늘 하루 열지 않기
	function todayClosePop(Popname, PopNum){
		setCookie( PopNum , "done", 1 );
		document.getElementById(Popname).style.display = 'none';

		var none = $('.Pop_layer').length;
		var noneLen = 0;
		if(noneLen == none){
			$('.pop_wrapper').stop().fadeOut(400);
		}
		for(i = 0; i < none; i++){
			if($('.Pop_layer').eq(i).css('display') == "none"){
				noneLen ++;
			}
		}
		console.log(noneLen);
		if(noneLen == none){
			$('.pop_wrapper').stop().fadeOut(400);
		}
	}
	
	function getCookie(CookieName,PopName){
		CookieData = document.cookie;
		if( CookieData.indexOf(CookieName+"=done") < 0 ){
			 console.log(CookieName + ' : false');
			 document.getElementById(PopName).style.display = 'inline-block';
			 document.getElementById('pop_wrapper').style.display = 'block';

		}else{
			 console.log(CookieName + ' : true');
			 document.getElementById(PopName).style.display = 'none';
			
		}
	}

    
</script>

<%
	String popClass = "";
	if(pop_rowPageCount[0] > 3){
		popClass = "pop_style2";
	}else{
		popClass = "pop_style1";
	}
%>
<div class="pop_wrapper <%=popClass%>" id="pop_wrapper">
<!-- 팝업 시작 -->
	<div class="pop_size">
		
		
		<%
			int j = 100; 
			HashMap<String,Object> popdata;
			for(int i = 0; i < poplist.size(); i ++){
				
				popdata = poplist.get(i);
		%>
		<div id="MainPop<%=i %>" class="Pop_layer" style="z-index:<%=j%>">
		
		  <div class="Pop_wrap">
			<div class="pop_title">
				<p><span><%=popdata.get("TITLE")%></span></p>
			</div>
			<div class="pop_info">
				<div class="wrap">
					<%=Function.parseStr(popdata.get("CONTENTS")).replaceAll("\r\n", "<br/>") %>
					<%
					if(!"".equals(Function.parseStr(popdata.get("RELATION_URL")))){
				%>
				<div class="view"><a href="<%=Function.parseStr(popdata.get("RELATION_URL"))%>">View</a></div>
				<%} %>
				</div>
				
				
			</div>
			<div class="Pop_btn clear">
			  <!-- todayClosePop ('팝업 Id명', '쿠키 이름'); -->
			  <p class="closeChk">
					<input type="checkbox" name="chkbox" id="chkbox<%=i %>"  onClick="todayClosePop('MainPop<%=i %>', 'ncookie<%=popdata.get("NO")%>');">
					<label for="chkbox<%=i%>">오늘 하루 다시 열지 않음</label>
				</p>  
			  <a href="javascript:;" onclick="closePop('MainPop<%=i%>');"></a>
			</div>
		  </div>
		</div>
		
		
		<script>getCookie('ncookie<%=popdata.get("NO")%>', 'MainPop<%=i%>');</script>
		<%j--;} %>
	
		
	</div>
</div>

<!-- 팝업 끝 -->
