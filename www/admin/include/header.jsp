<%@page import="property.SiteProperty"%>
<%@ page contentType="text/html; charset=utf-8" %>
<script>
$(window).load(function(){
	

	// 1depth 메뉴들
	var parent = $(".parent");
	
	//현재 주소
	// 주소중 manage이후 폴더 경로 자르기 ex) /board/index.php -> board
	var curUrl = document.location.pathname;
	curUrl = curUrl.substring(curUrl.indexOf("admin")+6,curUrl.length);
	curUrl = curUrl.substring(curUrl,curUrl.indexOf("/"));

	parent.each(function(){
		$(this).removeClass("on");

		// 1depth 메뉴 href 담기
		href = $(this).find("a").attr("href");

		// 주소중 manage이후 폴더 경로 자르기 ex) /board/index.php -> board
		href = href.substring(href.indexOf("admin")+6, href.length);
		href = href.substring(href,href.indexOf("/"));
		
		// 현재 주소에서 href가 포함 되어 있으면 그 메뉴에 배경색 지정
		if(curUrl == href){
			$(this).addClass("on");
		}
	});
	
});
</script>
<!-- s:header -->
<div id="header">
	<h1><a href="/admin/"><%=SiteProperty.COMPANY_NAME%> :: 관리자모드 ::</a></h1>
	<div class="logout">
		<input type="button" title="로그아웃" alt="로그아웃" value="로그아웃" class="" onclick="location.href='/admin/include/logout.jsp';"/>
	</div>
</div>
<nav id="main-nav">
	<ul class="sf-menu clearfix">

		<li class="parent wid180"><a href="/admin/board/notice/index.jsp" ><span>게시판관리</span></a>
			<ul style="width:100%;">
				<li><a href="/admin/board/notice/index.jsp"><span>공지사항</span></a></li>				
				<li><a href="/admin/board/gallery/index.jsp"><span>포토갤러리</span></a></li>
				<li><a href="/admin/board/event/index.jsp"><span>행사안내</span></a></li>
				<li><a href="/admin/board/opendata/index.jsp"><span>공개자료실</span></a></li>
				<li><a href="/admin/board/commitdata/index.jsp"><span>운영위원회자료실</span></a></li>
				<li><a href="/admin/board/memdata/index.jsp"><span>회원사 공유 자료실</span></a></li>
				<li><a href="/admin/board/tech/index.jsp"><span>기술표준분과 자료실</span></a></li>
				<li><a href="/admin/board/policydata/index.jsp"><span>정책협력분과 자료실</span></a></li>
				<li><a href="/admin/board/foreigndata/index.jsp"><span>대외협력 자료실</span></a></li>
				<li><a href="/admin/board/poc/index.jsp"><span>서비스PoC분과 자료실</span></a></li>
				<li><a href="/admin/board/qna/index.jsp"><span>1:1문의 관리</span></a></li>
				
				<!--<li><a href="/admin/board/recruit/index.jsp"><span>채용정보</span></a></li>
				<li><a href="/admin/board/download/index.jsp"><span>다운로드</span></a></li>-->
			</ul>
		</li>
		<li class="parent"><a href="/admin/forum/"><span>포럼일정 관리</span></a></li>
		<li class="parent"><a href="/admin/committee/"><span>위원회 관리</span></a></li>
		<li class="parent"><a href="/admin/member/"><span>회원관리</span></a></li>
		<li class="parent"><a href="/admin/popup/index.jsp"><span>팝업관리</span></a></li>
		<li class="parent"><a href="/admin/environment/admin/index.jsp" ><span>관리</span></a>
			<ul>
				<li><a href="/admin/environment/admin/index.jsp" ><span>관리자 관리</span></a></li>
				<li><a href="/admin/environment/loginhistory/index.jsp" ><span>관리자 접속이력</span></a></li>
			</ul>
		</li>
		<li class="parent"><a href="/admin/connect/">방문자관리</a>
			<ul>
				<li><a href="/admin/connect/">- 유입내역</a></li>
				<li><a href="/admin/connect/page/">- 페이지내역</a></li>
			</ul>
		</li>
	</ul>
</nav>
<!-- e:header --> 