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
                <h3 class="sub_title"><span>연혁</span></h3>
                <ol class="history clear">
										<li class="his_right">
                        <em><strong>2022</strong>년</em>
                        <ul>
														<li><em>09.15</em><span>2022년 제2회 운영위원회(서면결의)</span></li>
	                          <li><em>05.17</em><span>SDN/NFV포럼 제10회 정기총회</span></li>
                            <li><em>04.26</em><span>2022년 제1회 운영위원회(서면결의)</span></li>
                        </ul>
                    </li>
                    <li class="his_left">
                        <em><strong>2021</strong>년</em>
                        <ul>
														<li><em>12.03</em><span>2021년 제4회 운영위원회(서면결의)</span></li>
														<li><em>11.26</em><span>Open Networking Korea (ONK) 2021</span></li>
														<li><em>10.15</em><span>2021년 제3회 운영위원회(서면결의)</span></li>
                            <li><em>07.09</em><span>SDN/NFV포럼 제9회 정기총회</span></li>
                            <li><em>06.10</em><span>2021년 제2회 운영위원회(서면결의)</span></li>
                            <li><em>06.03</em><span>2021년 제1회 운영위원회(서면결의)</span></li>
                        </ul>
                    </li>
                    <li class="his_right">
                        <em><strong>2020</strong>년</em>
                        <ul>
                            <li><em>12.10</em><span>2020년 제3회 운영위원회(서면결의)</span></li>
                            <li><em>11.26</em><span>Open Networking Korea (ONK) 2020</span></li>
                            <li><em>09.22</em><span>2020년 제2회 운영위원회(서면결의)</span></li>
                            <li><em>05.27</em><span>SDN/NFV포럼 제8회 정기총회</span></li>
                            <li><em>05.06-12</em><span> 2020년 제1회 운영위원회(서면결의)</span></li>
                        </ul>
                    </li>
                    <li class="his_left">
                        <em><strong>2019</strong>년</em>
                        <ul>
                            <li><em>11.06</em><span>Open Networking Korea (ONK) 2019 Fall</span></li>
                            <li><em>10.21-25</em><span>ITU-T Q12 and Q14 Joint Interim</span></li>
                            <li><em>10.15-21</em><span>SDN/NFV포럼 제7회 임시총회</span></li>
                            <li><em>10.07-13</em><span>2019년 제3회 운영위원회(서면결의)</span></li>
                            <li><em>10.01</em><span>2019년 제2회 운영위원회</span></li>
                            <li><em>04.23</em><span>SDN/NFV포럼 제6회 정기총회</span></li>
                            <li><em>03.22</em><span>2019년 제1회 운영위원회</span></li>
                        </ul>
                    </li>
                    <li class="his_right">
                        <em><strong>2018</strong>년</em>
                        <ul>
                            <li><em>12.07</em><span>2018년 제3회 운영위원회</span></li>
                            <li><em>10.25-26</em><span>Open Networking Korea (ONK) 2018 Fall </span></li>
                            <li><em>09.21</em><span>2018년 제2회 운영위원회 및 회원사 간담회</span></li>
                            <li><em>06.15</em><span>2018년 ONOS/CORD WG 2차 회의</span></li>
                            <li><em>04.23-24</em><span>Open Networking Korea (ONK) 2018 Spring</span></li>
                            <li><em>04.11</em><span>SDN/NFV포럼 제5회 정기총회</span></li>
                            <li><em>03.08</em><span>SDN/NFV포럼 제1회 운영위원회</span></li>
                        </ul>
                    </li>
                    <li class="his_left">
                        <em><strong>2017</strong>년</em>
                        <ul>
                            <li><em>12.13</em><span>2017년 제4회 운영위원회</span></li>
                            <li><em>11.16-17</em><span>Open Networking Korea (ONK) 2017 Fall</span></li>
                            <li><em>10.25</em><span>2017년 제3회 운영위원회</span></li>
                            <li><em>09.20-22</em><span>ONOS Build 2017</span></li>
                            <li><em>08.09</em><span>SDN/NFV포럼 네트워크 발전전략 토론회</span></li>
                            <li><em>08.03</em><span>SDN/NFV포럼 특강 세미나</span></li>
                            <li><em>07.20</em><span>2017년 제2회 운영위원회</span></li>
                            <li><em>04.27-28</em><span>Open Networking Korea (ONK) 2017 Spring</span></li>
                            <li><em>03.28</em><span>SDN/NFV포럼 제4회 정기총회</span></li>
                            <li><em>02.24</em><span>2017년 제1회 운영위원회</span></li>
                        </ul>
                    </li>
                    <li class="his_right">
                        <em><strong>2016</strong>년</em>
                        <ul>
                            <li><em>12.07</em><span>SDN/NFV포럼 & 5G포럼 5G 네트워크 기술 공동워크숍</span></li>
                            <li><em>12.01</em><span>2016년 제6회 운영위원회</span></li>
                            <li><em>11.24-25</em><span>Open Networking Korea (ONK) 2016 Fall</span></li>
                            <li><em>10.18</em><span>SDN/NFV포럼 5G 네트워크 구조 및 기술이슈 워크숍</span></li>
                            <li><em>09.29</em><span>2016년 제5회 운영위원회</span></li>
                            <li><em>06.30</em><span>2016년 제4회 운영위원회</span></li>
                            <li><em>04.15</em><span>SDN/NFV포럼 제3회 정기총회</span></li>
                            <li><em>04.07-08</em><span>Open Networking Korea (ONK) 2016 Spring</span></li>
                            <li><em>03.24-30</em><span>2016년 제3회 운영위원회(서면결의)</span></li>
                            <li><em>03.09</em><span>2016년 제2회 운영위원회</span></li>
                            <li><em>02.15-22</em><span>2016년 제1회 운영위원회(서면결의)</span></li>
                        </ul>
                    </li>
                    <li class="his_left">
                        <em><strong>2015</strong>년</em>
                        <ul>
                            <li><em>12.02</em><span>2015년 제4회 운영위원회</span></li>
                            <li><em>11.18-19</em><span>Open Networking Korea (ONK) 2015</span></li>
                            <li><em>09.15-17</em><span>ONOS Day & Code Walkthrough</span></li>
                            <li><em>09.09</em><span>2015년 제3회 운영위원회</span></li>
                            <li><em>07.09</em><span>한국 SDN/NFV 및 네트워크 산업 활성화 방안 간담회</span></li>
                            <li><em>04.10</em><span>SDN/NFV포럼 제2회 정기총회</span></li>
                            <li><em>04.07</em><span>2015년 제2회 운영위원회(서면결의)</span></li>
                            <li><em>03.11</em><span>2015년 제1회 운영위원회</span></li>
                        </ul>
                    </li>
                    <li class="his_right">
                        <em><strong>2014</strong>년</em>
                        <ul>
                            <li><em>10.27</em><span>KISTI 첨단연구망센터 세미나</span></li>
                            <li><em>10.01</em><span>SDN/NFV 산업활성화 세미나<br/>SDN/NFV포럼 창립총회</span></li>
                            <li><em>06.27</em><span>네트워크분야 국가 R&D 과제 설명회</span></li>
                            <li><em>05.15</em><span>스마트네트워크 산업 간담회</span></li>
                            <li><em>05.09</em><span>스마트인터넷 R&D과제 기술 회의</span></li>
                        </ul>
                    </li>
                </ol>
            </div>
        </div>
    </section>
</section>

<%@ include file = "/footer.jsp"%>