$(function () {
	"use strict";

	var isMain = $('#main').length;
	var $window = $(window);
	var sizeMobile;
	var $breadcrumb = '.sub_navi dd > a';
	var isExistTable = $('.table_ranking').length;
	//	var tooltipButton = '.scheduled';
	//var tooltip = '.scheduled_tooltip';
	var $btnClose = $('.close_tooltip');

	var init = function () {
		ieVersion();
		goToTopHandler();
		//activeHandler($breadcrumb);
		//tooltipHandler(tooltipButton, tooltip);
		sizeMobile = $window.width();
		navigationHandler(sizeMobile);
		if (isExistTable > 0) {
			datatableHandler();
		}
		if (isMain > 0) {
			main();
		}
	}

	var ieVersion = function () {
		var ua = window.navigator.userAgent;
		var msie = ua.indexOf("MSIE ");
		if (msie > 0) {
			$('body').addClass('ie_' + parseInt(ua.substring(msie + 5, ua.indexOf(".", msie))));
		}
		return false;
	}

	var navigationHandler = function (size) {

		var menu = {
			hamburger: $('.hamburger'),
			header: $('#header'),
			nav: $('.nav_wrap dl')
		};

		if (size < 1025) {
			/* mobile hamburger */
			menu.hamburger.off('click').on('click', function () {
				menu.header.toggleClass('open');
				$('html,body').toggleClass('fixed');
			});

			/* mobile menu */
			menu.nav.find('dt a').off('click').on('click', function (e) {
				e.preventDefault();
				var $parent = $(this).parents('dl');
				$parent.siblings('dl').removeClass('active').find('dd').slideUp(300);
				$parent.toggleClass('active').find('dd').stop().slideToggle(300);
			});
		} else {
			menu.hamburger.off('click');
			menu.nav.find('dt a').off('click');
			menu.nav.find('dd').removeAttr('style');
		}
	};

	var goToTopHandler = function () {
		var $elm = $('.go_to_top');
		$elm.on('click', function () {
			$('html, body').stop().animate({ scrollTop: 0 }, 300);
		});
	}

	$window.on('resize', function () {
		sizeMobile = $window.width();
		navigationHandler(sizeMobile);
		/* if (isMain > 0) {
		 	main.memberSlide();
		} */
	});

	var main = function () {

		var $mainSlide = $('.visual_wrap');
		var $mainGallery = $('.main_photo');
		var $memberSlide = $('.member_carousel');

		var mainInit = function () {
			mainSlide();
			mainGallery();
			main.memberSlide();
			//galleryBox($mainGallery);
		}

		var owlOption = {
			center: true,
			autoplay: true,
			autoplaySpeed: 300,
			autoplayTimeout: 7000,
			autoplayHoverPause: true,
			mouseDrag: false,
			loop: true,
			nav: true,
			dots: true,
			items: 1,
			lazyLoad: true,
		}

		var mainSlide = function () {
			owlSlide($mainSlide, owlOption);
		}

		var mainGallery = function () {
			owlOption.margin = 15;
			owlOption.dots = false;
			owlOption.responsive = {
				0: {
					items: 1,
					stagePadding: 10
				},
				480: {
					items: 2,
					stagePadding: 10
				},
				1024: {
					items: 3,
					stagePadding: 100
				},
				1280: {
					items: 3
				},
			}

			owlSlide($mainGallery, owlOption);
		}

		main.memberSlide = function () {
			owlOption.stagePadding = 0;
			owlOption.center = false;
			owlOption.mouseDrag = true;
			owlOption.margin = 10;
			owlOption.responsive = { 0: { items: 1, }, 365: { items: 2, }, 700: { items: 3, }, 860: { items: 4, }, 1024: { items: 5, }, 1280: { items: 6 } };
			owlSlide($memberSlide, owlOption);
		}

		mainInit();

		return {
			memberSlide: main.memberSlide
		}
	}

	var owlSlide = function ($elm, options, callback) {
		var $owl = $elm;
		$owl.owlCarousel(options);
	};
	
	/*
	var galleryBox = function ($elm) {
		$elm.magnificPopup({
			delegate: 'a',
			type: 'image',
			closeOnContentClick: false,
			closeBtnInside: true,
			mainClass: 'mfp-with-zoom mfp-img-mobile',
			image: {
				verticalFit: true,
				titleSrc: function (item) {
					//console.log(item.el[0].children[0].querySelector('img').innerHTML);
					return item.el[0].children[0].querySelector('span').innerHTML;
				}
			},
			gallery: {
				enabled: true,
				tCounter: ''
			},
			zoom: {
				enabled: true,
				duration: 200,
				opener: function (element) {
					//console.log(element.find('img'));
					return element.find('img');
				}
			}
		})
	};
	*/

	/*
	var tooltipHandler = function ($btn, $tooltip) {
		//$($btn).on('mouseover click', function () {
		//	$(this).find($tooltip).addClass('active');			
		//});

		$($btn).on('mouseout', function (e) {
			$(this).find($tooltip).removeClass('active');

			var wid = $(document).outerWidth();
			if(wid <= 1024  && $(e.target).find($($tooltip)).legnth !== 0 && $(e.target) == $('p') ){
				console.log(e.target);
			//	$btnClose.css('display','none');
			}

			
		});

		$($btn).on('mousemove', function (e) {
			var mouseX = (e.clientX > $window.width() / 2) ? e.clientX - $($tooltip).width() * 1.3 : e.clientX;
			var mouseY = e.clientY;
			$($tooltip).css({ left: mouseX + 'px' })
			$($tooltip).css({ top: mouseY + 'px' })
			
			$btnClose.css('left', mouseX + $($tooltip).width() - 30 + 'px');
			$btnClose.css('top', mouseY - 25  + 'px');

			var wid = $(document).outerWidth();
			
			if(wid <= 1024 && $(e.target).find($($tooltip)).length !== 0 ){
				$btnClose.css('display','block');
			}else{
				$btnClose.css('display','none');
			}

		});

		$(document).on('click', function (e) {
			//console.log($(e.target));
			if ($(e.target).closest($btn).length === 0 || $(e.target) === $btnClose ) {
				$($tooltip).removeClass('active');
				$btnClose.css('display','none');
			}
		});

	}


	var activeHandler = function ($elm) {
		$(document).on('click', function (e) {
			if ($(e.target).closest($elm).length === 0) {
				$($elm).removeClass('active');
	
			}
		})
		$($elm).on('click', function (e) {
			e.preventDefault();
			var $this = $(this);
			$this.toggleClass('active');
		});
	}
	*/

	var datatableHandler = function () {
		var $datatable = $('.table_ranking');
		$datatable.DataTable({
			"scrollY": "900px",
			"scrollCollapse": true,
			"paging": false,
			"autoWidth": true,
			"info": false,
			"language": {
				"zeroRecords": "검색 결과가 없습니다.",
				"search": "",
				"searchPlaceholder": "검색어를 입력하세요"
			},
			"responsive": true
		});
	}

	init();

	$('.js-mainMenu').on('click',function(){
		if($(this).hasClass('on')){
			$(this).removeClass('on');
			$(this).next().stop().slideDown(400);
		}else{
			$(this).addClass('on');
			$(this).next().stop().slideUp(400);
		}
	});

	$('.subnav_depth_2_text').on('click',function(){
		if($(this).hasClass('on')){
			$(this).removeClass('on');
			$(this).next().stop().slideDown(400);
		}else{
			$(this).addClass('on');
			$(this).next().stop().slideUp(400);
		}
	});

	$('.u_email').on('change',function(){
		$('.u_email2').val($(this).val());
	});


	$('.m_nav > a').on('click',function(){
		if($(this).hasClass('on')){
			//$(this).removeClass('on');
			$(this).next().stop().slideUp(400);
		}else{
			//$(this).addClass('on');
			$(this).next().stop().slideDown(400);
		}
	});

	$('.m_nav ul li').on('click',function(){
		$('.top_view').text( $(this).children().text() );
		//$('.top_view').removeClass('on');
		$(this).parents('ul').stop().slideUp(400);
	});

	$('.main_gallery .owl-item').on('click',function(e){
		
		var src = $(this).find('.pic').data('src');
		var date = $(this).find('.pic').data('date');
		var title = $(this).find('.dimmed em').text();

		$('.gal_pop .pic').css('background-image','url('+src+')');
		$('.gal_pop .txt b').html(title);
		$('.gal_pop .txt span').html(date);
		
		

		/*
		console.log($(event.target).context.children[0].innerText);
		console.log($(event.target).context.children[1].innerText);
		console.log($(event.target).context.parentNode.parentElement.href);
		console.log($(event.target).context.parentElement.nextElementSibling.style.backgroundImage);
		*/
		
		//console.log($(event.target).context.parentElement.href);
		//console.log($(event.target).context.style.backgroundImage.substring( 5,($(event.target).context.style.backgroundImage).length-2));
		
		/*var bg = $(this).css('background-image');
        bg = bg.replace('url(','').replace(')','').replace(/\"/gi, "");
        console.log(bg);*/
		
		
		/*var aTagPath = $(event.target).context.parentElement.href;
		var imagePath = "$(event.target).context.style.backgroundImage.substring( 5,($(event.target).context.style.backgroundImage).length-2)";
		var titleData = "";
		var contentsData = "";*/
		
		$('.gal_pop').stop().fadeIn(400);
	});
		
	$('.gal_close').on('click',function(){
		$('.gal_pop').stop().fadeOut(400);
	});

	
	popPosition();
	$('.calendar_table .sch_td').on('click',function(){
		if($(this).find('dl.info2').length > 0){
			var frInfo = $(this).find('dl.info2').clone();
			$('.cal_pop .info2').html( frInfo );
			$('.cal_pop').stop().fadeIn(400);		
		}
	});

	$('.cal_close').on('click',function(){
		$(this).parent().stop().fadeOut(400);
	});

});




function popPosition(){
	var boxHeight = $('.cal_pop').outerHeight();
	var boxPosition = Number ('-'+ boxHeight / 2 ) + 'px';
	$('.cal_pop').css('margin-top',boxPosition);	
}