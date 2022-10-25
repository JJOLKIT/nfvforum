package email;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;

import board.notice.NoticeVO;
import util.*;

public class MailVO extends Parameter {

	private int no;						// PK
    private String sendman;				// 보내는사람
    private String receiveman;				// 보내는사람
    private String title;				// 제목
    private String contents;			// 내용
    private String filename;			// 파일명1
    private String filename2;			// 파일명2
    private String filename3;			// 파일명3
    private String filename_org;		// 파일명1
    private String filename2_org;		// 파일명2
    private String filename3_org;		// 파일명3

    private long filesize;				// 파일사이즈1
    private long filesize2;				// 파일사이즈2
    private long filesize3;				// 파일사이즈3

    private Timestamp registdate;		// 발송일
    private int totalcount;				// 총발송자수
    
    //검색 조건 - 회원 검색 메일 발송 시에 필요//
	private int sgender;				// 성별검색
	private int sbranch_fk;			// 지점검색
	private int sconsultnum;			// 상담횟수
	private int sresernum;				// 예약횟수
	private int sage;					// 연령별검색
	private int ssecession;				// 탈퇴여부검색
	private int sissms;					// sms수신여부
	private int sisemail;				// email 수신여부
	private String sdatetype;			// 날짜검색타입
	private String sstartdate;			// 시작일
	private String senddate;			// 종료일
    
    private String startday;
    private String endday;
    private String listtablename;
    
    private int emailpop;
    
	public MailVO() {
	}
	
	/**
	 * 생성자 페이지로우수 세팅
	 * @param pageRows 페이지 로우수
	 */
	public MailVO(int pageRows, String tablename, String listtablename) {
		this.ssecession = -1;
		this.sissms = -1;
		this.sisemail = -1;
		this.sresernum = -1;
		this.sconsultnum = -1;
		this.sage = -1;
		this.sdatetype = "";
		this.sstartdate = "";
		this.senddate = "";		
		this.startday = "";
		this.endday = "";
		super.setPageRows(pageRows);
		super.setTablename(tablename);
		this.setListtablename(listtablename);
	}
	
	/**
	 * request 파라미터 객체 바인드
	 * @param pageRows
	 * @param request
	 * @throws Exception
	 */
	public static MailVO getParam(int pageRows, String tablename, String listtablename, HttpServletRequest request) throws Exception {
		MailVO param = new MailVO(pageRows, tablename, listtablename);
		param = (MailVO)BeanUtils.bind(request, param);
		return param;
	}
	
	/**
	 * Multipart 바인드
	 * @param pageRows
	 * @param request
	 * @param uploadPath
	 * @param maxSize
	 * @return
	 * @throws Exception
	 */
	public static MailVO getParam(int pageRows, String tablename, String listtablename, HttpServletRequest request, String uploadPath, int maxSize) throws Exception {
		MailVO param = new MailVO(pageRows, tablename, listtablename);
		param = (MailVO)BeanUtils.bind(request, param, uploadPath, maxSize);
		return param;
	}


	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getSendman() {
		return sendman;
	}

	public void setSendman(String sendman) {
		this.sendman = sendman;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return Function.RegexReplace(contents);
	}

	public void setContents(String contents) {
		this.contents = Function.RegexReplace(contents);
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getFilename2() {
		return filename2;
	}

	public void setFilename2(String filename2) {
		this.filename2 = filename2;
	}

	public String getFilename3() {
		return filename3;
	}

	public void setFilename3(String filename3) {
		this.filename3 = filename3;
	}

	public long getFilesize() {
		return filesize;
	}

	public void setFilesize(long filesize) {
		this.filesize = filesize;
	}

	public long getFilesize2() {
		return filesize2;
	}

	public void setFilesize2(long filesize2) {
		this.filesize2 = filesize2;
	}

	public long getFilesize3() {
		return filesize3;
	}

	public void setFilesize3(long filesize3) {
		this.filesize3 = filesize3;
	}

	public Timestamp getRegistdate() {
		return registdate;
	}

	public void setRegistdate(Timestamp registdate) {
		this.registdate = registdate;
	}

	public int getTotalcount() {
		return totalcount;
	}

	public void setTotalcount(int totalcount) {
		this.totalcount = totalcount;
	}

	public String getStartday() {
		return startday;
	}

	public void setStartday(String startday) {
		this.startday = startday;
	}

	public String getEndday() {
		return endday;
	}

	public void setEndday(String endday) {
		this.endday = endday;
	}

	public String getListtablename() {
		return listtablename;
	}

	public void setListtablename(String listtablename) {
		this.listtablename = listtablename;
	}

	public String getFilename_org() {
		return filename_org;
	}

	public void setFilename_org(String filename_org) {
		this.filename_org = filename_org;
	}

	public String getFilename2_org() {
		return filename2_org;
	}

	public void setFilename2_org(String filename2_org) {
		this.filename2_org = filename2_org;
	}

	public String getFilename3_org() {
		return filename3_org;
	}

	public void setFilename3_org(String filename3_org) {
		this.filename3_org = filename3_org;
	}

	public String getReceiveman() {
		return receiveman;
	}

	public void setReceiveman(String receiveman) {
		this.receiveman = receiveman;
	}

	public int getSgender() {
		return sgender;
	}

	public void setSgender(int sgender) {
		this.sgender = sgender;
	}

	public int getSbranch_fk() {
		return sbranch_fk;
	}

	public void setSbranch_fk(int sbranch_fk) {
		this.sbranch_fk = sbranch_fk;
	}

	public int getSconsultnum() {
		return sconsultnum;
	}

	public void setSconsultnum(int sconsultnum) {
		this.sconsultnum = sconsultnum;
	}

	public int getSresernum() {
		return sresernum;
	}

	public void setSresernum(int sresernum) {
		this.sresernum = sresernum;
	}

	public int getSage() {
		return sage;
	}

	public void setSage(int sage) {
		this.sage = sage;
	}

	public int getSsecession() {
		return ssecession;
	}

	public void setSsecession(int ssecession) {
		this.ssecession = ssecession;
	}

	public int getSissms() {
		return sissms;
	}

	public void setSissms(int sissms) {
		this.sissms = sissms;
	}

	public int getSisemail() {
		return sisemail;
	}

	public void setSisemail(int sisemail) {
		this.sisemail = sisemail;
	}

	public String getSdatetype() {
		return sdatetype;
	}

	public void setSdatetype(String sdatetype) {
		this.sdatetype = sdatetype;
	}

	public String getSstartdate() {
		return sstartdate;
	}

	public void setSstartdate(String sstartdate) {
		this.sstartdate = sstartdate;
	}

	public String getSenddate() {
		return senddate;
	}

	public void setSenddate(String senddate) {
		this.senddate = senddate;
	}

	public int getEmailpop() {
		return emailpop;
	}

	public void setEmailpop(int emailpop) {
		this.emailpop = emailpop;
	}

}
