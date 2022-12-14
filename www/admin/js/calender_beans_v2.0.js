/*
*	2011.11.13 make by beans9(ahmax95@gmail.com)
*	http://beans9.tistory.com
*/

var cssAddFlag = true;
function CalAddCss(){
		var cssHtml = "<style type='text/css'>";
		cssHtml += ".calLayout{	border:1px solid #DDDDDD; background-color:#ECEADF;	position:absolute;padding:2px;display:none;z-index:9999	}";			
		cssHtml += ".calTitle{ border:1px solid #D4D1BF; background-color: #ffffff; width:99%;	font-size:9pt;}";			
		cssHtml += ".calHeader{	padding:2px; padding-bottom:0px;text-align:center;}";
		cssHtml += ".calBody{padding:2px;padding-top:0px;text-align:center;	}";
		cssHtml += ".calDay{background-color: #FBFBFB;border:1px solid #CBC7BD;	width:20px;float:left;font-size:8pt;padding-top:3px;padding-bottom:2px;cursor:pointer;}";
		cssHtml += ".calSunDay{	background-color: #FBFBFB;border:1px solid #CBC7BD;	width:20px;float:left;font-size:8pt;padding-top:3px;padding-bottom:2px;cursor:pointer;color:red;}";
		cssHtml += ".calSatDay{ background-color: #FBFBFB;border:1px solid #CBC7BD;	width:20px;float:left;font-size:8pt;padding-top:3px;padding-bottom:2px;cursor:pointer;	color:blue;}";
		cssHtml += ".calOtherDay{background-color: #FBFBFB;	border:1px solid #CBC7BD;width:20px;float:left;font-size:8pt;padding-top:3px;padding-bottom:2px;cursor:pointer;color:#CBC7BD;}";
		cssHtml += ".dayToday{background-color: #368CFE;border:1px solid #CBC7BD;font-weight:bold;font-weight:bold;width:20px;float:left;font-size:8pt;padding-top:3px;padding-bottom:2px;cursor:pointer;color:white;	}";
		cssHtml += ".calSelDay{	background-color: #CF4040;border:1px solid #CBC7BD;font-weight:bold;width:20px;float:left;font-size:8pt;padding-top:3px;padding-bottom:2px;cursor:pointer;text-decoration:underline;color:white;}";
		cssHtml += ".dayEvMon{font-size:8pt;width:25px;	height:15px;background-color: #FBFBFB;border:1px solid #CBC7BD;	padding:4px 4px 0px 3px;float:left;cursor:pointer;}";		
		cssHtml += ".MonToday{font-size:8pt;width:25px;	height:15px;background-color: #368CFE;border:1px solid #CBC7BD;	font-weight:bold;padding:4px 4px 0px 3px;color:white;cursor:pointer;}";
		cssHtml += ".selMon{font-size:8pt;width:25px;height:15px;background-color: #CF4040;border:1px solid #CBC7BD;font-weight:bold;padding:4px 4px 0px 3px;text-decoration:underline;color:white;}";
		cssHtml += ".calOnDay{background-color: #006060;border:1px solid #4B22C0;float:left;cursor:pointer;color:white;}";
		cssHtml += ".calDaySpace{padding:1px;float:left;}";
		cssHtml += ".calDayBr{clear:both;height:2px;}";
		cssHtml += ".calDayTitle{padding-top:2px;width:22px;float:left;	font-size:8pt;}";			
		cssHtml += ".divHeadOnRigth{color:#18CCA8;cursor:pointer;}";
		cssHtml += ".todayBtn{clear:both;text-align: center;font-size:8pt;cursor:pointer;background-color: #FBFBFB;border:1px solid #CBC7BD;padding:4px 4px 0px 3px;height:15px;}";
		cssHtml += ".todayLay{padding-left:2px;}</style>";
		jQuery("head").append(cssHtml);
}

