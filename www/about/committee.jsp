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
	
	param.put("scategory","1");
	ArrayList<HashMap<String, Object>> list = dao.list(param);
	ArrayList<HashMap<String, Object>> list2 = dao.listAll(param);
	int[] rowPageCount = dao.count(param);
	
	/* String today = DateUtil.getToday();
	String yesterday = DateUtil.getDayDateAdd(-1, today);
	String oneweek = DateUtil.getDayDateAdd(-7, today);
	String onemonth = DateUtil.getMonthDateAdd(-1, today);
	String twomonth = DateUtil.getMonthDateAdd(-2, today);
	String threemonth = DateUtil.getMonthDateAdd(-3, today); */
%>
<section id="sub" class="committee">

	<%@ include file = "/include/sub_top.jsp"%>

	<!-- sub_contents -->
    <section class="sub_contents color_blue common_forum">
        <div class="container_wrap">
            <div class="container">
                <h3 class="sub_title"><span>운영위원회</span></h3>
                <div class="cards">
                    <article class="board_card">
                        <h4 class="sub_des_title">운영위원회 소개</h4>
                        <div>
                            <p class="dot_desc">포럼 운영사업의 운영방안 및 운영계획 검토</p>
                            <p class="dot_desc">포럼 운영관련 주요안건의 의결</p>
                            <i class="spr forum_icn_earth"></i>
                        </div>
                    </article>
                    <article class="board_card">
                        <h4 class="sub_des_title">활동 내용</h4>
                        <div>
                            <p class="dot_desc">회원의 가입, 제명 또는 자격 정지에 관한 사항</p>
                            <p class="dot_desc">임원의 후보 추천에 관한 사항</p>
                            <p class="dot_desc">업무계획 운영 및 집행에 관한 사항</p>
                            <p class="dot_desc">포럼 운영규정의 제정 및 개정과 폐지에 관한 사항</p>
                            <p class="dot_desc">각종위원회의 설립 및 운영에 관한 사항</p>
                            <p class="dot_desc">그 밖에 포럼 운영에 관한 주요사항</p>
                            <i class="spr forum_icn_settings"></i>
                        </div>
                    </article>
                </div>
            </div>
        </div>
        <div class="container_wrap">
            <article class="container board_ranking">
                <h4 class="sub_des_title">운영위원회 구성원</h4>
                <div class="table_wrap">
                    <table class="table_ranking">
                        <caption>운영위원회 구성원 리스트</caption>
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
			                       <%-- <td><%=CodeUtil.getCommitteeCategoryName(Function.parseInt(data.get("category"))) %></td> --%>
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