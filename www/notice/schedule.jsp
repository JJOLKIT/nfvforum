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
                <h3 class="sub_title"><span>포럼일정</span></h3>
                <div class="calendar">
                    <i class="spr forum_icn_calendar_arrow_left"></i>
                    <span><strong>2020</strong>년 <strong>09</strong>월</span>
                    <i class="spr forum_icn_calendar_arrow_right"></i>
                    <div class="calendar_table_wrap">
                        <table class="calendar_table">
                            <caption>포럼 일정 관련 표</caption>
                            <thead>
                                <tr>
                                    <th scope="col" class="sunday">일</th>
                                    <th scope="col">월</th>
                                    <th scope="col">화</th>
                                    <th scope="col">수</th>
                                    <th scope="col">목</th>
                                    <th scope="col">금</th>
                                    <th scope="col" class="saturday">토</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="sunday"></td>
                                    <td></td>
                                    <td><i>1</i></td>
                                    <td><i>2</i></td>
                                    <td><i>3</i></td>
                                    <td class="scheduled"><i>4</i>
                                        <span>·기술정책분과 제2회</span>
                                        <dl class="scheduled_tooltip">
                                            <dt>sdn/nfv포럼 20년 제2회 분과장회의</dt>
                                            <dd>
                                                <span>날짜 : 6월 14일 수요일</span>
                                                <span>시각 : 16:00~18:00</span>
                                                <span>장소: 서울역 5층 KTX6 회의실</span>
                                            </dd>
                                        </dl>
                                    </td>
                                    <td class="saturday"><i>5</i></td>
                                </tr>
                                <tr>
                                    <td class="sunday"><i>6</i></td>
                                    <td><i>7</i></td>
                                    <td><i>8</i></td>
                                    <td><i>9</i></td>
                                    <td><i>10</i></td>
                                    <td><i>11</i>
                                        <span>·기술정책분과 제2회</span>
                                    </td>
                                    <td class="saturday"><i>12</i></td>
                                </tr>
                                <tr>
                                    <td class="sunday"><i>6</i></td>
                                    <td><i>7</i></td>
                                    <td><i>8</i></td>
                                    <td><i>9</i></td>
                                    <td><i>10</i></td>
                                    <td><i>11</i>
                                        <span>·기술정책분과 제2회</span>
                                        <span>·기술정책분과 제2회</span>
                                        <span>·기술정책분과 제2회</span>
                                        <span>·기술정책분과 제2회</span>
                                        <span>·기술정책분과 제2회</span>
                                    </td>
                                    <td class="saturday"><i>12</i></td>
                                </tr>
                                <tr>
                                    <td class="sunday"><i>6</i></td>
                                    <td><i>7</i></td>
                                    <td><i>8</i></td>
                                    <td><i>9</i></td>
                                    <td><i>10</i></td>
                                    <td><i>11</i>
                                        <span>·기술정책분과 제2회</span>
                                    </td>
                                    <td class="saturday"><i>12</i></td>
                                </tr>
                                <tr>
                                    <td class="sunday"><i>27</i></td>
                                    <td><i>28</i></td>
                                    <td><i>29</i></td>
                                    <td><i>30</i></td>
                                    <td></td>
                                    <td></td>
                                    <td class="saturday"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </section>
</section>

<%@ include file = "/footer.jsp"%>