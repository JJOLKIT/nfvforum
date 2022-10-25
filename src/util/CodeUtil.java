package util;

/**
 * 각종 코드값 가져오기 각 코드들의 option, select 값 구하기
 * 
 * @author withsky
 *
 */
public class CodeUtil {

	/**
	 * 관리자 등급
	 * 
	 * @param type
	 *            int
	 * @return option Html
	 */
	public static String getGradeName(int type) {
		String result = "";
		switch (type) {
		case 1:
			result = "1등급관리자";
			break;
		case 2:
			result = "2등급관리자";
			break;
		case 3:
			result = "3등급관리자";
			break;
		}
		return result;
	}

	/**
	 * 관리자 등급 option
	 * 
	 * @param type
	 *            int
	 * @return option Html
	 */
	public static String getGrade(int type) {
		StringBuffer result = new StringBuffer();
		for (int i = 1; i <= 3; i++) {
			result.append("<option value=" + i + " "
					+ Function.getSelected(i, type) + ">"
					+ CodeUtil.getGradeName(i) + "</option>");
		}
		return result.toString();
	}
	
	/**
	 * 사이트
	 * @param type
	 * @return option Html
	 */
	public static String getSite(Object type) {
		String result = "";
		
		if ("1".equals(Function.parseStr(type))) {
			result = "방문보육";
		} else if ("2".equals(Function.parseStr(type))) {
			result = "베이비케어";
		} else if ("3".equals(Function.parseStr(type))) {
			result = "맘멘토링";
		}
		return result;
	}

	/**
	 * 사이트 option
	 * @param type
	 * @return option Html
	 */
	public static String getSiteOption(Object type) {
		StringBuffer result = new StringBuffer();
		for (int i = 1; i <= 3; i++) {
			result.append("<option value=" + i + " "
					+ Function.getSelected(i, Function.getIntParameter(Function.parseStr(type))) + ">"
					+ CodeUtil.getSite(i) + "</option>");
		}
		return result.toString();
	}
	
	/**
	 * 회원분류
	 * @param type
	 * @return option Html
	 */
	public static String getUserType(Object type) {
		String result = "";
		
		if ("01".equals(type)) {
			result = "부모";
		} else if ("02".equals(type)) {
			result = "교사";
		}
		return result;
	}

	/**
	 * 회원분류 option
	 * @param type
	 * @return option Html
	 */
	public static String getUserTypeOption(Object type) {
		StringBuffer result = new StringBuffer();
		result.append("<option value=01 "
				+ Function.getSelected("01", (Function.parseStr(type))) + ">"
				+ CodeUtil.getUserType("01") + "</option>");
		result.append("<option value=02 "
				+ Function.getSelected("02", (Function.parseStr(type))) + ">"
				+ CodeUtil.getUserType("02") + "</option>");
		return result.toString();
	}
	
	/**
	 * 회원분류
	 * @param type
	 * @return option Html
	 */
	public static String getUserStatus(Object type) {
		String result = "";
		
		if ("01".equals(type)) {
			result = "가입중";
		} else if ("02".equals(type)) {
			result = "해지";
		}
		return result;
	}

	/**
	 * 회원분류 option
	 * @param type
	 * @return option Html
	 */
	public static String getUserStatusOption(Object type) {
		StringBuffer result = new StringBuffer();
		result.append("<option value=01 "
				+ Function.getSelected("01", (Function.parseStr(type))) + ">"
				+ CodeUtil.getUserStatus("01") + "</option>");
		result.append("<option value=02 "
				+ Function.getSelected("02", (Function.parseStr(type))) + ">"
				+ CodeUtil.getUserStatus("02") + "</option>");
		return result.toString();
	}
	
	/**
	 * 게시판 노출여부
	 * @param type
	 * @return option Html
	 */
	public static String getDisplay(Object arg) {
		String result = "";
		String type = Function.parseStr(arg);
		
		if ("0".equals(type)) {
			result = "노출";
		} else if ("1".equals(type)) {
			result = "미노출";
		}
		return result;
	}

