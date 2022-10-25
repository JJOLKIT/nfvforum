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
	PopupDAO popdao = PopupDAO.getInstance();
	
	String nowDate = Function.parseDate(DateUtil.getFullToday());
	
	pop_param.put("sstartdate", nowDate);
	pop_param.put("senddate", nowDate);
	pop_param.put("sdisplay", "1");
	
	int[] pop_rowPageCount = popdao.count(pop_param);
	ArrayList<HashMap<String, Object>> poplist = popdao.list(pop_param);
	
	
%>

<script type="text/javascript">
 // 쿠키 설정

  function setCookie(name, value, expire){
    var todayDate = new Date();
    todayDate.setDate( todayDate.getDate() + expire );
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
  }

  // 일반 닫기
  function closePop(Popname){
    document.getElementById(Popname).style.display = 'none';
  }

  //오늘 하루 열지 않기
  function todayClosePop(Popname, PopNum){
    setCookie( PopNum , "done", 1 );
    document.getElementById(Popname).style.display = 'none';
  }

  function getCookie(CookieName,PopName){
    CookieData = document.cookie;
    if( CookieData.indexOf(CookieName+"=done") < 0 ){
      console.log(CookieName + ' : false');
      document.getElementById(PopName).style.display = 'block';
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

<style>
	#Pop1, #Pop2, #Pop3, #Pop4, #Pop5, #MainPop{width:100%;}
   #MainPop {left : 100px; top: 100px ;max-width:500px; width:100%; z-index:105; }
  .Pop_layer {position:absolute; border-color:#333; z-index:900; left:10%; top:10%; }
  .Pop_layer .Pop_wrap {width:100%; margin:0 auto; position:relative;}
  .Pop_layer .Pop_wrap iframe, .Pop_layer .Pop_wrap embed {width:100%; height:100%; position:absolute; left:0; top:0;}
  .Pop_layer .Pop_wrap a {display:block; width:100%;}
  .Pop_layer img {width:100%; display:block;}
  .Pop_layer .Pop_btn {overflow:hidden; width:100%; background:#333; line-height:25px; box-sizing:border-box; padding:0 5px;}
  .Pop_layer .Pop_btn a{display:block; color:#fff; float:left; width:auto;}
  .Pop_layer .Pop_btn a:last-child {float:right;}
  @media(max-width:768px){
	/*#MainPop {left:0; top:5%; max-width:100%;}*/
    .Pop_layer .Pop_wrap {width:90%; margin:0 auto; text-align:center;}
    .Pop_layer {left:0% !important; top:10% !important; }
  }
</style>
	<%
		int j = 99; 
		HashMap<String,Object> popdata;
		for(int i = 0; i < poplist.size(); i ++){
			
			popdata = poplist.get(i);
	%>

		 <div id="MainPop<%=i %>" class="Pop_layer" style="left:<%=Function.parseInt(popdata.get("leftpx"))%>px; top:<%=Function.parseInt(popdata.get("toppx"))%>px;">
		  <div class="Pop_wrap">
		    <a href="<%=Function.parseStr(popdata.get("relation_url")) %>" target="_blank" title="새 창 열림">
		      <img src="<%=pop_uploadPath+popdata.get("filename")%>"/>
		    </a>
		    <div class="Pop_btn">
		      <!-- todayClosePop ('팝업 Id명', '쿠키 이름'); -->
		      <a href="javascript:;" onclick="todayClosePop('MainPop<%=i %>','ncookie<%=popdata.get("no")%>');">오늘 하루 열지 않기</a>
		      <a href="javascript:;" onclick="closePop('MainPop<%=i%>');">닫기</a>
		    </div>
		  </div>
		</div>

	<script>getCookie('ncookie<%=popdata.get("no")%>', 'MainPop<%=i%>');</script>
	<%j--;} %>

<!-- 팝업 끝 -->
