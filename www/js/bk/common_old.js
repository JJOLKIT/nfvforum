$(function(){

	/* mobile util */
	var mo = {
		open : function(){
			mo.mbg('on');
			$('.mo_menu').stop().animate({'left': '0'}, 400, 'easeInOutQuad');
		},
		close : function(){
			mo.mbg('off');
			$('.mo_menu').stop().animate({'left':'-100%'}, 400, 'easeInOutQuad');
		},

		
		mbg : function(key){
			if(key == "on"){
				$('.mbg').stop().fadeIn(400);
			}else{
				$('.mbg').stop().fadeOut(400);
			}
		}
	}

	$('.mo_open').on('click',function(){
		mo.open();
	});
	$('.mo_close').on('click',function(){
		mo.close();
	});


	var vswiper = new Swiper('.vswiper',{
		items : 1,
		effect : 'fade',
		loop : true,
		
		autoplay : {
			delay : 4000,
			disableOnInteraction : false,
		},

		navigation: {
			nextEl: '.swiper-button-next',
			prevEl: '.swiper-button-prev',
		},
	});
	
	


	// bbs

	$('.sub_con:not(.qna) .bbs .list tr:not(.viewtr):not(.lock)').on('click',function(){
		var no = $(this).data('no');
		if($(this).hasClass('on')){
			$(this).removeClass('on');
			$('#v'+no).css('display','none');
		}else{
			$(this).addClass('on');
			$('#v'+no).css('display','table-row');
		}
	});


	$('.qna_pass > a, .qna_pass a.cancle').on('click',function(){
		$('.pop_bg').stop().fadeOut(400);
		$('.qna_pass').stop().fadeOut(400);
	});
	
	$('.qna_pass2 > a, .qna_pass2 a.cancle').on('click',function(){
		$('.pop_bg').stop().fadeOut(400);
		$('.qna_pass2').stop().fadeOut(400);
	});
	

	/////////////////////////////////////////////////////////////
	/*
	$body.find('.pop_calendar td').on('click','a', function(e){
		//pop 달력 애니메이션
		var _this = $(this);
		_this.closest('.calendar').find('td').removeClass('check-in-date');
		_this.parent('td').addClass('check-in-date');

	});
	*/
	//////////////////////////////////////////////////////////////////////////////
	

	$('#main .sc02 .intro ul li a').on('click',function(e){
		e.preventDefault();
		$('html, body').stop().animate({scrollTop : $(this.hash).offset().top}, 500, 'easeInOutCirc');
	});
	

	var notice_slide = new Swiper('#main .notice_slide' ,{
		slidesPerView : 1,
		direction : 'vertical',
		loop: true,
		autoplay : {
			delay : 500000,
			disableOnInteraction : false,
		},
		navigation: {
			nextEl: '#main .notice_wrap .swiper-button-next',
			prevEl: '#main .notice_wrap .swiper-button-prev',
		  }		
	});


	$('.all_menu').on('click', function(){
		$('.menu_all').stop().animate({'top':'0'},500);
		$('html').addClass('on');
	});

	$('.all_close').on('click', function(){
		$('.menu_all').stop().animate({'top':'-200%'},500);
		$('html').removeClass('on');
	});

	
	$(window).scroll(function(){
		var p = $(document).scrollTop();
		var top = $('#header').outerHeight();

		if(p > top){
			$('#header').addClass('on');			
		}else{
			$('#header').removeClass('on');
		}
	});

	$('.m_depth1 > li > a').on('click', function(){
		//$(this).css('border','1px solid red' );
		$(this).parent().siblings().children('a').removeClass('on');
		$(this).parent().siblings().find('.m_depth2').stop().slideUp(400);
		if($(this).hasClass('on')){
			$(this).removeClass('on');
			$(this).next().stop().slideUp(400);
		}else{
			$(this).addClass('on');
			$(this).next().stop().slideDown(400);
		}
	});

	

	$('.menu_depth2.partners ul li a').on('click',function(){
		if($(document).outerWidth() > 1024){
			$('html, body').stop().animate({scrollTop : ( $(this.hash).offset().top ) - 80 }, 500, 'easeInOutCirc');
		}else{
			$('html, body').stop().animate({scrollTop : ( $(this.hash).offset().top ) - 45 }, 500, 'easeInOutCirc');
		}
	});

	$('.menu_all .inner .tb .info .menu .depth2 > li > a').on('click', function(){
		$('.all_close').trigger('click');
	});

	$('.menu_all .mgnb .m_depth2 > li > a').on('click', function(){
		$('.all_close').trigger('click');
	});
	
	$('.menu_all .in_size .depth2 li a').on('click',function(){
		if($(document).outerWidth() > 1026){
			$('html, body').stop().animate({scrollTop : ( $(this.hash).offset().top ) - 80 }, 500, 'easeInOutCirc');
		}else{
			$('html, body').stop().animate({scrollTop : ( $(this.hash).offset().top ) - 45 }, 500, 'easeInOutCirc');
		}
	});



});




function r(cls){
	this.cls = '.'+cls;	
	this.setRound();
}

r.prototype.setRound = function(){
	this.wid = $(this.cls).find('.round').outerWidth();
	$(this.cls).find('.round').css({'height' : this.wid + 'px', 'border-radius' : this.wid + 'px'});
}




