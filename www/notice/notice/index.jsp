<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "/header.jsp"%>
<%@ page import="board.notice.*" %>
<%@ page import="property.SiteProperty" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>

<%@ include file ="config.jsp" %>
<%
	HashMap<String, Object> param = new HashMap();
	param = BeanUtils.bindHashMap(request, param, pageRows);
	NoticeDAO dao = NoticeDAO.getInstance();

	ArrayList<HashMap<String, Object>> list = dao.list(param);
	int[] rowPageCount = dao.count(param);
%>

<script>
function goSearch() {
	$("#searchForm").submit();
}
</script>

<section id="sub" class="notice">
	<%@ include file = "/include/sub_top.jsp"%>
	<!-- sub_contents -->
	<section class="sub_contents">
		<div class="container_wrap">
			<div class="container">
				<h3 class="sub_title"><span>공지사항</span></h3>
				<div class="size">
			        <!-- 여기서부터 삽입--->
			        <div class="bbs">
			            <table class="list">
			                <caption>게시판 목록</caption>
			                <colgroup>
			                    <col width="100px" />
			                    <col width="*" />
			                    <col width="150px" />
			                    <col width="150px" />
			                </colgroup>
			                <thead>
			                    <tr>
			                        <th>No</th>
			                        <th>Title</th>
			                        <th>Date</th>
			                        <th>Hit</th>
			                    </tr>
			                </thead>
			                <tbody>
			                	<% if (rowPageCount[0] == 0) { %>
			                	<tr class="none">
			                		<td colspan="5">등록된 게시물이 없습니다.</td>
			                	</tr>
			                	<%}else { %>
			                	<%
								String targetUrl = "";
								String topClass = "";
								HashMap<String, Object> data;
								
								/*newicon*/
								java.text.SimpleDateFormat sf = new java.text.SimpleDateFormat("yyyy-MM-dd");
								String now = sf.format(new java.util.Date());
								
								for (int i=0; i<list.size(); i++) {
									data = list.get(i);
									targetUrl = "style='cursor:pointer;' onclick=\"location.href='"+dao.getTargetURLParam("view.jsp", param, Function.parseStr(data.get("no")))+"'\"";
								%>
			                    <tr <%if(Function.parseInt(data.get("top")) == 1){ %>class="notice"<%} %> >
			                        <td class="num" <%=targetUrl %>>
			                        	<%if(Function.parseInt(data.get("top")) == 1){%>
				                       	<img src="/img/ico_top.png" alt="공지" />
			                            <%}else{ %>
			                            <%=rowPageCount[0] - (Function.getIntParameter(Function.parseStr(param.get("reqPageNo")))-1)*pageRows - i%>
			                            <%} %>
			                        </td>
			                        <td class="txt_l" <%=targetUrl %>>
			                            <p><%=data.get("title") %>
										<% String inputDate = sf.format(data.get("registdate"));
										   if(inputDate.equals(now)){
										 %>
										    <img src="/img/ico_new.png" class="ico_new" alt="새글" />
										<%} %>
			                            </p>

			                        </td>
			                        <!-- <td class="file on"><a href="/include/download.jsp?path=<%=Function.parseStr(uploadPath)%>&vf=<%=Function.parseStr(data.get("filename"))%>&af=<%=Function.parseStr(data.get("filename_org"))%>" target="_blank"><%=Function.parseStr(data.get("filename_org"))%></a></td> -->
			                        <td class="date" <%=targetUrl %>><%=Function.parseDate(data.get("registdate")) %></td>
			                        <td class="hit" <%=targetUrl %>><%=data.get("readno") %></td>
			                    </tr>
			                    <%}} %>
			                    <!-- 
			                    <tr onclick="location.href='view.jsp'" style="cursor:pointer;">
			                        <td class="num">
			                            10
			                        </td>
			                        <td class="txt_l">
			                            <p>제목입니다 제목입니다 제목입니다 제목입니다 제목입니다 제목입니다 제목입니다</p>
			                        </td>
			                        <td class="date">2019-01-01</td>
			                        <td class="hit">252</td>
			                    </tr>
			                    <tr onclick="location.href='view.jsp'" style="cursor:pointer;">
			                        <td class="num">
			                            09
			                        </td>
			                        <td class="txt_l">
			                            <p>제목입니다</p>
			                        </td>
			                        <td class="date">2019-01-01</td>
			                        <td class="hit">252</td>
			                    </tr>
			                     -->
			                </tbody>
			            </table>
			            <div class="pagenate clear">
			                <%=Page.indexList(Function.getIntParameter(Function.parseStr(param.get("reqPageNo"))), rowPageCount[1], request)%>
			            </div>
			            <!-- //pagenate -->
			            <div class="bbsSearch">
			                <form method="get" name="searchForm" id="searchForm" action="index.jsp">
			                    <span class="srchSelect">
			                        <select id="stype" name="stype" class="dSelect" title="검색분류 선택">
			                            <option value="all" <%=Function.getSelected("all", Function.parseStr(param.get("stype"))) %>>제목+내용</option>
			                            <option value="title" <%=Function.getSelected("title", Function.parseStr(param.get("stype"))) %>>제목</option>
			                            <option value="contents" <%=Function.getSelected("contents", Function.parseStr(param.get("stype"))) %>>내용</option>
			                        </select>
			                    </span>
			                    <span class="searchWord">
			                        <input type="text" id="sval" name="sval" value="<%=Function.parseStr(param.get("sval")) %>" title="검색어 입력" placeholder="검색어를 입력하세요" onKeypress="">
			                        <input type="button" id="" value="검색" title="검색" onclick="goSearch();">
			                    </span>
			                </form>
			            </div>            
			        </div>
			    </div>
			    <!-- //여기까지 삽입--->
			</div>
		</div>
	</section>
</section>

<%@ include file = "/footer.jsp"%>