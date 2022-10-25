<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.notice.*" %>
<%@ page import="board.media.*" %>
<%@ page import="contents.partner.*" %>
<%@ page import="contents.history.*" %>
<%@ page import="property.SiteProperty" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>

<!doctype html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">

    <title>SDN/NFV Forums</title>
    <link rel="icon" type="image/x-icon" href="/favicon.ico"/>
    <!-- Styles -->
    <link rel="stylesheet" href="/css/reset.css">
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/content.css">
    <link rel="stylesheet" href="/css/responsive.css">
    <!-- input css -->
    <!-- scripts -->
    <script src="/js/jquery.min.js" type="text/javascript"></script>
    <script src="/js/common.js" type="text/javascript"></script>
    <script type="text/javascript" src="/js/function_jquery.js"></script>
	<script type="text/javascript" src="/js/function.js"></script>
    
    <script>
    
    function goSave() {
		if ($("#name").val().trim() == "") {
			alert("Please write your name.");
			$("#name").focus();
			return false;
		}
		if ($("#email1").val().trim() == "") {
			alert("Please write your email address.");
			$("#email1").focus();
			return false;
		}
		if ($("#email2").val().trim() == "") {
			alert("Please write your another email.");
			$("#email2").focus();
			return false;
		}
		if ($("#title").val().trim() == "") {
			alert("Please write the title.");
			$("#title").focus();
			return false;
		}
		if ($("#contents").val().trim() == "") {
			alert("Please write contents.");
			$("#contents").focus();
			return false;
		}
		let emailMerge = $("#email1").val()+'@'+$("#email2").val();
		$("#email").val(emailMerge);

		console.log($("#email").val());
		$("#frm").submit();
	}
    </script>
