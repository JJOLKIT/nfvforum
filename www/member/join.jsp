<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "/header.jsp"%>
<%@ page import="board.notice.*" %>
<%@ page import="board.media.*" %>
<%@ page import="contents.partner.*" %>
<%@ page import="contents.history.*" %>
<%@ page import="property.SiteProperty" %>
<%@ page import="util.*" %>
<%@ page import="java.util.*" %>



<section id="sub" class="m_join">

	<%@ include file = "/include/sub_top.jsp"%>

	<!-- sub_contents -->
    <section class="sub_contents color_blue">
        <div class="container_wrap">
            <div class="container">
                <h3 class="sub_title"><span>정회원 가입 신청</span></h3>
                <article class="member_process">
                    <h4 class="sub_des_title">회원가입 신청 절차</h4>
                    <ol>
                        <li>
                            <span>
                                <sub><em class="circle"><i class="spr forum_icn_reg_step_1"></i></em></sub>
                                <span class="mem_desc">가입신청서 제출</span>
                            </span>
                        </li>
                        <li>
                            <i class="spr forum_icn_reg_step_arrow"></i>
                            <span>
                                <sub><em class="circle"><i class="spr forum_icn_reg_step_2"></i></em></sub>
                                <span class="mem_desc">운영위원회 가입 승인</span>
                            </span>
                        </li>
                        <li>
                            <i class="spr forum_icn_reg_step_arrow"></i>
                            <span>
                                <sub><em class="circle"><i class="spr forum_icn_reg_step_3"></i></em></sub>
                                <span class="mem_desc">연회비 납부</span>
                            </span>
                        </li>
                        <li>
                            <i class="spr forum_icn_reg_step_arrow"></i>
                            <span>
                                <sub><em class="circle"><i class="spr forum_icn_reg_step_4"></i></em></sub>
                                <span class="mem_desc">포럼 활동</span>
                            </span>
                        </li>
                    </ol>
                </article>
            </div>
        </div>
        <div class="container_wrap ">
            <div class="container members">
                <dl class="member_list">
                    <dt>회원가입 신청사</dt>
                    <dd>
                        <ol>
                            <li>
                                <div>
                                    <em>1</em>
                                    <span>
                                        <strong>가입 의사 전달</strong>
                                        <span>포럼 사무국 담당자에게 가입관련 정보 이메일 전송 <br>(회사명, 담당자 정보 등)</span>
                                    </span>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <em>2</em>
                                    <span>
                                        <strong>가입 신청서 작성</strong>
                                        <span>가입신청서 작성 및 대표자 직인 날인 </span>
                                    </span>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <em>3</em>
                                    <span>
                                        <strong>가입 신청서 발송</strong>
                                        <span>가입 신청서 스캔본 (직인 포함)을  포럼 사무국 담당자에게 이메일 발송 </span>
                                    </span>
                                </div>
                            </li>
							<li>
                                <div class="pic">
                                </div>
                            </li>
                            <li>
                                <div>
                                    <em>5-1</em>
                                    <span>
                                        <strong>연회비 납부</strong>
                                        <span>공문 접수 및 연회비 납부</span>
                                    </span>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <em>6</em>
                                    <span>
                                        <strong>회원사 가입 완료</strong>
                                        <span>회원사 가입 완료</span>
                                    </span>
                                </div>
                            </li>
                        </ol>
                    </dd>
                </dl>
                <dl class="member_list">
                    <dt>SDN/NFV포럼</dt>
                    <dd>
                        <ol>
                            <li>
                                <div>
                                    <em>1-1</em>
                                    <span>
                                        <strong>가입 의사 접수</strong>
                                        <span>신청자 이메일 인증 및 가입 신청서 전달</span>
                                    </span>
                                </div>
                            </li>
                            <li>
                                <div class="pic">
                                </div>
                            </li>
                            <li>
                                <div>
                                    <em>3-1</em>
                                    <span>
                                        <strong>가입 신청서 접수</strong>
                                        <span>가입 신청서 접수 및 접수 인증 메일 발송</span>
                                    </span>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <em>4</em>
                                    <span>
                                        <strong>회원사 가입 승인 의결</strong>
                                        <span>운영위원회 안건 상정 및 회원사 가입 승인 의결</span>
                                    </span>
                                </div>
                            </li>
                            <li>
                                <div>
                                    <em>5</em>
                                    <span>
                                        <strong>연회비 납부 요청</strong>
                                        <span>가입 승인 및 연회비 납부 요청 공문 발송</span>
                                    </span>
                                </div>
                            </li>
                        </ol>
                    </dd>
                </dl>
                <a href="/etc/sdn_nfv_membership.docx" download class="btn">
                    포럼 정회원 가입 신청서 다운로드
                    <i class="spr forum_icn_download"></i>
                </a>
            </div>
        </div>
        <div class="container_wrap">
            <article class="container member_table">
                <h4 class="sub_des_title">연회비</h4>
                <span class="payment_unit">(단위 : 천원)</span>
                <table class="table_payment">
                    <caption>연회비 상세 내역</caption>
                    <thead>
                        <tr>
                            <th scope="col">구분</th>
                            <th scope="col">등급</th>
                            <th scope="col">규모</th>
                            <th scope="col">연회비</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th scope="rowgroup" rowspan="6">정회원<br/>(기관회원)</th>
                            <td rowspan="5">운영위원사</td>
                            <td rowspan="2">의장사</td>
                            <td>20,000 (기업)</td>
                        </tr>
                        <tr>
                            <td>10,000 (공공기관)</td>
                        </tr>
                        <tr>
                            <td>대기업 및 중견기업</td>
                            <td>10,000</td>
                        </tr>
                        <tr>
                            <td>중소·벤처기업</td>
                            <td>5,000</td>
                        </tr>
                        <tr>
                            <td>비영리 법인</td>
                            <td>5,000</td>
                        </tr>
                        <tr>
                            <td>일반사</td>
                            <td>일반 기업</td>
                            <td>2,500</td>
                        </tr>
                        <tr>
                            <th scope="row">특별회원</th>
                            <td colspan="2">공통</td>
                            <td>100</td>
                        </tr>
                    </tbody>
                </table>
            </article>
            <article class="container payment_address">
                <h4 class="sub_des_title">연회비 포럼 담당자 연락처</h4>
                <address>
                    <p>한국네트워크산업협회 김나현 대리</p>
                    <span><abbr title="telephone">T.</abbr>070-7860-4306</span>
                    <span><abbr title="email">E.</abbr>nhkim@kani.or.kr</span>
                </address>
            </article>
        </div>
    </section>
</section>

<%@ include file = "/footer.jsp"%>