// ?????????			
function initCal(obj){
	if( cssAddFlag == true ){
		CalAddCss();
		cssAddFlag = false;
	}
	
	// id ??????
	var calId = "Cal" + obj.id;				
	
	// calendar type (day,mon)
	var calType = obj.type == null ? "day" : obj.type;				
	if( calType.toLowerCase() != "day" && calType.toLowerCase() != "mon"){
		calType = "day";
	}
	
	// ????????????, ???????????? 
	var minYear 	= obj.min == null ? "2000" : obj.min;
	// maxYear ?????? ?????? ??????
	var maxYear 	= obj.max == null ? new Date().getFullYear() + 2: obj.max;
	var splitKey 	= obj.splitKey == null ? "-" : obj.splitKey; 
	var todayYN		= obj.today == null ? "n" : "y";
	var iconYN		= obj.icon  == null ? "n" : "y";
	var iconUrl    = obj.iconUrl == null ? "/manage/img/calendar_btn.gif" : obj.iconUrl ;
	var timeYN		= obj.timeYN == null ? "n" : "y";

	// ?????? ????????????(?????????+?????????)?????????
	drawCalForm(calId,obj.id,calType,minYear,maxYear,todayYN,iconYN,iconUrl);
	
	if( calType == "day"){
		jQuery("#"+obj.id).attr("maxlength",timeYN == "y" ? 21 : 10);
		jQuery("#"+calId).css("width","170px");
		jQuery("#"+calId +"btn.todayBtn").css("width","157px");							
	}else{
		jQuery("#"+obj.id).attr("maxlength",7);
		jQuery("#"+calId).css("width","146px");
		jQuery("#"+calId +"btn.todayBtn").css("width","133px");
	}

	
	// input box??? click event 
	jQuery("#"+ calId + "Icon").click(function(event){	
		var datesVal = jQuery("#"+obj.id).val();
		if( calType == "mon") datesVal += splitKey + '1';
		
		var dates = isValidCheck(datesVal ,splitKey, timeYN);
		if( calType == "day"){
			makeCal(calId,dates,splitKey,timeYN);
		}else{
			makeCalMon(calId,dates,splitKey);
		}
		calPosition(obj.id,calId);																					
		jQuery("#"+calId).show();
		
	});
	
	// ?????? ?????? ????????? ???????????????
	jQuery(document).click(function(event){
		var parentEls = jQuery( event.target).parents().map(function () { return this.id; }).get().join(", ");
		if(parentEls.indexOf(calId+",") == -1 && event.target.id != obj.id && parentEls.indexOf(calId+"Icon,")){
			jQuery("#"+calId).hide();
		}
	});
	
	jQuery(window).resize(function(event){
		calPosition(obj.id,calId);
	});
	
	// ???????????? ??????/?????? ?????? ??????
	jQuery("#"+calId+"before,#"+calId+"next").click(function(event){
		var plus = -1;
		if(this.id.indexOf("next") > -1){ var plus = 1; }
		
		if( calType == "day"){
			var dates = calDate(jQuery("#"+ calId + "selYear").val(),jQuery("#"+calId + "selMon").val(),plus,isValidCheck(jQuery("#"+obj.id).val(),splitKey, timeYN));					
			if((dates[0] >= minYear && plus == -1) || (dates[0] <= maxYear && plus == 1)){
				makeCal(calId,dates,splitKey,timeYN);
			}	
		}else{
			var dates = calDate(jQuery("#"+ calId + "selYear").val(),'1',plus*12,isValidCheck(jQuery("#"+obj.id).val()+splitKey+'1',splitKey, timeYN));
			if((dates[0] >= minYear && plus == -1) || (dates[0] <= maxYear && plus == 1)){
				makeCalMon(calId,dates,splitKey);
			}
		}					 
	}).mouseover(function(){
		jQuery(this).addClass("divHeadOnRigth");
	}).mouseout(function(){
		jQuery(this).removeClass("divHeadOnRigth");
	});;
	
	// ??????????????? ????????????
	if( calType == "day"){
		// ??????,??? selectbox ????????? ?????????
		jQuery("#"+calId+"selYear,#"+calId+"selMon").change(function(event){
			var dates = calDate(jQuery("#"+ calId + "selYear").val(),jQuery("#"+calId + "selMon").val(),0,isValidCheck(jQuery("#"+obj.id).val(),splitKey, timeYN));
			makeCal(calId,dates,splitKey, timeYN);
		});	
	}else{
		jQuery("#"+calId+"selYear").change(function(event){
			var dates = calDate(jQuery("#"+ calId + "selYear").val(),1,0,isValidCheck(jQuery("#"+obj.id).val()+splitKey+'1',splitKey, timeYN));					
			makeCalMon(calId,dates,splitKey);
		});	
	}
	
	jQuery("#"+calId+"btn").click(function(){
		jQuery("#"+obj.id).val("");
		var dates = isValidCheck('',splitKey, timeYN);
		if( calType == 'day'){
			makeCal(calId,dates,splitKey,timeYN);
		}else{
			makeCalMon(calId,dates,splitKey);
		}
	});
	
	calPosition(obj.id,calId);
}

