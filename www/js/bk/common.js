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

	/*메인 비주얼 슬라이드 사용시 주석해제*/
	/*
	var swiper_main = new Swiper('.swiper_main',{
		items : 1,
		loop : false,
		
		autoplay : {
			delay : 4000,
			disableOnInteraction : false,
		},
		pagination : {
			el : '.swiper_main .swiper-pagination',		
		}
	});
	

	$('.thumbnail ul > li a').on('click', function(){
		$('.thumbnail ul > li').siblings().find('a').removeClass('on');
		$(this).addClass('on');
	});

	swiper_main.on('slideChange',function(){
		$('.thumbnail ul > li').find('a').removeClass('on');
		var idx = swiper_main.activeIndex;
		$('.thumbnail ul > li').eq(idx).find('a').addClass('on');		
	});
	*/

	$('#b1').on('click', function(){
	  	swiper_main.slideTo(0);
	});
	$('#b2').on('click', function(){
	  	swiper_main.slideTo(1);
	});
	$('#b3').on('click', function(){
	  	swiper_main.slideTo(2);
	});


	$('.fam_site > a').on('click',function(){
		if($(this).hasClass('on')){
			$(this).removeClass('on');
			$('.fam_site ul').slideUp();
		}else{
			$(this).addClass('on');
			$('.fam_site ul').slideDown();
		}
	});

	var prize_slide = new Swiper('.prize_slide',{
		slidesPerView : 4,
		slidesPerGroup : 1,
		spaceBetween : 15,
		loop: false,

		autoplay : {
			delay : 4000,
			disableOnInteraction : false,
		},
		navigation: {
			nextEl: '.prize .swiper-button-next',
			prevEl: '.prize .swiper-button-prev',
		  },
		breakpoints : {
			860 : {
				slidesPerView : 2,
				spaceBetween : 10
			},
			520 : {
				slidesPerView : 1,
				spaceBetween : 0
			}
		}
		
	});

	
	var b_slide = new Swiper('.b_slide',{
		items : 1,
		loop : true,		
		autoHeight: true,
		autoplay : {
			delay : 4000,
			disableOnInteraction : false,
		},			
		navigation: {
			nextEl: '#b2 .con_wrap .swiper-button-next',
			prevEl: '#b2 .con_wrap .swiper-button-prev',
		}		
	});


	var no1 = new Swiper('.no1',{
		items : 1,
		loop : false,		
		autoplay : {
			delay : 4000,
			disableOnInteraction : false,
		},			
		navigation: {
			nextEl: '.no1 .swiper-button-next',
			prevEl: '.no1 .swiper-button-prev',
		},
		pagination : {
			el : '.no1 .swiper-pagination',
			type : 'fraction'
		}
	});

	var no2 = new Swiper('.no2',{
		items : 1,
		loop : false,		
		autoplay : {
			delay : 4000,
			disableOnInteraction : false,
		},			
		navigation: {
			nextEl: '.no2 .swiper-button-next',
			prevEl: '.no2 .swiper-button-prev',
		},
		pagination : {
			el : '.no2 .swiper-pagination',
			type : 'fraction'
		}
	});

	var no3 = new Swiper('.no3',{
		items : 1,
		loop : false,		
		autoplay : {
			delay : 4000,
			disableOnInteraction : false,
		},			
		navigation: {
			nextEl: '.no3 .swiper-button-next',
			prevEl: '.no3 .swiper-button-prev',
		},
		pagination : {
			el : '.no3 .swiper-pagination',
			type : 'fraction'
		}
	});

	var no4 = new Swiper('.no4',{
		items : 1,
		loop : false,		
		autoplay : {
			delay : 4000,
			disableOnInteraction : false,
		},			
		navigation: {
			nextEl: '.no4 .swiper-button-next',
			prevEl: '.no4 .swiper-button-prev',
		},
		pagination : {
			el : '.no4 .swiper-pagination',
			type : 'fraction'
		}
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
			delay : 5000,
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

	$('.language > a').on('click',function(){		
		if($('#header').hasClass('on')){
			$('.language').toggleClass('over');
		}else{			
		}

		if($(this).hasClass('on')){
			$(this).removeClass('on');
			$(this).parent().stop().animate({'height':'30px'},100,'easeInOutQuad');
			
		}else{				
			$(this).addClass('on');
			$(this).parent().stop().animate({'height':'60px'},100,'easeInOutQuad');
		}
	});

	
	$(window).scroll(function(){
		var p = $(document).scrollTop();
		var top = $('#header').outerHeight();

		if(p > top){
			$('#header').addClass('on');		
		/*	if($('.language > a').hasClass('on')){
				$('.language').css({'top': '50%', 'margin-top':'-30px'});
			}else{
				$('.language').css({'top': 'inherit', 'margin-top':'25px'});
			}*/
			if($('.language').outerHeight() > 30){
				$('.language').addClass('over');

			}
		}else{
			$('#header').removeClass('on');
			$('.language').removeClass('over');

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

	
	/*
	$('.menu_depth2.partners ul li a').on('click',function(){
		if($(document).outerWidth() > 1024){
			$('html, body').stop().animate({scrollTop : ( $(this.hash).offset().top ) - 80 }, 500, 'easeInOutCirc');
		}else{
			$('html, body').stop().animate({scrollTop : ( $(this.hash).offset().top ) - 45 }, 500, 'easeInOutCirc');
		}
	});*/

	$('.menu_all .inner .tb .info .menu .depth2 > li > a').on('click', function(){
		$('.all_close').trigger('click');
	});

	$('.menu_all .mgnb .m_depth2 > li > a').on('click', function(){
		$('.all_close').trigger('click');
	});

	$('#main .notice .top_txt a.upDown').on('click', function(){
		$(this).parent().parent().siblings().removeClass('on');
		$(this).parent().parent().siblings().find('.swiper-container').stop().slideUp(400);		

		if($(this).parent().parent().hasClass('on')){
			$(this).parent().parent().removeClass('on');
			$(this).parent().parent().find('.swiper-container').stop().slideUp(400);
		}else{
			$(this).parent().parent().addClass('on');
			$(this).parent().parent().find('.swiper-container').stop().slideDown(400);
		}
		/*var idx = $(this).parent().parent().index();	*/	
	});

	$('#main .notice .top_txt > p').on('click', function(){
		$(this).parent().parent().siblings().removeClass('on');
		$(this).parent().parent().siblings().find('.swiper-container').stop().slideUp(400);		

		if($(this).parent().parent().hasClass('on')){
			$(this).parent().parent().removeClass('on');
			$(this).parent().parent().find('.swiper-container').stop().slideUp(400);
		}else{
			$(this).parent().parent().addClass('on');
			$(this).parent().parent().find('.swiper-container').stop().slideDown(400);
		}
		/*var idx = $(this).parent().parent().index();	*/	
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




