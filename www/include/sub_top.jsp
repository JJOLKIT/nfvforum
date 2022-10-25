<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>

<%
	String URL = request.getRequestURI();
	String[] values = URL.split("/");
	String uriName = values[1].toLowerCase();
	String pageTitleEN = "SDNNFV FORUM";
	String pageTitleKO = "한국네트워크산업협회";

	if ("about".equals(uriName)) {
		pageTitleEN = "Forum Introduction";
		pageTitleKO = "포럼소개";
	} else if ("member".equals(uriName)) {
		pageTitleEN = "Member Center";
		pageTitleKO = "회원센터";
	} else if ("notice".equals(uriName)) {
		pageTitleEN = "Board";
		pageTitleKO = "게시판";
	} else if ("event".equals(uriName)) {
		pageTitleEN = "Event Information";
		pageTitleKO = "행사안내";
	} else if ("reference".equals(uriName)) {
		pageTitleEN = "Data Room";
		pageTitleKO = "자료실";
	}
%>

<div class="sub_head">
	<div>
		<h2 class="sub_title"><span><%=pageTitleEN%></span></h2>
		<span class="sub_desc"><%=pageTitleKO%></span>
	</div>
</div>
<nav class="sub_navi" role="navigation" aria-label="sub">
	<dl class="container clear">
		<dt><a href="/">H</a></dt>
		<dd>
			<a href="#none" class="js-mainMenu on"><%=pageTitleKO%><i class="spr icn_nav_arrow"></i></a>
			<ul class="subnav_depth_1"></ul>
		</dd>
		<dd class="subnav_depth_2">
			<a href="#none" class="subnav_depth_2_text on"></a>
		</dd>
	</dl>
</nav>
<script>
	$(function() {
		"use strinct";
		var mainMenu = $('.js-mainMenu').text();
		var depth_1_array = $('.nav_wrap dt');
		var depth_1 = $('.subnav_depth_1');
		var depth_2 = $('.subnav_depth_2');
		for (var i = 0; i < depth_1_array.length; i++) {
			if(mainMenu ===  depth_1_array[i].firstElementChild.textContent) {
				depth_2.append(depth_1_array[i].nextElementSibling.innerHTML);
				$('.subnav_depth_2_text').html($('.sub_contents .sub_title span').text() + '<i class="spr icn_nav_arrow"></i>');
				continue;
			}
			depth_1.append('<li>' + depth_1_array[i].firstElementChild.outerHTML + '</li>');
		}
	});
</script>