//?????? ?????????
function calClickEvent(id){
	jQuery("#" + id + " .calOtherDay,.calDay,.calSunDay,.calSatDay,.MonToday,.selMon,.dayEvMon").click(function(event) {
        jQuery("#" + id.substring(3)).val(this.id.replace(id,""));
		jQuery("#" + id).hide();
	}).mouseover(function(){
		jQuery(this).addClass("calOnDay");
	}).mouseout(function(){
		jQuery(this).removeClass("calOnDay");
	});
} 

// ?????? ??? ????????? 
function drawCalForm(id,tId,calType,min,max,todayYN,iconYN,imageUrl){ // tId = ?????????ID					
	
	if(iconYN == "y"){
		jQuery(document.body).append("<div id='"+ id +"Icon' style='position:absolute; cursor:pointer; z-index:10000;'><img id='"+ id +"IconImg' src='"+ imageUrl +"'><div>");
	}
	
	// layout
	jQuery(document.body).append("<div id='"+ id +"' onselectstart='return false' class='calLayout'><div>");
	
	// ?????? ???,??? ?????? 
	var html  = "<div class='calTitle'><table width='100%'><tr><td id='"+ id +"before' width='10%'  style='font-size: 10px'>???</td><td width='80%' align='center'>";
		
	// ?????????
	html += "<select id='"+ id +"selYear'>";
    for(var i=min;i<=max;i++){ html += "<option value=" + i + ">" + i + "</option>"; }
	html += "</select>"
	
	// ????????? (??????????????? ????????????)
	if( calType == "day"){
		html += "<select id='"+ id +"selMon'>";
	    for(var i=1;i<=12;i++){ html += "<option value=" + i + ">" + i + "???</option>"; }
		html += "</select>"						
	}
	
	html += "</td><td id='"+ id +"next' width='10%' style='font-size: 10px'>???</td></tr></table></div>";
	if( calType == "day" )html += "<div id='" + id + "Header' class='calHeader'></div>";
	html += "<div id='" + id + "Content' class='calBody'></div>";
	
	if( todayYN == "y"){
		html += "<div class='todayLay'><div id='" + id + "btn' class='todayBtn'>Today</div></div>";
	}
		
	jQuery("#"+id).html(html);				
	
	// ????????? (??????????????? ????????????)
	if (calType == "day") {
		var tempHtml = ""; 
		var yoil = ["???", "???", "???", "???", "???", "???", "???"];
		for (i = 0; i < 7; i++) {
			tempHtml += "<div class='calDayTitle'>" + yoil[i] + "</div>";
			if (i == 6) { tempHtml += "<div class='calDayBr'></div>"; }
			else { tempHtml += "<div class='calDaySpace'></div>"; }
		}
		jQuery("#" + id + "Header").append(tempHtml);
	}		
	
		
}

