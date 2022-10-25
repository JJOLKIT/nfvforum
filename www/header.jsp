<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "/include/head.jsp"%>


<!-- header -->
<header id="header">
	<!-- util_bar -->
	<div class="container_wrap util_bar">
		<ul class="container utils">
			<%if(!loginCheck) { %>
			<li><a href="/user/login.jsp">LOGIN</a></li>
			<%} else {%>
			<li><a href="/include/logout.jsp">LOGOUT</a></li>
			<%} %>
			<%if(!loginCheck){ %>
			<li><a href="/user/join.jsp">JOIN</a></li>
			<%} %>
			<%if(loginCheck) { %>			
			<li><a href="/user/my_info.jsp">MY PAGE</a></li>
			<%}%>
		</ul>
	</div>

	<button type="button" class="hamburger"></button>

	<!-- navigation -->
	<nav class="container_wrap navigation clear" role="navigation" aria-label="common">
		<div class="container">
			<h1 class="logo"><a href="/"><span class="main_logo"><img src="/img/logo.png" alt="SDNNFV FORUM"></span></a></h1>
			<div class="nav_wrap clear">
				<dl>
					<dt><a href="/about/">포럼소개</a></dt>
					<dd>
						<ul>
							<li><a href="/about/">필요성 및 목표</a></li>
							<li><a href="/about/organization.jsp">조직도</a></li>
							<li><a href="/about/history.jsp">연혁</a></li>
							<li><a href="/about/committee.jsp">운영위원회</a></li>
							<li><a href="/about/advisory.jsp">자문위원회</a></li>
							<li><a href="/about/technical.jsp">기술표준분과</a></li>
							<li><a href="/about/policy.jsp">정책협력분과</a></li>
							<li><a href="/about/external.jsp">대외협력분과</a></li>
							<li><a href="/about/poc.jsp">서비스PoC분과</a></li>
							<li><a href="/about/directions.jsp">찾아오시는길</a></li>
						</ul>
					</dd>
				</dl>
				<dl>
					<dt><a href="/member/">회원센터</a></dt>
					<dd>
						<ul>
							<li><a href="/member/">회원현황</a></li>
							<li><a href="/member/join.jsp">정회원 가입신청</a></li>
							<li><a href="/member/terms.jsp">이용약관</a></li>
							<li><a href="/member/qna.jsp">1:1 문의</a></li>
						</ul>
					</dd>
				</dl>
				<dl>
					<dt><a href="/notice/notice/">게시판</a></dt>
					<dd>
						<ul>
							<li><a href="/notice/notice/">공지사항</a></li>
							<li><a href="/notice/forum/">포럼일정(캘린더)</a></li>
							<li><a href="/notice/gallery/">포토갤러리</a></li>
						</ul>
					</dd>
				</dl>
				<dl>
					<dt><a href="/event/">행사안내</a></dt>
					<dd>
						<ul>
							<li><a href="/event/">행사안내</a></li>
						</ul>
					</dd>
				</dl>
				<dl>
					<dt><a href="/reference/opendata/">자료실</a></dt>
					<dd>
						<ul>
							<li><a href="/reference/opendata/">공개 자료실</a></li>
							<li><a href="/reference/commitdata/">운영위원회 자료실</a></li>
							<li><a href="/reference/memdata/">회원사 공유자료실</a></li>
							<li><a href="/reference/tech/?scategory=1">기술표준분과 자료실</a></li>
							<li><a href="/reference/policydata/">정책협력분과 자료실</a></li>
							<li><a href="/reference/foreigndata/">대외협력분과 자료실</a></li>
							<li><a href="/reference/poc/?scategory=1">서비스PoC분과 자료실</a></li>
						</ul>
					</dd>
				</dl>
				<div class="mem_btn clear">
					<a href="/user/login.jsp">LOGIN</a>
					<a href="/user/join.jsp">JOIN</a>
				</div>
				<a href="/en/english.jsp" class="langs lang_en"><span>ENGLISH</span></a>
			</div>
			<!-- <button type="button" class="langs lang_ko">KOREAN</button> -->
			
		</div>
		<div class="sub_bg"></div>
	</nav>
</header>