	/**
	 * 게시판 노출여부 option  
	 * @param type
	 * @return option Html
	 */
	public static String getDisplayOption(Object arg) {
		String type = Function.parseStr(arg);
		StringBuffer result = new StringBuffer();
		result.append("<option value=0 "
				+ Function.getSelected("0", (Function.parseStr(type))) + ">"
				+ CodeUtil.getDisplay("0") + "</option>");
		result.append("<option value=1 "
				+ Function.getSelected("1", (Function.parseStr(type))) + ">"
				+ CodeUtil.getDisplay("1") + "</option>");
		return result.toString();
	}
	
	/**
	 * 공지사항 구분
	 * @param type
	 * @return option Html
	 */
	public static String getCategory(Object arg) {
		String result = "";
		String type = Function.parseStr(arg);
		
		if ("1".equals(type)) {
			result = "공지";
		} else if ("2".equals(type)) {
			result = "뉴스";
		} else if ("3".equals(type)) {
			result = "보도";
		} else if ("4".equals(type)) {
			result = "언론";
		} else if ("5".equals(type)) {
			result = "홍보";
		}
		return result;
	}

	/**
	 * 공지사항 구분 option
	 * @param type
	 * @return option Html
	 */
	public static String getCategoryOption(Object arg) {
		StringBuffer result = new StringBuffer();
		String type = Function.parseStr(arg);
		result.append("<option value=1 "
				+ Function.getSelected("1", (Function.parseStr(type))) + ">"
				+ CodeUtil.getCategory("1") + "</option>");
		result.append("<option value=2 "
				+ Function.getSelected("2", (Function.parseStr(type))) + ">"
				+ CodeUtil.getCategory("2") + "</option>");
		result.append("<option value=3 "
				+ Function.getSelected("3", (Function.parseStr(type))) + ">"
				+ CodeUtil.getCategory("3") + "</option>");
		result.append("<option value=4 "
				+ Function.getSelected("4", (Function.parseStr(type))) + ">"
				+ CodeUtil.getCategory("4") + "</option>");
		result.append("<option value=5 "
				+ Function.getSelected("5", (Function.parseStr(type))) + ">"
				+ CodeUtil.getCategory("5") + "</option>");
		return result.toString();
	}
	
	/**
	 * FAQ 구분
	 * @param type
	 * @return option Html
	 */
	public static String getFaqCategory(Object arg) {
		String result = "";
		String type = Function.parseStr(arg);
		
		if ("1".equals(type)) {
			result = "맘멘토링";
		} else if ("2".equals(type)) {
			result = "육아뜰";
		} else if ("3".equals(type)) {
			result = "돌봄교실";
		}
		return result;
	}

	/**
	 * FAQ 구분 option
	 * @param type
	 * @return option Html
	 */
	public static String getFaqCategoryOption(Object arg) {
		StringBuffer result = new StringBuffer();
		String type = Function.parseStr(arg);
		result.append("<option value=1 "
				+ Function.getSelected("1", (Function.parseStr(type))) + ">"
				+ CodeUtil.getFaqCategory("1") + "</option>");
		result.append("<option value=2 "
				+ Function.getSelected("2", (Function.parseStr(type))) + ">"
				+ CodeUtil.getFaqCategory("2") + "</option>");
		result.append("<option value=3 "
				+ Function.getSelected("3", (Function.parseStr(type))) + ">"
				+ CodeUtil.getFaqCategory("3") + "</option>");
		return result.toString();
	}
	
	/**
	 * 답변여부
	 * @param type
	 * @return option Html
	 */
	public static String getAnswer(Object arg) {
		String result = "";
		String type = Function.parseStr(arg);
		
		if (!"".equals(type) && !"<p></p>".equals(type)) {
			result = "완료";
		} else {
			result = "대기";
		}
		return result;
	}
	