// ????????????(?????????) ???????????? ?????????
function makeCal(id,dates,splitKey,timeYN){				
	var timeTF = timeYN == "y" ? true : false;
	
	// ????????? ????????????,??????????????? 
	var firstDay  = new Date(dates[0],eval(dates[1]-1),1).getDay();
	
	// ????????? ???????????????
	var lastDate 	= new Date(dates[0],eval(dates[1]),0);
	var lastDateNum = lastDate.getDate();
	var lastDay     = lastDate.getDay();
	
	// ????????? ???????????????
	var beforeMonDate	= new Date(dates[0],eval(dates[1]-1),0);
	var beforeMonLastDay = beforeMonDate.getDate();
	var beforeYearMonText = beforeMonDate.getFullYear() + splitKey + strFormat(beforeMonDate.getMonth()+1) + splitKey;
	
	var nextMonDate	= new Date(dates[0],eval(dates[1]),1);
	var nextYearMonText = nextMonDate.getFullYear() + splitKey + strFormat(nextMonDate.getMonth()+1) + splitKey;
	  
	var nowYearMonText = dates[0] + splitKey + strFormat(dates[1]) + splitKey;
	
	var ndate = new Date();
	var today;
	if(timeTF){
		today = ndate.getFullYear() + splitKey + strFormat(ndate.getMonth()+1) + splitKey + strFormat(ndate.getDate()) + " " + strFormat(ndate.getHours()) + ":" + strFormat(ndate.getMinutes()) + ":" + strFormat(ndate.getSeconds());
	} else {
		today = ndate.getFullYear() + splitKey + strFormat(ndate.getMonth()+1) + splitKey + strFormat(ndate.getDate());
	}

	//-----------------------------------------------------	
	var html = "";				
	var brCount = 1; // ????????? count
	
	// before month
	for( i = 1; i<=firstDay; i++){
		html += "<div class='calOtherDay' id='"+ id + beforeYearMonText + (beforeMonLastDay-(firstDay-i)) +"'>"+ (beforeMonLastDay-(firstDay-i)) + "</div><div class='calDaySpace'></div>";
		brCount ++;					
	}	
					
	// now month
	for (i = 1; i <= lastDateNum; i++) {					
		var dayCss = "calDay";				
		if (brCount % 7 == 1) { dayCss = "calSunDay" ; }
		else if(brCount % 7 == 0){ dayCss = "calSatDay" ; }
		
		if(timeTF){
			html += "<div class='"+ dayCss +"' id='"+ id + nowYearMonText + strFormat(i) + " " + strFormat(ndate.getHours()) + ":" + strFormat(ndate.getMinutes()) + ":" + strFormat(ndate.getSeconds()) + ".0" +"'>" + i + "</div>";
		}else{
			html += "<div class='"+ dayCss +"' id='"+ id + nowYearMonText + strFormat(i) +"'>" + i + "</div>";
		}
		
		if( brCount %7 == 0 && i != lastDateNum ){ html += "<div class='calDayBr'></div>"; }
		else{ html += "<div class='calDaySpace'></div>"; }
		brCount ++;
	}
	
	// next month
	var nexyStartDay = 1;
	for( i = lastDay; i<6; i++){
		html += "<div class='calOtherDay' id='" +id + nextYearMonText + strFormat(nexyStartDay) +"'>"+ nexyStartDay++ + "</div><div class='calDaySpace'></div>";
	}
	
	// ?????? ??????
	jQuery("#" + id + "Content").html(html);
	
	// ?????? select ??????
	jQuery("#" + id + "selYear").val(dates[0]);
	
	// ??????????????? ?????? ??? select ??????
	jQuery("#" + id + "selMon").val(eval(dates[1]));
	
	// ???????????? ??????
	jQuery("#" + id+ today).addClass("dayToday");
	
	// ???????????? ??????
	if(dates[4] == true){
		jQuery("#" +id + dates[3]).addClass("calSelDay");					
		// ??????????????? ????????? ????????? input??? ???????????? ????????? ?????? ??????
		jQuery("#" + id.substring(3)).val(dates[3]);
	} 
	
	calClickEvent(id);
}

