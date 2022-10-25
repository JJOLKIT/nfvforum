<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "/header.jsp"%>
<%@ page import="board.gallery.*" %>
<%@ page import="board.notice.*" %>
<%@ page import="forum.*" %>
<%@ page import="board.media.*" %>
<%@ page import="property.SiteProperty" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>
<%@page import="java.text.SimpleDateFormat"%>

<%@ include file = "/include/popup/mainPop.jsp" %>
<%@ include file ="config.jsp" %>

<%
	HashMap<String, Object> param = new HashMap();
	HashMap<String, Object> param2 = new HashMap();
	HashMap<String, Object> param3 = new HashMap();
		
	param = BeanUtils.bindHashMap(request, param, pageRows);	
	param2 = BeanUtils.bindHashMap(request, param2, pageRowsS);
	param3 = BeanUtils.bindHashMap(request, param3, pageRowsG);
	
	GalleryDAO daoG = GalleryDAO.getInstance();
	NoticeDAO daoN = NoticeDAO.getInstance();
	ForumDAO daoF = ForumDAO.getInstance();
	
	param3.put("sdisplay","1");
	ArrayList<HashMap<String, Object>> listG = daoG.list(param3);
	
	param.put("smain","1");
	ArrayList<HashMap<String, Object>> listN = daoN.list(param);
	
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
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	SimpleDateFormat ddf = new SimpleDateFormat("yyMMMdd", new Locale("en", "US"));
	
	
	int intToday = Integer.parseInt(sdf.format(todayCal.getTime()));
	//int intToday = Function.parseInt(DateUtil.getFullToday());
	
	ArrayList<HashMap<String, Object>> listF = daoF.list(param2);

	int[] rowPageCount = daoG.count(param);
	int[] rowPageCount2 = daoF.count(param2);
	
	
%>

<script>
	$(function(){
		$('.schedule_list .scheduled').on('click',function(){
			if($(this).find('dl.frData').length > 0){
				var frInfo = $(this).find('dl.frData').clone();
				$('.schedule_pop .info').html( frInfo );
				$('.schedule_pop').stop().fadeIn(400);		
			}
			/* $('.schedule_pop').stop().fadeIn(400); */
		});

		$('.cal_close').on('click',function(){
			$(this).parent().stop().fadeOut(400);
		});
	});
	popPosition();
	function popPosition(){
		var boxHeight = $('.schedule_pop').outerHeight();
		var boxPosition = Number ('-'+ boxHeight / 2 ) + 'px';
		$('.schedule_pop').css('margin-top',boxPosition);	
	}
</script>