	/**
	 * @param type
	 * @return option Html
	 */
	public static String getPartnerCategoryName(Object arg) {
		String result = "";
		String type = Function.parseStr(arg);
		
		if ("1".equals(type)) {
			result = "주요고객";
		} else if ("2".equals(type)) {
			result = "후원기관";
		}
		return result;
	}
	
	public static String getNoticeCategoryName(Object arg) {
		String result = "";
		String type = Function.parseStr(arg);
		
		if ("1".equals(type)) {
			result = "소식전달";
		} else if ("2".equals(type)) {
			result = "공지사항";
		}
		return result;
	}

	public static String geYoilName(int i) {
		String dayname = "";
		switch (i) {
		case 2:
			dayname = "월";
			break;
		case 3:
			dayname = "화";
			break;
		case 4:
			dayname = "수";
			break;
		case 5:
			dayname = "목";
			break;
		case 6:
			dayname = "금";
			break;
		}
		return dayname;
	}
	
	public static String getTechCategoryName(int i) {
		String result = "";
		if(i == 1) {
			result = "기술표준분과";
		}else if(i == 2) {
			result = "CNMN WG";
		}else if(i == 3) {
			result = "표준화 WG";
		}else if(i == 4) {
			result = "보안기술 WG";
		}else if(i == 5) {
			result = "P4 WG";
		}
		
		
		return result;
	}
	
	public static String getTechCategoryOption(Object arg) {
		StringBuffer result = new StringBuffer();
		String type = Function.parseStr(arg);
		result.append("<option value=''>선택</option>");
		for(int i = 1; i <= 5 ; i++) {
			result.append("<option value='"+i+"' "+Function.getSelected(Function.parseStr(i), type)+">"+CodeUtil.getTechCategoryName(i)+"</option>");
		}
		
		return result.toString();
	}
	
	public static String getPocCategoryName(int i) {
		String result = "";
		if(i == 1) {
			result = "ONOS/CORD WG";
		}else if(i == 2) {
			result = "P4 Application WG";
		}else if(i == 3) {
			result = "NFV WG";
		}else if(i == 4) {
			result = "OCP WG";
		}else if(i == 5) {
			result = "Open Wireless Access WG";
		}else if(i == 6) {
			result = "Q-kaaS WG";
		}
		
		return result;
	}
	
	public static String getPocCategoryOption(Object arg) {
		StringBuffer result = new StringBuffer();
		String type = Function.parseStr(arg);
		result.append("<option value=''>선택</option>");
		for(int i = 1; i <= 6 ; i++) {
			result.append("<option value='"+i+"' "+Function.getSelected(Function.parseStr(i), type)+">"+CodeUtil.getPocCategoryName(i)+"</option>");
		}
		
		return result.toString();
	}
	
	
	public static String getCommitteeCategoryName(int i ) {
		String result = "";
		
		if(i == 1) {
			result = "운영위원회";
		}else if(i == 6) {
			result = "자문위원회";
		}else if(i == 2) {
			result = "기술표준분과";
		}else if(i == 3) {
			result = "정책협력분과";
		}else if(i == 4) {
			result = "대외협력분과";
		}else if(i == 5) {
			result = "서비스PoC분과";
		}
		
		return result;
	}
	
	public static String getCommitteeCategoryOption(Object arg) {
		StringBuffer result = new StringBuffer();
		String type = Function.parseStr(arg);
		result.append("<option value=''>선택</option>");
		
		
			result.append("<option value='"+1+"' "+Function.getSelected(Function.parseStr(1), type)+">"+CodeUtil.getCommitteeCategoryName(1)+"</option>");
			result.append("<option value='"+6+"' "+Function.getSelected(Function.parseStr(6), type)+">"+CodeUtil.getCommitteeCategoryName(6)+"</option>");
		
		 
		for(int i = 2; i <= 5 ; i++) {
					
			result.append("<option value='"+i+"' "+Function.getSelected(Function.parseStr(i), type)+">"+CodeUtil.getCommitteeCategoryName(i)+"</option>");
			/*
			if(i == 1) {
				result.append("<option value='"+6+"' "+Function.getSelected(Function.parseStr(6), type)+">"+CodeUtil.getCommitteeCategoryName(6)+"</option>");
			}			
			*/
		}

		
		return result.toString();
	}
	
