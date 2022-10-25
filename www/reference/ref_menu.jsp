<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="board_nav">
	<ul class="clear">
		<li><a href="/reference/opendata/" <% if(ref_sp == 1){ out.println("class='on'"); }%>>공개 자료실</a></li>
		<li><a href="/reference/commitdata/" <% if(ref_sp == 2){ out.println("class='on'"); }%>>운영위원회 자료실</a></li>
		<li><a href="/reference/memdata/" <% if(ref_sp == 3){ out.println("class='on'"); }%>>회원사 공유자료실</a></li>
		<li><a href="/reference/tech/" <% if(ref_sp == 4){ out.println("class='on'"); }%>>기술표준분과자료실</a></li>
		<li><a href="/reference/foreigndata/" <% if(ref_sp == 5){ out.println("class='on'"); }%>>대외협력분과 자료실</a></li>
		<li><a href="/reference/poc/" <% if(ref_sp == 6){ out.println("class='on'"); }%>>서비스POC분과 자료실</a></li>
	</ul>
</div>