</head>
<body class="english">

	<div class="wrapper">

		<%@ include file = "/include/popup/mainPop.jsp" %>
		<!-- header -->
		<header id="header">
			<!-- util_bar -->
			<div class="container_wrap util_bar"></div>
			<!-- navigation -->
			<nav class="container navigation" role="navigation" aria-label="common">
				<a href="/" class="langs lang_ko"><span>KOREAN</span></a>
			</nav>
		</header>
		<section id="english">
			<!-- visual_wrap -->
			<div class="visual_wrap">
				<div class="img_wrap active">
					<div class="text_wrap">
						<p class="img_text">SDN/NFV</p>
						<span class="img_desc">Software Defined Networks, <br/> Network Functions Virtualization</span>
					</div>
					<img src="/img/visual_02.jpg" alt="main visual" class="only-pc">
					<img src="/img/m_visual_01.jpg" alt="main visual" class="only-m">
				</div>
			</div>
			<!-- english_contents -->
			<section class="english_contents">
				<div class="container_wrap">
					<div class="container">
						<h3 class="sub_title"><span>Organization</span></h3>
						<div class="organization">
							<dl class="org_chart">
								<dt class="poly">
									<span>
										<em>Forum <br>Chair</em>
									</span>
								</dt>
                                <dd class="org_top">
                                    <ul>
                                        <li class="common_rect"><span>Auditor</span></li>
                                        <li class="common_rect no-line"><span>Advisory Committee</span></li>
                                    </ul>
                                </dd>
								<dd class="org_abs">
									<ul>
										
										<li class="common_rect"><span>Board of Directors</span></li>
										<li class="common_rect"><span>Secretary(KANI)</span></li>
									</ul>
								</dd>
								<dd class="org_columns">
									<ul>
										<li class="common_rect"><span>Policy Committee</span></li>
										<li class="common_rect"><span>External Relations <br> Committee</span></li>
										<li class="common_rect"><span>Technology &amp; Standards <br>Committee</span></li>
										<li class="common_rect"><span>Service PoC <br> Committee</span></li>
									</ul>
								</dd>
							</dl>
						</div>
					</div>
				</div>
				<div class="container_wrap blue">
					<div class="container">
						<div class="half_box">
							<div>
								<h4 class="sub_des_title">Board of Directors</h4>
								<p class="dot_desc">Deliberate and vote on the issues related to the operation and management of the forum</p>
							</div>
							<div>
								<h4 class="sub_des_title">Policy Committee</h4>
								<p class="dot_desc">Suggest SDN/NFV industry development policy and plan related government assignments </p>
								<p class="dot_desc">​Support the commercialization of SDN/NFV technology</p>
								<p class="dot_desc">​Promote the cooperation among industry, academia, research organizations and government</p>
							</div>
							<div>
								<h4 class="sub_des_title">Advisory Committee</h4>
								<p class="dot_desc">Expert advice on the implementation of the forum's mid-to long-term development plan </p>
							</div>
							<div>
								<h4 class="sub_des_title">External Relations Committee</h4>
								<p class="dot_desc">Strengthening external cooperation between SDN / NFV related organizations and forums</p>
								<p class="dot_desc">Open Networking Korea (ONK) Spring, Fall Conferences held</p>
							</div>
							<div>
								<h4 class="sub_des_title">Technology and Standards Committee</h4>
								<p class="dot_desc">​Establishment of the framework for SDN/NFV based network</p>
								<p class="dot_desc">Publish the white paper on SDN/NFV standardization for the development of Smart Internet Industry</p>
								<p class="dot_desc">Cooperate with SDN/NFV related international organizations for technology and standardization​</p>
							</div>
							<div>
								<h4 class="sub_des_title">Service PoC Committee</h4>
								<p class="dot_desc">​In charge of the PoC for SDN/NFV service of participating companies</p>
								<p class="dot_desc">Certify the technology standards and interoperability of SDN/NFV service of participating companies</p>
								<p class="dot_desc">Promote certification results of SDN/NFV service PoC of participating companies​</p>
							</div>
						</div>
					</div>
				</div>
				<div class="container_wrap">
					<div class="container">
						<h3 class="sub_title"><span>Necessity and Objective</span></h3>
						<article class="sub_cont">
							<h4 class="sub_des_title">Necessity</h4>
							<p class="subject_develop">
								The Development of National Strategies For <br>
								<strong>Next-Generation Technology and Engine for Future Growth</strong>
							</p>
							<div class="subject_need">
								<em>Establishment of SDN/NFV Forum to Secure the Global Leadership in Emerging Internet Industries</em>
								<span>The implementation system for promoting Next-generation technology/standards required</span>
							</div>
							<ul class="subject_cards">
								<li>
									<em>Fast-changing ICT Paradigm</em>
									<div class="subject_card">
										​<p class="dot_desc">As IT environment progresses, network, environment is evolving quickly from hardware to software-defined network.</p>
										<span class="subject_process">
											<span>
												<i class="spr forum_icn_computer"></i>
												Supplier-based <strong>Hardware</strong>
											</span>
											<span>
												<i class="spr forum_icn_speed"></i>
												Changes <br> accelerated
											</span>
											<span>
												<i class="spr forum_icn_box"></i>
												User-based  <strong>software</strong>
											</span>
										</span>
										​<p class="dot_desc">SDN/NFV and Cloud Computing are receiving much attention in recent years due to the changes in ICT Paradigm.</p>
									</div>
								</li>
								<li>
									<em>Fast-changing ICT Paradigm</em>
									<div class="subject_card">
										<p class="dot_desc">The function which is flexible and effectively manageable (which overcomes traditional structure of network computing) is increasingly demanded.</p>
										<p class="dot_desc">There is the need for R&D in intelligent network platform for effective traffic management.</p>
										<p class="dot_desc">The establishmnet of national mid to long-term network development plan for future ICT convergence industry is required.</p>
									</div>
								</li>
							</ul>
							<h4 class="sub_des_title">Objective</h4>
							<p class="text">The promotion of domestic network infra industry with SDN/NFV technology</p>
							<p class="dot_desc">Develop the framework based on domestic / international trends in SDN/NFV technology</p>
							<p class="dot_desc">Propose the vision for software-based network infra based on domestic hardware / software technology</p>
							<p class="dot_desc">Form a community for cooperation to develop related industry</p>
						</article>
					</div>
				</div>
				<div class="container_wrap blue">
					<div class="container en_">
						<h3 class="sub_title"><span>SDN/NFV Forum Members</span></h3>
						<article class="member_company">
							<h4 class="sub_des_title">Forum Chair</h4>
							<ul>
								<li><a href="https://www.nia.or.kr/site/nia_kor/main.do"  target="_blank"> <span><i class="spr spr_com_nia"></i></span><span class="blind">nia(한국정보화진흥원)</span></a></li>
							</ul>
						</article>
						<article class="member_company">
							<h4 class="sub_des_title">Board of Directors</h4>
							<ul>
								<li><a href="https://corp.kt.com/eng/"  target="_blank"> <span><i class="spr spr_com_kt"></i></span><span class="blind">kt</span></a></li>
								<!--<li><a href="https://www.sktelecom.com/index_en.html"  target="_blank"> <span><i class="spr spr_com_sk"></i></span><span class="blind">sk telecom</span></a></li>-->
								<li><a href="http://www.uplus.co.kr/com/main/pemain/PeMain.hpi"  target="_blank"> <span><i class="spr spr_com_lg"></i></span><span class="blind">lg</span></a></li>
								<li><a href="http://www.coweaver.co.kr/en/"  target="_blank"> <span><i class="spr spr_com_cowever"></i></span><span class="blind">cowever</span></a></li>
								<li><a href="https://ubiquoss.com:44335/renew/reng/main/main.php"  target="_blank"> <span><i class="spr spr_com_ubi"></i></span><span class="blind">ubiquoss</span></a></li>
								<li><a href="http://www.dasannetworks.com/en/"  target="_blank"> <span><i class="spr spr_com_dasan"></i></span><span class="blind">dasan</span></a></li>
								<li><a href="https://www.iitp.kr/en/main.it"  target="_blank"> <span><i class="spr spr_com_iiip"></i></span><span class="blind">iiip(정보통신기술진흥센터)</span></a></li>
								<li><a href="https://www.kisa.or.kr/eng/main.jsp"  target="_blank"> <span><i class="spr spr_com_kisa"></i></span><span class="blind">kisa(한국인터넷진흥원)</span></a></li>
								<li><a href="https://www.samsung.com/us/"  target="_blank"> <span><i class="spr spr_com_samsung"></i></span><span class="blind">samsung</span></a></li>
								<li><a href="https://www.kisti.re.kr/eng/"  target="_blank"> <span><i class="spr spr_com_kisti"></i></span><span class="blind">kisti(한국과학기술정보연구원)</span></a></li>
								<li><a href="https://www.etri.re.kr/eng/main/main.etri"  target="_blank"> <span><i class="spr spr_com_etri"></i></span><span class="blind">etri(한국전자통신연구원)</span></a></li>
								<li><a href="https://www.hfrnet.com/front/main/mainPage"  target="_blank"> <span><i class="spr spr_com_hfr"></i></span><span class="blind">hfr.inc</span></a></li>
								<li><a href="http://telefield.com/en/"  target="_blank"> <span><i class="spr spr_com_tele"></i></span><span class="blind">telefield</span></a></li>
								<li><a href="http://www.mobigen.com/eng/index.php"  target="_blank"> <span><i class="spr spr_com_mobi"></i></span><span class="blind">mobigen</span></a></li>
							</ul>
						</article>
						<article class="member_company">
							<h4 class="sub_des_title">General Members</h4>
							<ul>
								<li><a href="http://www.genietec.com/"  target="_blank"> <span><i class="spr spr_com_geni"></i></span><span class="blind">genietech</span></a></li>
								<li><a href="https://global.ahnlab.com/site/main.do"  target="_blank"> <span><i class="spr spr_com_ahnlab"></i></span><span class="blind">ahnlab</span></a></li>
								<!--<li><a href="https://www.edge-core.com/"  target="_blank"> <span><i class="spr spr_com_edge"></i></span><span class="blind">edge core</span></a></li>-->
								<li><a href="http://www.atto-research.com/"  target="_blank"> <span><i class="spr spr_com_atto"></i></span><span class="blind">atto research</span></a></li>
								<li><a href="https://www.vmware.com/"  target="_blank"> <span><i class="spr spr_com_vm"></i></span><span class="blind">vmware</span></a></li>
								<li><a href="http://en.eluon.com/"  target="_blank"> <span><i class="spr spr_com_eluon"></i></span><span class="blind">eluon</span></a></li>
								<li><a href="http://www.netvisiontel.com/nv/work/index.html"  target="_blank"> <span><i class="spr spr_com_net"></i></span><span class="blind">netvision</span></a></li>
								<li><a href="http://www.woori-net.com/2018/2018_E/main/main.html"  target="_blank"> <span><i class="spr spr_com_worknet"></i></span><span class="blind">woori net(우리넷)</span></a></li>
							</ul>
						</article>
					</div>
				</div>
				<div class="container_wrap">
					<div class="container">
						<h3 class="sub_title"><span>Contact Us</span></h3>
						<div class="register_table">
							<form method="post" id="frm" action="<%=Function.getSslCheckUrl(request.getRequestURL())%>/process.jsp" enctype="multipart/form-data">
							<table>
								<caption>register info</caption>
								<colgroup>
									<col class="th_head">
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><i class="special">*</i><span>Name</span></th>
										<td>
											<label>
												<input type="text" name="name" id="name" >
											</label>
										</td>
									</tr>
									<tr>
										<th scope="row"><i class="special">*</i><span>E-mail</span></th>
										<td class="td_email">
											<label>
												<input type="text" id="email1">
											</label>
											<span>@</span>
											<label>
												<select >
													<option value="asdf">naver.com</option>
													<option value="asdf">gmail.com</option>
													<option value="asdf">hanmail.com</option>
													<option value="asdf">nate.com</option>
												</select>
											</label>
											<label>
												<input type="text" id="email2">
											</label>
										</td>
									</tr>
									<tr>
										<th scope="row"><i class="special">*</i><span>Title</span></th>
										<td>
											<label>
												<input type="text" name="title" id="title">
											</label>
										</td>
									</tr>
									<tr>
										<th scope="row"><i class="special">*</i><span>Message</span></th>
										<td>
											<label>
												<textarea name="contents" id="contents" cols="30" rows="10"></textarea>
											</label>
										</td>
									</tr>
								</tbody>
								<input type="hidden" name="cmd" value="writeEng" />
								<input type="hidden" name="email" id="email" value="" />
							</table>
						</div>
						<a href="javascript:;" class="btn" onclick="goSave();">Send</a>
					</div>
				</div>
			</section>
		</section>

	</div>

	<!-- footer -->
	<footer id="footer" class="container_wrap">
		<button type="button" class="go_to_top"><img src="/img/icn_top.png" alt="최상단으로" /></button>
		<div class="footer_wrap container">
			<h2 class="blind">info contents</h2>
			<span class="foot_logo"><img src="/img/logo.png" alt="SDNNFV FORUM"></span>
			<address class="address">
				<p class="addr_title">SDN/NFV Forum Secretariat</p>
				<span class="addr_desc">
					08506 1502, Building C, 131, Gasan Digital 1-ro, Geumcheon-gu, Seoul (BYC High City, Gasan-dong)<br/>
					<abbr title="telephone">T.</abbr> 070-7860-4306
				</span>
				<span class="copy">COPYRIGHT &copy; 2014 SDN/NFV FORUM. ALL RIGHTS RESERVED</span>
			</address>
		</div>
	</footer>
</body>
</html>