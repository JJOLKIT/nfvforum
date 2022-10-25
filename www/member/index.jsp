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
                <h3 class="sub_title"><span>회원현황</span></h3>
                <article class="member_company">
                    <h4 class="sub_des_title">의장사</h4>
                    <ul>
                        <li><a href="https://www.nia.or.kr/site/nia_kor/main.do" target="_blank"><span><i class="spr spr_com_nia"></i></span><span class="blind">nia(한국정보화진흥원)</span></a></li>
                    </ul>
                </article>
                <article class="member_company">
                    <h4 class="sub_des_title">운영위원사</h4>
                    <ul>
                        <li><a href="https://corp.kt.com/" target="_blank"><span><i class="spr spr_com_kt"></i></span><span class="blind">kt</span></a></li>
                        <li><a href="http://www.uplus.co.kr/home/Index.hpi" target="_blank"><span><i class="spr spr_com_lg"></i></span><span class="blind">lg</span></a></li>
                        <li><a href="http://www.coweaver.co.kr/ko/" target="_blank"><span><i class="spr spr_com_cowever"></i></span><span class="blind">cowever</span></a></li>
                        <li><a href="https://ubiquoss.com:44335/renew/index.php" target="_blank"><span><i class="spr spr_com_ubi"></i></span><span class="blind">ubiquoss</span></a></li>
                        <li><a href="http://www.dasannetworks.com/kr/" target="_blank"><span><i class="spr spr_com_dasan"></i></span><span class="blind">dasan</span></a></li>
                        <li><a href="https://www.iitp.kr/main.it" target="_blank"><span><i class="spr spr_com_iiip"></i></span><span class="blind">iiip(정보통신기술진흥센터)</span></a></li>
                        <li><a href="https://www.kisa.or.kr/main.jsp" target="_blank"><span><i class="spr spr_com_kisa"></i></span><span class="blind">kisa(한국인터넷진흥원)</span></a></li>
                        <li><a href="https://www.samsung.com/global/business/networks/ " target="_blank"><span><i class="spr spr_com_samsung"></i></span><span class="blind">samsung</span></a></li>
                        <li><a href="https://www.kisti.re.kr/" target="_blank"><span><i class="spr spr_com_kisti"></i></span><span class="blind">kisti(한국과학기술정보연구원)</span></a></li>
                        <li><a href="https://www.etri.re.kr/kor/main/main.etri" target="_blank"><span><i class="spr spr_com_etri"></i></span><span class="blind">etri(한국전자통신연구원)</span></a></li>
                        <li><a href="https://www.hfrnet.com/front/main/mainPage" target="_blank"><span><i class="spr spr_com_hfr"></i></span><span class="blind">hfr.inc</span></a></li>
                        <li><a href="http://telefield.com/" target="_blank"><span><i class="spr spr_com_tele"></i></span><span class="blind">telefield</span></a></li>
                        <li><a href="http://www.mobigen.com/" target="_blank"><span><i class="spr spr_com_mobi"></i></span><span class="blind">mobigen</span></a></li>
                    </ul>
                </article>
                <article class="member_company">
                    <h4 class="sub_des_title">일반사</h4>
                    <ul>
                        <li><a href="http://www.genietec.com/" target="_blank"><span><i class="spr spr_com_geni"></i></span><span class="blind">genietech</span></a></li>
                        <li><a href="https://www.ahnlab.com/kr/site/main.do" target="_blank"><span><i class="spr spr_com_ahnlab"></i></span><span class="blind">ahnlab</span></a></li>
<!--                        <li><a href="https://www.edge-core.com/index.php" target="_blank"><span><i class="spr spr_com_edge"></i></span><span class="blind">edge core</span></a></li>-->
                        <li><a href="http://www.atto-research.com/" target="_blank"><span><i class="spr spr_com_atto"></i></span><span class="blind">atto research</span></a></li>
                        <li><a href="https://www.vmware.com/kr.html" target="_blank"><span><i class="spr spr_com_vm"></i></span><span class="blind">vmware</span></a></li>
                        <li><a href="http://www.eluon.com/" target="_blank"><span><i class="spr spr_com_eluon"></i></span><span class="blind">eluon</span></a></li>
                        <li><a href="http://www.netvisiontel.com/nv/work/index.html" target="_blank"><span><i class="spr spr_com_net"></i></span><span class="blind">netvision</span></a></li>
												<li><a href="http://www.woori-net.com/2018/main/main.html" target="_blank"><span><i class="spr spr_com_worknet"></i></span><span class="blind">woori net(우리넷)</span></a></li>
                    </ul>
                </article>
                <article class="member_company">
                    <h4 class="sub_des_title">참여 대학</h4>
                    <ul>
                        <li><a href="http://www.postech.ac.kr/" target="_blank"><span><i class="spr spr_com_postech"></i></span><span class="blind">postech</span></a></li>
                        <li><a href="https://www.skku.edu/skku/index.do" target="_blank"><span><i class="spr spr_com_uni_sung"></i></span><span class="blind">성균관대학교</span></a></li>
                        <li><a href="https://ssu.ac.kr/" target="_blank"><span><i class="spr spr_com_uni_soong"></i></span><span class="blind">숭실대학교</span></a></li>
                        <li><a href="https://www.gist.ac.kr/kr/event_2st/index.html" target="_blank"><span><i class="spr spr_com_gwang"></i></span><span class="blind">광주과학기술원</span></a></li>
                        <li><a href="https://www.kw.ac.kr/ko/" target="_blank"><span><i class="spr spr_com_uni_gwang"></i></span><span class="blind">광운대학교</span></a></li>
                        <li><a href="https://www.snu.ac.kr/index.html" target="_blank"><span><i class="spr spr_com_uni_seoul"></i></span><span class="blind">서울대학교</span></a></li>
                        <li><a href="https://www.yonsei.ac.kr/sc/" target="_blank"><span><i class="spr spr_com_uni_yonsei"></i></span><span class="blind">연세대학교</span></a></li>
                        <li><a href="http://www.korea.ac.kr/mbshome/mbs/university/index.do" target="_blank"><span><i class="spr spr_com_uni_korea"></i></span><span class="blind">고려대학교</span></a></li>
                        <li><a href="https://www.khu.ac.kr/kor/main/index.do" target="_blank"><span><i class="spr spr_com_uni_kyunghee"></i></span><span class="blind">경희대학교</span></a></li>
                        <li><a href="http://www.knu.ac.kr/wbbs/" target="_blank"><span><i class="spr spr_com_uni_kyungbuk"></i></span><span class="blind">경북대학교</span></a></li>
                        <li><a href="http://www.kaist.ac.kr/kr/" target="_blank"><span><i class="spr spr_com_uni_kaist"></i></span><span class="blind">카이스트</span></a></li>
                    </ul>
                </article>
            </div>
        </div>
    </section>
</section>

<%@ include file = "/footer.jsp"%>