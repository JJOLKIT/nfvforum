<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

</div>
<!--//wrapper-->

<footer id="footer" class="container_wrap">
	<button type="button" class="go_to_top"><img src="/img/icn_top.png" alt="최상단으로" /></button>
	<div class="footer_wrap container">
		<h2 class="blind">하단내용</h2>
		<span class="foot_logo"><img src="/img/logo.png" alt="SDNNFV FORUM"></span>
		<address class="address">
			<p class="addr_title">SDN/NFV포럼 사무국</p>
			<span class="addr_desc">
				08506 서울시 금천구 가산디지털1로 131, C동 1502호 (BYC하이시티, 가산동) <br/>
				<abbr title="telephone">T.</abbr> 070-7860-4306
			</span>
		</address>
		<div class="foot_utils">
			<a href="/member/terms.jsp">이용약관</a>
			<a href="javascript:;" onclick="viewTerms(1);">개인정보취급방침</a>
			<span class="copy">COPYRIGHT &copy; 2014 SDN/NFV FORUM. ALL RIGHTS RESERVED</span>
		</div>
	</div>
</footer>
<script type="text/javascript">
	function viewTerms(pop) {
		if( pop == 1 ) {
			window.open("/etc/private.jsp", "pwin", "width=500, height=520");
		}
	}
</script>
</body>
</html>
