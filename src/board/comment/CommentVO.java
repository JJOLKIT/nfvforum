package board.comment;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;

import property.SiteProperty;
import util.BeanUtils;
import util.Function;
import util.Parameter;

public class CommentVO extends Parameter {

	private int no;
	private int parent_fk;
	private int member_fk;
	private String password;
	private String name;
	private String contents;
	private Timestamp registdate;
	private String url;				// process.jsp 처리 후 돌아갈 페이지

	/**
	 * 생성자 페이지로우수 세팅
	 * @param pageRows 페이지 로우수
	 */
	public CommentVO(int pageRows, String tablename, int parent_fk) {
		super.setPageRows(pageRows);
		super.setDb_encryption(SiteProperty.DB_ENCRYPTION);
		if (!"".equals(tablename)) super.setTablename(tablename);
		this.setParent_fk(parent_fk);
	}

	/**
	 * request 파라미터 객체 바인드
	 * @param pageRows
	 * @param request
	 * @throws Exception
	 */
	public static CommentVO getParam(int pageRows, String tablename, HttpServletRequest request) throws Exception {
		CommentVO param = new CommentVO(pageRows, tablename, Function.getIntParameter(request.getParameter("no")));
		param = (CommentVO)BeanUtils.bind(request, param);
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
	public static CommentVO getParam(int pageRows, String tablename, HttpServletRequest request, String uploadPath, int maxSize) throws Exception {
		CommentVO param = new CommentVO(pageRows, tablename, Function.getIntParameter(request.getParameter("no")));
		param = (CommentVO)BeanUtils.bind(request, param, uploadPath, maxSize);
		return param;
	}
	public CommentVO() {
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getParent_fk() {
		return parent_fk;
	}

	public void setParent_fk(int parent_fk) {
		this.parent_fk = parent_fk;
	}

	public int getMember_fk() {
		return member_fk;
	}

	public void setMember_fk(int member_fk) {
		this.member_fk = member_fk;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContents() {
		return Function.RegexReplace(contents);
	}

	public void setContents(String contents) {
		this.contents = Function.RegexReplace(contents);
	}

	public Timestamp getRegistdate() {
		return registdate;
	}

	public void setRegistdate(Timestamp registdate) {
		this.registdate = registdate;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}



}
