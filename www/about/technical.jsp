<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "/header.jsp"%>

<%@ page import="committee.*" %>
<%@ page import="property.SiteProperty" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>

<%@ include file="config.jsp" %>

<%
	HashMap<String, Object> param = new HashMap();
	param = BeanUtils.bindHashMap(request, param, pageRows);
	CommitteeDAO dao = CommitteeDAO.getInstance();
	
	param.put("scategory","2");
	ArrayList<HashMap<String, Object>> list = dao.list(param);
	int[] rowPageCount = dao.count(param);
	
	/* String today = DateUtil.getToday();
	String yesterday = DateUtil.getDayDateAdd(-1, today);
	String oneweek = DateUtil.getDayDateAdd(-7, today);
	String onemonth = DateUtil.getMonthDateAdd(-1, today);
	String twomonth = DateUtil.getMonthDateAdd(-2, today);
	String threemonth = DateUtil.getMonthDateAdd(-3, today); */
%>
<section id="sub" class="technical">

	<%@ include file = "/include/sub_top.jsp"%>

	<!-- sub_contents -->
    <section class="sub_contents color_blue common_forum">
        <div class="container_wrap">
            <div class="container">
                <h3 class="sub_title"><span>기술표준분과</span></h3>
                <div class="cards">
                    <article class="board_card">
                        <h4 class="sub_des_title">위원회 소개</h4>
                        <div>
                            <p class="dot_desc">​SDN/NFV 기술 및 표준 동향 공유</p>
                            <p class="dot_desc">​SDN/NFV 관련 국내외 표준기술 백서 개발</p>
                            <p class="dot_desc">​SDN/NFV 기술 산업화 및 기술 개발 정책 지원</p>
                            <i class="spr forum_icn_earth"></i>
                        </div>
                    </article>
                    <article class="board_card">
                        <h4 class="sub_des_title">활동 내용</h4>
                        <div>
                            <p class="dot_desc">SDN/NFV 기술 세미나 및 워크숍 개최</p>
                            <p class="dot_desc">스마트 인터넷 산업 발전을 위한 SDN/NFV 표준기술 백서 개발</p>
                            <p class="dot_desc">SDN/NFV 관련 국제 기관과의 기술 및 표준화 협력</p>
                            <i class="spr forum_icn_settings"></i>
                        </div>
                    </article>
                </div>
            </div>
        </div>
        <article class="container_wrap tech_standard">
            <div class="container org_chart_wrap">
                <h4 class="sub_des_title">기술표준분과 조직도</h4>
                <dl class="org_chart">
                    <dt class="common_rect blue">기술표준분과</dt>
                    <dd class="org_columns">
                        <ul>
                            <li class="common_rect"><span>CNMN WG</span></li>
                            <li class="common_rect"><span>표준화 WG</span></li>
                            <li class="common_rect"><span>보안기술 WG</span></li>
                            <li class="common_rect"><span>P4 WG</span></li>
                        </ul>
                    </dd>
                </dl>
            </div>
        </article>
        <div class="container_wrap">
            <article class="container board_ranking">
                <h4 class="sub_des_title">위원회 구성원</h4>
                <div class="table_wrap">
                    <table class="table_ranking">
                        <caption>위원회 구성원 리스트</caption>
                        <colgroup>
                            <col class="num" />
                            <col class="belong" />
                            <col class="spot" />
                            <col class="name" />
                            <col class="etc" />
                        </colgroup>
                        <thead>
                            <tr>
                                <!-- class add up, remove up -->
                                <th scope="col">연번<i class="spr forum_icn_table_arrow"></i></th>
                                <th scope="col">소속<i class="spr forum_icn_table_arrow"></i></th>
                                <th scope="col">직위<i class="spr forum_icn_table_arrow"></i></th>
                                <th scope="col">성명<i class="spr forum_icn_table_arrow"></i></th>
                                <th scope="col">비고<i class="spr forum_icn_table_arrow"></i></th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- 여기서부터 삽입--->
			               	<% if (rowPageCount[0] == 0) { %>
			               	<tr class="none">
			               		<td colspan="5">등록된 게시물이 없습니다.</td>
			               	</tr>
			               	<%}else { %>
			               	<%
							String targetUrl = "";
							String topClass = "";
							HashMap<String, Object> data;
							for (int i=0; i<list.size(); i++) {
								data = list.get(i);
								targetUrl = "style='cursor:pointer;' onclick=\"location.href='"+dao.getTargetURLParam("view.jsp", param, Function.parseStr(data.get("no")))+"'\"";
							%>
			                   <tr <%if(Function.parseInt(data.get("top")) == 1){ %>class="notice"<%} %>>
			                       <td><!-- <%=data.get("no")%> --><%=i+1%></td>
			                       <td><%=Function.parseStr(data.get("division")) %></td>
			                       <td><%=Function.parseStr(data.get("position")) %></td>
			                       <td><%=Function.parseStr(data.get("name")) %></td>
			                       <td><%=Function.parseStr(data.get("etc"))%></td>
			                   </tr>
			                   <%}} %>
						    <!-- //여기까지 삽입--->
                        </tbody>
                    </table>
                </div>
                <div class="table_utils">
                    <p class="red">*스크롤 하여 리스트를 확인하실 수 있습니다.</p>
                    <!-- <div class="search_form">
                        <label for="search"></label>
                        <input type="text" id="search" name="search" placeholder="검색어를 입력하세요">
                        <button>검색</button>
                    </div> -->
                </div>
            </article>
        </div>
    </section>
</section>

<%@ include file = "/footer.jsp"%>