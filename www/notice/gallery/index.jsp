<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "/header.jsp"%>
<%@ page import="board.gallery.*" %>
<%@ page import="property.SiteProperty" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>

<%@ include file = "config.jsp" %>

<%
	HashMap<String, Object> param = new HashMap();
	param = BeanUtils.bindHashMap(request, param, pageRows);
	GalleryDAO dao = GalleryDAO.getInstance();

	ArrayList<HashMap<String, Object>> list = dao.list(param);
	int[] rowPageCount = dao.count(param);
%>


<section id="sub">
	<%@ include file = "/include/sub_top.jsp"%>
	<!-- sub_contents -->
	<section class="sub_contents">
		<div class="container_wrap">
			<div class="container">
				<h3 class="sub_title"><span>포토갤러리</span></h3>
				<article class="sub_cont">
					<h4 class="sub_des_title"></h4>
					<!-- <h4 class="sub_des_title">포토갤러리 입니다.</h4> -->
					<div class="size">
						<div class="program">
							<!--<h2 class="title">갤러리</h2>-->
							<!--s:내용-->
								<div class="bbs">
									<div class="gallery">
										<% if (rowPageCount[0] == 0) { %>
											<div class="bbsno">
												<p>등록된 글이 없습니다.</p>
											</div>
										<% } else { %>
										<ul>
										<%
											String targetUrl = "";
											String topClass = "";
											HashMap<String, Object> data;
											for (int i=0; i<list.size(); i++) {
												data = list.get(i);
												targetUrl = "style='cursor:pointer;' onclick=\"location.href='"+dao.getTargetURLParam("edit.jsp", param, Function.parseStr(data.get("no")))+"'\"";
											%>
											<li>
												<a href="<%=dao.getTargetURLParam("view.jsp", param, Function.parseStr(data.get("no")))%>">
													<div class="imgs">
														<%if(data.get("filename") != null && !"".equals(Function.parseStr(data.get("filename")))){%>
														<p style="background:url('<%=uploadPath+data.get("filename")%>') no-repeat center center/cover;"><img src="/img/no_image.gif" style="opacity:0; visibility:hidden; width:100%; height:auto; "/></p>
														<%} else{%>
														<p style="background:url('/img/no_image.gif') no-repeat center center/contain;"><img src="/img/no_image.gif" style="opacity:0; visibility:hidden; width:100%; height:auto; "/></p>
														<%} %>
													</div>
													<div class="txts">
														<p class="titles"><%=Function.parseStr(data.get("title")) %></p>
														<span><%=Function.parseDate(data.get("registdate")) %></span>
													</div>
												</a>
											</li>
										<%
												}
											 }
										%>
										</ul>
									</div>
									<!-- //galley -->
									<div class="pagenate clear">
										<%=Page.indexList(Function.getIntParameter(Function.parseStr(param.get("reqPageNo"))), rowPageCount[1], request)%>
									</div>
									<!-- //pagenate -->
									<%-- <div class="bbsSearch">
						                <form method="get" name="searchForm" id="searchForm" action="index.jsp">
						                    <span class="srchSelect">
						                        <select id="stype" name="stype" class="dSelect" title="검색분류 선택">
						                            <option value="all" <%=Function.getSelected("all", Function.parseStr(param.get("stype"))) %>>제목+내용</option>
						                            <option value="title" <%=Function.getSelected("title", Function.parseStr(param.get("stype"))) %>>제목</option>
						                            <option value="contents" <%=Function.getSelected("contents", Function.parseStr(param.get("stype"))) %>>내용</option>
						                        </select>
						                    </span>
						                    <span class="searchWord">
						                        <input type="text" id="sval" name="sval" value="<%=Function.parseStr(param.get("sval")) %>" title="검색어 입력" onKeypress="">
						                        <input type="button" id="" value="검색" title="검색" onclick="goSearch();">
						                    </span>
						                </form>
						            </div> --%>
								</div>
							<!-- //bbs -->
							<!--e:내용-->							
						</div>
					</div>
				</article>
			</div>
		</div>
	</section>
</section>

<%@ include file = "/footer.jsp"%>