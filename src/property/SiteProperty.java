package property;

public class SiteProperty {
	/*
	 * 기본정보
	 */
	/**
	 * 업체명
	 */
	public static final String 	COMPANY_NAME			= "한국네트워크산업협회";
	/**
	 * 관리자 시작페이지
	 */
	public static final String	INDEX_PAGE				= "/";
	/**
	 * 보안서버인증서(SSL)사용여부
	 */
	public static final boolean	SSL_USE					= false;
	//public static final boolean	SSL_USE					= true;
	/**
	 * URL http
	 */
	public static final String 	COMPANY_URL				= "http://nfvforum.sanggong.net:8080";
	//public static final String 	COMPANY_URL				= "https://sdnnfv.org";

	/**
	 * URL https SSL
	 */
	public static final String 	COMPANY_SSL_URL			= "https://nfvforum.sanggong.net:8080";
	//public static final String 	COMPANY_SSL_URL			= "https://sdnnfv.org";
	public static final String 	COMPANY_SSL_URL_MO		= "https://m.nfvforum.sanggong.net";
	//public static final String  CREATE_YEAR             = "2020";
	
	public static final String MEMBER_EXCEL_PATH        = "D:\\jsphome\\nfvforum\\www\\upload\\member\\";
	//public static final String MEMBER_EXCEL_PATH        = "/kaniorkr1234/tomcat/webapps/ROOT/upload/member/";
	
	public static final String COMMITTEE_EXCEL_PATH     = "D:\\jsphome\\nfvforum\\www\\upload\\committee\\";
	//public static final String COMMITTEE_EXCEL_PATH     = "/kaniorkr1234/tomcat/webapps/ROOT/upload/committee/";

	
	/**
	 * mysql 비밀번호 암호화 방식
	 * password, old_password, md5, sha
	 */
	public static final String	DB_ENCRYPTION			= "password";
	/**
	 * 대표 이메일
	 */
	//public static final String 	COMPANY_EMAIL			= "nhkim@kani.or.kr";
	public static final String 	COMPANY_EMAIL			= "sdnnfv21@gmail.com";
	//public static final String 	COMPANY_EMAIL			= "sanggongdev@sanggong.co.kr";

	/*
	 * 메일관련
	 */
	/**
	 * 메일서버
	 */
	//public static final String 	SMTP_HOST				= "mail.kani.or.kr";
	public static final String 	SMTP_HOST				= "smtp.gmail.com";
	//public static final String 	SMTP_HOST				= "smtp.cafe24.com";
	//public static final String 	SMTP_HOST				= "smtp.naver.com";
	/**
	 * 메일계정 아이디
	 */
	public static final String 	SMTP_USER				= "sdnnfv21@gmail.com";
	//public static final String 	SMTP_USER				= "sanggongdev@sanggong.co.kr";
	//public static final String 	SMTP_USER				= "sanggong0102@naver.com";
	
	/**
	 * 메일계정 패스워드
	 */
	public static final String 	SMTP_PASSWORD			= "!kani1234";
	//public static final String 	SMTP_PASSWORD			= "tkdrhd1121!";
	/**
	 * 이메일 기본 폼
	 */
	
	public static final String 	EMAIL_FORM				= "/include/emailForm.jsp"; // 기본폼
	public static final String 	EMAIL_FORM1				= "/include/emailForm1.jsp"; // 회원사 알림용

	/**
	 * 에디터 이미지 업로드 경로
	 */
	public static final String	EDITOR_UPLOAD_PATH		= "/upload/editor/";

	/**
	 * 에디터 이미지 업로드 용량제한
	 */
	public static final int		EDITOR_MAXSIZE 			= 50*1024*1024;

	/**
	 * 처리페이지 (process.jsp)에서 레퍼러(이전페이지값) 비교여부
	 */
	public static final boolean	CHECK_REFERER			= true;
	
	/**
	 * 관리자 접속시 아이피 체크 true -> 체크, false -> 미체크
	 */
	public static final boolean	ADMIN_IP_CHECK			= true;

	public static final String	REFERER_URL				= "nfvforum";
	//public static final String	REFERER_URL				= "sdnnfv";
	
	public static final String LOGIN_AFTER_PAGE = "/index.jsp";	// 로그인 후 페이지
	public static final String START_PAGE = "/admin/environment/admin/index.jsp";	// 관리자 로그인 후 첫페이지
	
	
	public static boolean getCHECK_REFERER(){
		return CHECK_REFERER;
	}
	
	public static String getREFERER_URL(){
		return REFERER_URL;
	}
	

}