<!-- main -->
<main id="main">
	<!-- visual_wrap -->
	<div class="visual_wrap owl-carousel">
		<div class="img_wrap">
			<div class="text_wrap">
				<p class="img_text">SDN/NFV</p>
				<span class="img_desc">Software Defined Networks, <br/> Network Functions Virtualization</span>
			</div>
			<img src="/img/visual04.jpg" alt="main visual" class="only-pc">
			<img src="/img/visual04_mo.jpg" alt="main visual" class="only-m">
		</div>
		<div class="img_wrap">
			<div class="text_wrap">
				<p class="img_text">SDN/NFV</p>
				<span class="img_desc">Software Defined Networks, <br/> Network Functions Virtualization</span>
			</div>
			<img src="/img/visual05.jpg" alt="main visual" class="only-pc">
			<img src="/img/visual05_mo.jpg" alt="main visual" class="only-m">
		</div>
		<!-- <div class="img_wrap">
			<div class="text_wrap">
				<p class="img_text">SDN/NFV</p>
				<span class="img_desc">Software Defined Networks, <br/> Network Functions Virtualization</span>
			</div>
			<img src="/img/visual_03.jpg" alt="main visual" class="only-pc">
			<img src="/img/m_visual_01.jpg" alt="main visual" class="only-m">
		</div> -->
	</div>
	<!-- icon_menu -->
	<ul class="container icon_menu">
		<li>
			<a href="/about/">
				<i class="spr icn_01"></i>
				<span>Forum Introduction</span>
				<em>포럼 소개</em>
			</a>
		</li>
		<li>
			<a href="/member/">
				<i class="spr icn_02"></i>
				<span>Membership Status</span>
				<em>회원 현황</em>
			</a>
		</li>
		<li>
			<a href="/about/committee.jsp">
				<i class="spr icn_03"></i>
				<span>Forum committee</span>
				<em>포럼 위원회</em>
			</a>
		</li>
		<li>
			<a href="/notice/notice/">
				<i class="spr icn_04"></i>
				<span>Notice</span>
				<em>공지사항</em>
			</a>
		</li>
	</ul>
	<!-- photo_gallery -->
	<section class="container_wrap main_gallery">
		<h2 class="main_title container">
			<i class="spr icn_heading"></i>Photo Gallery
			<a href="/notice/gallery/" class="main_more"><span>MORE</span><i class="spr icn_more"></i></a>
		</h2>
		
		<div class="owl-carousel main_photo container">
		<% if (rowPageCount[0] == 0) { %>
			<div class="slides">
				<a href="">
					<span class="dimmed">
						<span>
							<em>내용 없음</em>
							<span>내용 없음</span>
						</span>
					</span>
					<img src="" alt="">
				</a>
			</div>
		<% } else { %>			
		<%
			String targetUrl = "";
			String topClass = "";
			HashMap<String, Object> data;
			
			for (int i=0; i<listG.size(); i++) {
				data = listG.get(i);
				targetUrl = "style='cursor:pointer;' onclick=\"location.href='"+daoG.getTargetURLParam("/notice/gallery/view.jsp", param, Function.parseStr(data.get("no")))+"'\"";
			%>
			<div class="slides" >
					<!-- src - 큰 원본 이미지
					title - 사진 제목
					data-date - 날짜 -->
				<a class='aUrl' href="javascript:;" <%-- href="<%=daoG.getTargetURLParam("/notice/gallery/view.jsp", param, Function.parseStr(data.get("no")))%>" --%>>
					<span class="dimmed">
						<span>
							<em><%=data.get("title") %></em>
							<span><%=Function.getHtmlRemoveTextReSize(data.get("contents"),50) %></span>
						</span>
					</span>
					<%if(data.get("filename") != null && !"".equals(Function.parseStr(data.get("filename")))){%>
					<p style="background-image:url('<%=uploadPathG+data.get("filename")%>'); background-repeat: no-repeat; background-size: cover; background-position: center center;" data-src="<%=uploadPathG+data.get("filename")%>" data-date="<%=Function.parseDate(data.get("registdate"))%>" class="pic">
						<img src="/img/no_image.gif" alt="" style="opacity:0; visibility:hidden; width:100%; height:auto; ">
					</p>
					<%} else{%>
					<p style="background-image:url('/img/no_image.gif'); background-repeat: no-repeat; background-size: cover; background-position: center center;" class="">
						<img src="/img/no_image.gif" alt="" style="opacity:0; visibility:hidden; width:100%; height:auto; ">
					</p>
					<%} %>
				</a>
			</div>
		<%
				}
			 }
		%>
		</div>
	</section>
	<!-- notice -->
	<section class="container_wrap main_notice">
		<h2 class="main_title container">
			<i class="spr icn_heading"></i>Notice
			<a href="/notice/notice/" class="main_more"><span>MORE</span><i class="spr icn_more"></i></a>
		</h2>
		<div class="container">
			<table class="main_table">
				<caption>공지사항 리스트 5줄</caption>
				<colgroup>
					<col class="col_title">
					<col class="col_date">
				</colgroup>
				<tbody>
					<% if (rowPageCount[0] == 0) { %>
					<tr>
						<td class="td_title">
							<span class="td_tit">등록된 공지글이 없습니다</span>
						</td>
						<td class="td_date">등록된 공지글이 없습니다</td>
					</tr>
					<%}else { %>
                	<%
					String targetUrl = "";
					String topClass = "";
					HashMap<String, Object> data;
					
					/*newicon*/
					java.text.SimpleDateFormat sf = new java.text.SimpleDateFormat("yyyy-MM-dd");
					String now = sf.format(new java.util.Date());
					
					for (int i=0; i<listN.size(); i++) {
						data = listN.get(i);
						targetUrl = "style='cursor:pointer;' onclick=\"location.href='"+daoN.getTargetURLParam("/notice/notice/view.jsp", param, Function.parseStr(data.get("no")))+"'\"";
					%>
					<tr <%=targetUrl %> >
						<td class="td_title">
							<span class="td_tit"><%=data.get("title") %></span>
							<% String inputDate = sf.format(data.get("registdate"));
							   if(inputDate.equals(now)){
							 %>
							    <img src="/img/ico_new.png" class="ico_new" alt="새글" />
							<%} %>
						</td>
				
						<td class="td_date"><%=Function.parseDate(data.get("registdate")) %></td>
					</tr>
					<%
						}
					} 
					%>
					<!-- <tr>
						<td class="td_title">
							<span class="td_tit">5G 인프라 장비 시험검증 사업설명회 (성남권_오후) 5G 인프라 장비 시험검증 사업설명회 (성남권_오후) 5G 인프라 장비 시험검증 사업설명회 (성남권_오후) 5G 인프라 장비 시험검증 사업설명회 (성남권_오후) 5G 인프라 장비 시험검증 사업설명회 (성남권_오후) 5G 인프라 장비 시험검증 사업설명회 (성남권_오후) 5G 인프라 장비 시험검증 사업설명회 (성남권_오후) 5G 인프라 장비 시험검증 사업설명회 (성남권_오후) 5G 인프라 장비 시험검증 사업설명회 (성남권_오후) 5G 인프라 장비 시험검증 사업설명회 (성남권_오후) 5G 인프라 장비 시험검증 사업설명회 (성남권_오후) 5G 인프라 장비 시험검증 사업설명회 (성남권_오후) 5G 인프라 장비 시험검증 사업설명회 (성남권_오후)</span>
							<span class="label_new">NEW</span>
						</td>
						<td class="td_date">20.08.20</td>
					</tr> -->
					
				</tbody>
			</table>
		</div>
	</section>
	<!-- Forum Schedule -->
	<section class="container_wrap main_schedule">
		<h2 class="main_title container">
			<i class="spr icn_heading"></i>Forum Schedule
			<a href="/notice/forum/" class="main_more"><span>MORE</span><i class="spr icn_more"></i></a>
		</h2>
		<ul class="container schedule_list">
			<% if (rowPageCount[0] == 0) { %>
			<li class="no_schedule"><span>등록된 일정이 없습니다.</span></li>
			<%} else { %>
			<%
				String targetUrl = "";
				String topClass = "";
				HashMap<String, Object> data;
				for (int i=0; i<listF.size(); i++) {
					data = listF.get(i);
					targetUrl = "style='cursor:pointer;' onclick=\"location.href='"+daoF.getTargetURLParam("/notice/notice/view.jsp", param, Function.parseStr(data.get("no")))+"'\"";
			%>
			<li class="scheduled">
				<div>
					<span class="scheduled_day">
						<em><%=Function.parseStr(data.get("startdate")).substring(Function.parseStr(data.get("startdate")).length()-2, Function.parseStr(data.get("startdate")).length())%></em>
						<span><%=ddf.format(data.get("startdate")).substring(2,ddf.format(data.get("startdate")).length()-2)%>.<%=ddf.format(data.get("startdate")).substring(0,2)%></span>
						<!-- <em><%=Function.parseStr(data.get("startdate")).substring(Function.parseStr(data.get("startdate")).length()-2, Function.parseStr(data.get("startdate")).length())%></em>
						<span><%=Function.parseStr(data.get("startdate")).substring(0, Function.parseStr(data.get("startdate")).length()-3)%></span> -->
					</span>
					<span class="scheduled_title_wrap">
						<span class="scheduled_title">
							<%=Function.parseStr(data.get("title")) %>
						</span>
						<span class="scheduled_place"><%=Function.parseStr(data.get("place"))%></span>
						<span class="scheduled_date"><%=Function.parseStr(data.get("starttime")).substring(0, 5)%> ~ <%= Function.parseStr(data.get("endtime")).substring(0, 5)%></span>
					</span>
				</div>
				<div style='display:none;'>
					<dl class="frData">
						<dt><%=Function.parseStr(data.get("title")) %></dt>
						<dd>
							<span>날짜 : <%=Function.parseStr(data.get("startdate"))%> ~ <%=Function.parseStr(data.get("enddate"))%></span>
							<span>시각 : <%=Function.parseStr(data.get("starttime")).substring(0,5)%> ~ <%= Function.parseStr(data.get("endtime")).substring(0, 5)%></span>
							<span>장소 : <%=Function.parseStr(data.get("place"))%></span>
						</dd>
					</dl>
				</div>
			</li>
			<%
				}
			}
			%>
		</ul>
	</section>
	<!-- Member -->
	<section class="container_wrap main_member">
		<h2 class="main_title container">
			<i class="spr icn_heading"></i>Member
			<a href="/member/" class="main_more"><span>MORE</span><i class="spr icn_more"></i></a>
		</h2>
		<ul class="container member_carousel owl-carousel">
			<li>
				<a href="https://www.ahnlab.com/kr/site/main.do" target="_blank"><em><i class="spr spr_com_ahnlab"></i></em><span class="blind">ahnlab</span></a>
				<a href="http://www.atto-research.com" target="_blank"><em><i class="spr spr_com_atto"></i></em><span class="blind">atto research</span></a>
			</li>
			<li>
				<a href="http://www.coweaver.co.kr/ko/" target="_blank"><em><i class="spr spr_com_cowever"></i></em><span class="blind">cowever</span></a>
				<a href="http://www.dasannetworks.com/kr/" target="_blank"><em><i class="spr spr_com_dasan"></i></em><span class="blind">dasan</span></a>
			</li>
			<!--<li>
				<a href="https://www.edge-core.com/index.php" target="_blank"><em><i class="spr spr_com_edge"></i></em><span class="blind">edge core</span></a>
                <a href="https://www.sktelecom.com/index.html" target="_blank"><em><i class="spr spr_com_sk"></i></em><span class="blind">sk telecom</span></a>
			</li>-->
			<li>
				<a href="https://www.etri.re.kr/kor/main/main.etri" target="_blank"><em><i class="spr spr_com_etri"></i></em><span class="blind">etri(한국전자통신연구원)</span></a>
				<a href="http://www.genietec.com/" target="_blank"><em><i class="spr spr_com_geni"></i></em><span class="blind">genietech</span></a>
			</li>			
			<li>
				<a href="https://www.iitp.kr/main.it" target="_blank"><em><i class="spr spr_com_iiip"></i></em><span class="blind">iiip(정보통신기술진흥센터)</span></a>
				<a href="https://www.kisa.or.kr/main.jsp" target="_blank"><em><i class="spr spr_com_kisa"></i></em><span class="blind">kisa(한국인터넷진흥원)</span></a>
			</li>
			<li>
				<a href="https://www.kisti.re.kr/" target="_blank"><em><i class="spr spr_com_kisti"></i></em><span class="blind">kisti(한국과학기술정보연구원)</span></a>
				<a href="https://www.kt.com/" target="_blank"><em><i class="spr spr_com_kt"></i></em><span class="blind">kt</span></a>
			</li>
			<li>
				<a href="http://www.uplus.co.kr/home/Index.hpi" target="_blank"><em><i class="spr spr_com_lg"></i></em><span class="blind">lg</span></a>
				<a href="http://www.mobigen.com/" target="_blank"><em><i class="spr spr_com_mobi"></i></em><span class="blind">mobigen</span></a>
			</li>
			<li>
				<a href="http://www.netvisiontel.com/nv/work/index.html" target="_blank"><em><i class="spr spr_com_net"></i></em><span class="blind">netvision</span></a>
				<a href="https://www.nia.or.kr/site/nia_kor/main.do" target="_blank"><em><i class="spr spr_com_nia"></i></em><span class="blind">nia(한국정보화진흥원)</span></a>
			</li>
			<li>
				<a href="http://www.postech.ac.kr/" target="_blank"><em><i class="spr spr_com_postech"></i></em><span class="blind">postech</span></a>
				<a href="https://www.samsung.com/global/business/networks/ " target="_blank"><em><i class="spr spr_com_samsung"></i></em><span class="blind">samsung</span></a>
			</li>
			<li>
				<a href="http://telefield.com/" target="_blank"><em><i class="spr spr_com_tele"></i></em><span class="blind">telefield</span></a>
				<a href="http://www.eluon.com/" target="_blank"><em><i class="spr spr_com_eluon"></i></em><span class="blind">eluon</span></a>
			</li>
			<!-- <li>
				<a href="https://www.gist.ac.kr/kr/event_2st/index.html" target="_blank"><em><i class="spr spr_com_gwang"></i></em><span class="blind">광주과학기술원</span></a>
				<a href="https://www.hfrnet.com/front/main/mainPage" target="_blank"><em><i class="spr spr_com_hfr"></i></em><span class="blind">hfr.inc</span></a>
			</li> -->
			<!--<li>
				<span><em><i class="spr spr_com_ubi"></i></em><span class="blind">ubiquoss</span></span>
				<span><em><i class="spr spr_com_uni_gwang"></i></em><span class="blind">광운대학교</span></span>
			</li>
			<li>
				<span><em><i class="spr spr_com_uni_kaist"></i></em><span class="blind">카이스트</span></span>
				<span><em><i class="spr spr_com_uni_korea"></i></em><span class="blind">고려대학교</span></span>
			</li>
			<li>
				<span><em><i class="spr spr_com_uni_kyungbuk"></i></em><span class="blind">경북대학교</span></span>
				<span><em><i class="spr spr_com_uni_kyunghee"></i></em><span class="blind">경희대학교</span></span>
			</li>
			<li>
				<span><em><i class="spr spr_com_uni_seoul"></i></em><span class="blind">서울대학교</span></span>
				<span><em><i class="spr spr_com_uni_soong"></i></em><span class="blind">숭실대학교</span></span>
			</li>
			<li>
				<span><em><i class="spr spr_com_uni_sung"></i></em><span class="blind">성균관대학교</span></span>
				<span><em><i class="spr spr_com_uni_yonsei"></i></em><span class="blind">연세대학교</span></span>
			</li>-->
		</ul>
	</section>
