<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "/header.jsp"%>
<%@ page import="board.notice.*" %>
<%@ page import="board.media.*" %>
<%@ page import="contents.partner.*" %>
<%@ page import="contents.history.*" %>
<%@ page import="property.SiteProperty" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>



<section id="sub">

	<%@ include file = "/include/sub_top.jsp"%>

	<!-- sub_contents -->
	<section class="sub_contents">
        <div class="container_wrap">
            <div class="container">
                <h3 class="sub_title"><span>조직도</span></h3>
                <div class="organization">
                    <dl class="org_chart">
                        <dt class="poly">
                            <span>
                                <em>총회</em>
                                <span>의장</span>
                            </span>
                        </dt>
                        <dd class="org_top">
                            <ul>
                                <li class="common_rect"><span>감사</span></li>
                                <li class="common_rect no-line"><span>자문위원회</span></li>
                            </ul>
                        </dd>
                        <dd class="org_abs">
                            <ul>
                                <li class="common_rect"><span>운영위원회</span></li>
                                <li class="common_rect"><span>사무국</span></li>
                            </ul>
                        </dd>
                        <dd class="org_columns">
                            <ul>
                                <li class="common_rect"><span>정책협력분과</span></li>
                                <li class="common_rect"><span>대외협력분과</span></li>
                                <li class="common_rect"><span>기술표준분과</span></li>
                                <li class="common_rect"><span>서비스PoC분과</span></li>
                            </ul>
                        </dd>
                    </dl>
                </div>
            </div>
        </div>
    </section>
</section>

<%@ include file = "/footer.jsp"%>