	public static String getMemberGradeName(int i) {
		String result = "";
		
		if(i == 1) {
			result = "일반";
		}else if(i == 2) {
			result = "회원사";
		}else if(i == 3) {
			result = "회원사(대기)";
		}else if(i == 4) {
			result = "운영위원";
		}
		
		return result;
	}
	
	public static String getMemberGradeOption(Object arg) {
		StringBuffer result = new StringBuffer();
		String type = Function.parseStr(arg);
		result.append("<option value=''>선택</option>");
		for(int i = 1; i <= 4 ; i++) {
			result.append("<option value='"+i+"' "+Function.getSelected(Function.parseStr(i), type)+">"+CodeUtil.getMemberGradeName(i)+"</option>");
		}
		
		return result.toString();
	}
	
	
	public static String getMemberStateName(int i) {
		String result = "";
		
		if(i == 1) {
			result = "전체";
		}else if(i == 2) {
			result = "회원";
		}else if(i == 3) {
			result = "탈퇴신청";
		}
		
		return result;
	}
	
	public static String getMemberStateOption(Object arg) {
		StringBuffer result = new StringBuffer();
		String type = Function.parseStr(arg);
		result.append("<option value=''>선택</option>");
		for(int i = 1; i <= 3 ; i++) {
			result.append("<option value='"+i+"' "+Function.getSelected(Function.parseStr(i), type)+">"+CodeUtil.getMemberStateName(i)+"</option>");
		}
		
		return result.toString();
	}
	