</main>

<div class="gal_pop">
	<div class="size tb">
		<div class="tbc">
			<div class="inner">
				<a href="javascript:;" class="gal_close"><img src="/img/img/close_ico.png"></a>
				<div class="img">
					<!--
					<a href="<%-- <%=daoG.getTargetURLParam("/notice/gallery/view.jsp", param, Function.parseStr(data.get("no")))%> --%>">
					-->
						<p style="background-image:url('');" class="back_img pic">
							<img src="/img/no_image.gif" alt="" style="opacity:0; visibility:hidden; width:100%; height:auto; ">
						</p>
					<!--
					</a>
					-->
				</div>
				<div class="txt">
					<b>타이틀</b>
					<span>날짜</span>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 팝업 -->
<div class="schedule_pop">
	<a href="javascript:;" class="cal_close"><img src="/img/img/close_ico.png"></a>
	<div class="info">		
		<!-- <dl>
			<dt>ONK 2019 Fall</dt>
			<dd>
				<span>날짜 : 2020-11-04 ~ 2020-11-04</span>
				<span>시각 : 13:00:00 ~ 19:00:00</span>
				<span>장소 : ㄴㄴㄴㄴㄴㄴㄴ</span>
			</dd>
		</dl>
		<dl>
			<dt>ONK 2019 Fall</dt>
			<dd>
				<span>날짜 : 2020-11-04 ~ 2020-11-04</span>
				<span>시각 : 13:00:00 ~ 19:00:00</span>
				<span>장소 : ㄴㄴㄴㄴㄴㄴㄴ</span>
			</dd>
		</dl> -->
	</div>
</div>

<!-- <div class="gal_pop">
	<div class="size tb">
		<div class="tbc">
			<div class="inner">
				<a href="javascript:;" class="gal_close"><img src="/img/img/close_ico.png"></a>
				<div class="img">
					<p >
						<img src="/img/img/gal_pop.jpg">
					</p>
				</div>
				<div class="txt">
					<b>sdn/nfv 포럼 제 8회 정기총회</b>
					<span>20.05.27</span>
				</div>
			</div>
		</div>
	</div>
</div> -->

<%@ include file = "/footer.jsp"%>