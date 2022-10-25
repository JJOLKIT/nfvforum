<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "/include/head.jsp"%>
<script>
	$(function(){
		$('.etc').parents('.wrapper').css('padding','0');
	});
</script>
		<div class="etc">
			<div class="info_pop">
				<div class="info_text">
					<h3>개인정보 취급 방침</h3>
					<div class="text_scroll">
						<%@ include file = "/include/policy_private.jsp"%>
					</div>
					<br />
					<center><a href="javascript:;" onclick="javascript:self.close();"><span class="blue_btn">닫 기</span></a></center>
				</div>
			</div>
		</div>
	</div><!--// wrapper -->
</body>
</html>