function makeCalMon(id,dates,splitKey){
	var nowYeaText = dates[0] + splitKey;
	
	var ndate = new Date();
	var today = ndate.getFullYear() + splitKey + strFormat(ndate.getMonth()+1);
	
	var html = "<div class='calDayBr'></div><div class='calDayBr'></div>";				
	for(var i=1;i<13;i++){
		html += "<div class='dayEvMon' id='"+ id + nowYeaText + strFormat(i) +"'>" + i + "</div>";
		if( i %4 == 0 && i != 12){ html += "<div class='calDayBr'></div>"; }
		else{
			html += "<div class='calDaySpace'></div>"; 
		}
	}				
	// ?????? ??????
	jQuery("#" + id + "Content").html(html);				
	// ?????? select ??????
	jQuery("#" + id + "selYear").val(dates[0]);
	
	// ???????????? ??????
	jQuery("#" + id + today).addClass("MonToday");
	
	// ???????????? ??????
	if(dates[4] == true){
		jQuery("#" +id + dates[3].substring(0,7)).addClass("selMon");
		
		// ??????????????? ????????? ????????? input??? ???????????? ????????? ?????? ??????
		jQuery("#" + id.substring(3)).val( dates[3].substring(0,7));
	} 
	
	calClickEvent(id);
}

// ?????? ????????? ??????
function isValidCheck(strDate,splitKey,timeYN,todayCheck){
	var timeTF = timeYN == "y" ? true : false;
	
	var date = strDate;

	var dates;
	var times;
	if(timeTF){
		times = date.substr(date.indexOf(" ")+1,8).split(":");
		dates = date.substr(0,date.indexOf(" ")).split(splitKey);
	} else {
		dates = date.split(splitKey);
	}

	var idate;
	if(timeTF){
		idate = new Date(dates[0],eval(dates[1])-1,eval(dates[2]),times[0],times[1],times[2],0);
	} else {
		idate = new Date(dates[0],eval(dates[1])-1,eval(dates[2]));
	}
	var ndate = new Date();
	
	var isValid = true;
	if( dates[0] != idate.getFullYear()) isValid = false;  
	else if( eval(dates[1])-1 != idate.getMonth()) isValid = false; 
	else if( eval(dates[2]) != idate.getDate()) isValid = false;
	if(timeTF){
		if( times[0] != idate.getHours()) isValid = false;  
		else if( times[1] != idate.getMinutes()) isValid = false; 
		else if( times[2] != idate.getSeconds()) isValid = false;
	}

	if( isValid == false ){
		dates[0] = ndate.getFullYear();
		dates[1] = strFormat(ndate.getMonth()+1);
		dates[2] = strFormat(ndate.getDate());
		if(timeTF){
			times[0] = strFormat(ndate.getHours());
			times[1] = strFormat(ndate.getMinutes());
			times[2] = strFormat(ndate.getSeconds());
		}
	}	
	
	if(timeTF){
		dates[3] = dates[0] +splitKey + strFormat(dates[1]) + splitKey + strFormat(dates[2]) + " " + strFormat(times[0]) + ":" + strFormat(times[1]) + ":" + strFormat(times[2]) + ".0";
	}else{
		dates[3] = dates[0] +splitKey + strFormat(dates[1]) + splitKey + strFormat(dates[2]);
	}
	dates[4] = isValid;
	return dates;
}	

function calDate(year,month,adjust,isValidDate){
	var date = new Date(year,(month-1)+adjust,1);
	var dates = [date.getFullYear(),date.getMonth()+1,date.getDate(),isValidDate[3],isValidDate[4]];
	return dates;
}

// ?????? format ?????????
function strFormat(str){
	if((str+"").length == 1) str = "0" + str;
	return str;				
}

// ??????????????????		
function calPosition(target,id){
	var tInput  = jQuery("#" + target).offset();
	var tHeight = jQuery("#" + target).outerHeight();
	var tWidth 	= jQuery("#" + target).outerWidth();
	
	var calHeight 	= jQuery("#" + id).outerHeight();
	
	if( tInput != null){
		jQuery("#" + id).css({"top":tInput.top+tHeight , "left":tInput.left});
		jQuery("#" + id + "Icon").css({"top":tInput.top+1,"left":tInput.left+tWidth+2});
	}
}