	// 시간간격 (1시간 간격)
	public static String getTimeList2(Object arg) {
		StringBuffer result = new StringBuffer();
		String type = Function.parseStr(arg);
		

		result.append("<option value=\"00:00:00\" "+Function.getSelected("00:00:00", type)+">00:00</option>");
		result.append("<option value=\"00:30:00\" "+Function.getSelected("00:30:00", type)+">00:30</option>");
		result.append("<option value=\"01:00:00\" "+Function.getSelected("01:00:00", type)+">01:00</option>");
		result.append("<option value=\"01:30:00\" "+Function.getSelected("01:30:00", type)+">01:30</option>");
		result.append("<option value=\"02:00:00\" "+Function.getSelected("02:00:00", type)+">02:00</option>");
		result.append("<option value=\"02:30:00\" "+Function.getSelected("02:30:00", type)+">02:30</option>");
		result.append("<option value=\"03:00:00\" "+Function.getSelected("03:00:00", type)+">03:00</option>");
		result.append("<option value=\"03:30:00\" "+Function.getSelected("03:30:00", type)+">03:30</option>");
		result.append("<option value=\"04:00:00\" "+Function.getSelected("04:00:00", type)+">04:00</option>");
		result.append("<option value=\"04:30:00\" "+Function.getSelected("04:30:00", type)+">04:30</option>");
		result.append("<option value=\"05:00:00\" "+Function.getSelected("05:00:00", type)+">05:00</option>");
		result.append("<option value=\"05:30:00\" "+Function.getSelected("05:30:00", type)+">05:30</option>");
		result.append("<option value=\"06:00:00\" "+Function.getSelected("06:00:00", type)+">06:00</option>");
		result.append("<option value=\"06:30:00\" "+Function.getSelected("06:30:00", type)+">06:30</option>");
		result.append("<option value=\"07:00:00\" "+Function.getSelected("07:00:00", type)+">07:00</option>");
		result.append("<option value=\"07:30:00\" "+Function.getSelected("07:30:00", type)+">07:30</option>");
		result.append("<option value=\"08:00:00\" "+Function.getSelected("08:00:00", type)+">08:00</option>");
		result.append("<option value=\"08:30:00\" "+Function.getSelected("08:30:00", type)+">08:30</option>");
		result.append("<option value=\"09:00:00\" "+Function.getSelected("09:00:00", type)+">09:00</option>");
		result.append("<option value=\"09:30:00\" "+Function.getSelected("09:30:00", type)+">09:00</option>");
		result.append( "<option value=\"10:00:00\" "+Function.getSelected("10:00:00", type)+">10:00</option>");
		result.append( "<option value=\"10:30:00\" "+Function.getSelected("10:30:00", type)+">10:30</option>");
		result.append("<option value=\"11:00:00\" "+Function.getSelected("11:00:00", type)+">11:00</option>");
		result.append("<option value=\"11:30:00\" "+Function.getSelected("11:30:00", type)+">11:30</option>");
		result.append("<option value=\"12:00:00\" "+Function.getSelected("12:00:00", type)+">12:00</option>");
		result.append("<option value=\"12:30:00\" "+Function.getSelected("12:30:00", type)+">12:30</option>");
		result.append("<option value=\"13:00:00\" "+Function.getSelected("13:00:00", type)+">13:00</option>");
		result.append("<option value=\"13:30:00\" "+Function.getSelected("13:00:00", type)+">13:30</option>");
		result.append("<option value=\"14:00:00\" "+Function.getSelected("14:00:00", type)+">14:00</option>");
		result.append("<option value=\"14:30:00\" "+Function.getSelected("14:30:00", type)+">14:30</option>");
		result.append("<option value=\"15:00:00\" "+Function.getSelected("15:00:00", type)+">15:00</option>");
		result.append("<option value=\"15:30:00\" "+Function.getSelected("15:30:00", type)+">15:30</option>");
		result.append("<option value=\"16:00:00\" "+Function.getSelected("16:00:00", type)+">16:00</option>");
		result.append("<option value=\"16:30:00\" "+Function.getSelected("16:30:00", type)+">16:30</option>");
		result.append("<option value=\"17:00:00\" "+Function.getSelected("17:00:00", type)+">17:00</option>");
		result.append("<option value=\"17:30:00\" "+Function.getSelected("17:30:00", type)+">17:30</option>");
		result.append("<option value=\"18:00:00\" "+Function.getSelected("18:00:00", type)+">18:00</option>");
		result.append("<option value=\"18:30:00\" "+Function.getSelected("18:30:00", type)+">18:30</option>");
		result.append( "<option value=\"19:00:00\" "+Function.getSelected("19:00:00", type)+">19:00</option>");
		result.append( "<option value=\"19:30:00\" "+Function.getSelected("19:30:00", type)+">19:30</option>");
		result.append("<option value=\"20:00:00\" "+Function.getSelected("20:00:00", type)+">20:00</option>");
		result.append("<option value=\"20:30:00\" "+Function.getSelected("20:30:00", type)+">20:30</option>");
		result.append("<option value=\"21:00:00\" "+Function.getSelected("21:00:00", type)+">21:00</option>");
		result.append("<option value=\"21:30:00\" "+Function.getSelected("21:30:00", type)+">21:30</option>");
		result.append("<option value=\"22:00:00\" "+Function.getSelected("22:00:00", type)+">22:00</option>");
		result.append("<option value=\"22:30:00\" "+Function.getSelected("22:30:00", type)+">22:30</option>");
		result.append("<option value=\"23:00:00\" "+Function.getSelected("23:00:00", type)+">23:00</option>");
		result.append("<option value=\"23:30:00\" "+Function.getSelected("23:30:00", type)+">23:30</option>");

		return result.toString();
	}
	
	
	public static String getDisplayName(int i) {
		String result = "";
		
		if(i == 1) {
			result = "노출";
		}else if(i == 2) {
			result = "미노출";
		}
		
		return result;
	}
	
	
}
