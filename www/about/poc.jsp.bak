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
	
	param.put("scategory","5");
	ArrayList<HashMap<String, Object>> list = dao.list(param);
	int[] rowPageCount = dao.count(param);
	
	/* String today = DateUtil.getToday();
	String yesterday = DateUtil.getDayDateAdd(-1, today);
	String oneweek = DateUtil.getDayDateAdd(-7, today);
	String onemonth = DateUtil.getMonthDateAdd(-1, today);
	String twomonth = DateUtil.getMonthDateAdd(-2, today);
	String threemonth = DateUtil.getMonthDateAdd(-3, today); */
%>


<section id="sub" class="poc">

	<%@ include file = "/include/sub_top.jsp"%>

	<!-- sub_contents -->
    <section class="sub_contents color_blue common_forum">
        <div class="container_wrap">
            <div class="container">
                <h3 class="sub_title"><span>서비스PoC분과</span></h3>
                <div class="cards">
                    <article class="board_card">
                        <h4 class="sub_des_title">위원회 소개</h4>
                        <div>
                            <p class="dot_desc">사업화를 추진중인 SDN/NFV 기반 서비스의​ 실증·인증을 통한 시장 및 산업 확산</p>
                            <p class="dot_desc">사업화에 걸림돌이 되는 기술표준·정책규제의​ 조기 발굴 및 해결안 마련</p>
                            <i class="spr forum_icn_earth"></i>
                        </div>
                    </article>
                    <article class="board_card">
                        <h4 class="sub_des_title">활동 내용</h4>
                        <div>
                            <p class="dot_desc">참여사 SDN/NFV 서비스의 PoC 주관</p>
                            <p class="dot_desc">참여사 SDN/NFV 서비스의 기술표준 및 상호연동 인증</p>
                            <p class="dot_desc">참여사 SDN/NFV 서비스의 PoC 및 인증 결과에 대한 데모·홍보 지원 </p>
                            <p class="dot_desc">창업 지원을 위한 SDN/NFV 서비스의 Open Innovation 센터 운영</p>
                            <p class="dot_desc">참여사 SDN/NFV 개발자 Community 운영</p>
                            <i class="spr forum_icn_settings"></i>
                        </div>
                    </article>
                </div>
            </div>
        </div>
        <article class="container_wrap tech_standard poc">
            <div class="container org_chart_wrap org_column_5">
                <h4 class="sub_des_title">서비스PoC분과 조직도</h4>
                <dl class="org_chart">
                    <dt class="common_rect blue">서비스PoC분과</dt>
                    <dd class="org_columns pic">
                        <ul>
                            <li class="common_rect"><span>ONOS/CORD WG</span></li>
                            <li class="common_rect"><span>P4 Application WG</span></li>
                            <li class="common_rect"><span>NFV WG​</span></li>
                            <li class="common_rect"><span>OCP WG</span></li>
                            <li class="common_rect"><span>Open Wireless Access WG</span></li>
                            <li class="common_rect"><span>Q-kaaS WG</span></li>
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