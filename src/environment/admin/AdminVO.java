package environment.admin;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;

import util.BeanUtils;
import util.Parameter;

public class AdminVO extends Parameter {

	private int no;					// 번호
	private String id;				// 아이디
	private String password;		// 패스워드
	private String email;
	private String name;			// 이름
	private String memo;			// 메모
	private String tel;				// 전화번호
	private int grade;				// 관리자등급
	private int type;				// 재직/퇴사 구분
	private Timestamp registdate;	// 등록일
	
	private Timestamp logindate;	// 로그인일자
	private String ip;				// 접속 아이피
	private int prev_no;			// 이전글 no
	private int next_no;			// 다음글 no
	private String prev_title;		// 이전글 제목
	private String next_title;		// 다음글 제목

	private int admin_fk;			// 관리자아이피테이블 fk
	
	public AdminVO() {}
	/**
	 * 생성자 페이지로우수 세팅
	 * @param pageRows 페이지 로우수
	 */
	public AdminVO(int pageRows) {
		super.setPageRows(pageRows);
	}

	/**
	 * request 파라미터 객체 바인드
	 * @param pageRows
	 * @param request
	 * @throws Exception
	 */
	public static AdminVO getParam(int pageRows, HttpServletRequest request) throws Exception {
		AdminVO param = new AdminVO(pageRows);
		param = (AdminVO)BeanUtils.bind(request, param);
		return param;
	}
	
	public int getAdmin_fk() {
		return admin_fk;
	}
	public void setAdmin_fk(int admin_fk) {
		this.admin_fk = admin_fk;
	}
	public int getNo() {
		return no;
	}
	public String getId() {
		return id;
	}
	public String getPassword() {
		return password;
	}
	public String getEmail() {
		return email;
	}
	public String getName() {
		return name;
	}
	public String getMemo() {
		return memo;
	}
	public Timestamp getRegistdate() {
		return registdate;
	}
	public Timestamp getLogindate() {
		return logindate;
	}
	public String getIp() {
		return ip;
	}
	public int getPrev_no() {
		return prev_no;
	}
	public int getNext_no() {
		return next_no;
	}
	public String getPrev_title() {
		return prev_title;
	}
	public String getNext_title() {
		return next_title;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public void setRegistdate(Timestamp registdate) {
		this.registdate = registdate;
	}
	public void setLogindate(Timestamp logindate) {
		this.logindate = logindate;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public void setPrev_no(int prev_no) {
		this.prev_no = prev_no;
	}
	public void setNext_no(int next_no) {
		this.next_no = next_no;
	}
	public void setPrev_title(String prev_title) {
		this.prev_title = prev_title;
	}
	public void setNext_title(String next_title) {
		this.next_title = next_title;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}

}
