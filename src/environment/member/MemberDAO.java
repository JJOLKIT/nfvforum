package environment.member;

import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.log4j.Logger;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.ibatis.sqlmap.client.SqlMapClient;

import db.SqlConfigiBatis;
import util.Function;
import util.Page;
import util.PasswordUtil;


public class MemberDAO {

	private Logger logger = Logger.getLogger(getClass());
	public static MemberDAO instance;
	public static SqlMapClient sqlMapper;
	/**
	 * instance, sqlMapper 생성
	 * @return instance
	 */
	public static MemberDAO getInstance() {
		if (instance == null) { 
			instance = new MemberDAO();
		}
		sqlMapper = SqlConfigiBatis.getInstance().getSqlMapper();
		return instance;
	}
	
	public String getTargetURLParam(String pageUrl, HashMap<String, Object> hm, String index) throws Exception{

		StringBuffer strList= new StringBuffer();

		if (hm != null) {
			strList.append(pageUrl);
			strList.append("?reqPageNo="+hm.get("reqPageNo"));
			
			if(!"".equals(Function.checkNull(Function.parseStr(hm.get("stype"))))){
				strList.append("&stype=" + Function.parseStr(hm.get("stype")));
			}
			if(!"".equals(Function.checkNull(Function.parseStr(hm.get("sval"))))){
				strList.append("&sval="+URLEncoder.encode(Function.parseStr(hm.get("sval")),"UTF-8"));
			}
			if(!"".equals(Function.checkNull(Function.parseStr(hm.get("cmd"))))){
				strList.append("&cmd="+Function.parseStr(hm.get("cmd")));
			}
			if (!"0".equals(index)) {
				strList.append("&USER_KEY="+index);
			}
		}
		return strList.toString();
	}

	public int[] count(HashMap<String, Object> param) throws SQLException {
		int rowCount = (Integer)sqlMapper.queryForObject("member.count", param);
		int[] rowPageCount = new int[2];
		int pageCount = Page.getPageCount(Function.getIntParameter(String.valueOf(param.get("pageRows"))), rowCount);
		rowPageCount[0] = rowCount;
		rowPageCount[1] = pageCount;
		return rowPageCount;
	}
	

	/**
	 * 관리자 목록 조회
	 * @param param
	 * @return ArrayList<AdminVO>
	 * @throws SQLException
	 */
	
	public ArrayList list(HashMap<String, Object> param) throws SQLException {
		ArrayList list = (ArrayList)sqlMapper.queryForList("member.list", param);
		return list;
	}

	/**
	 * 관리자 등록
	 * @param vo
	 * @return no 마지막 등록된 no
	 * @throws SQLException
	 */
	public int insert(HashMap<String, Object> param) throws SQLException {
		int no = (Integer) sqlMapper.insert("member.insert", param);
		return no;
	}

	/**
	 * 관리자 수정
	 * @param vo
	 * @throws SQLException
	 */
	public int update(HashMap<String, Object> param) throws SQLException {
		if (param.get("USER_PWD") != null && !"".equals(param.get("USER_PWD"))) {
			PasswordUtil pu = new PasswordUtil();
			param.put("USER_PWD", pu.encode(Function.parseStr(param.get("USER_PWD"))));
		}
		return sqlMapper.update("member.update", param);
	}
	
	public int tempPassword(HashMap<String, Object> param) throws SQLException {
		if (param.get("USER_PWD") != null && !"".equals(param.get("USER_PWD"))) {
			PasswordUtil pu = new PasswordUtil();
			param.put("USER_PWD", pu.encode(Function.parseStr(param.get("USER_PWD"))));
		}
		return sqlMapper.update("member.tempPassword", param);
	}

	/**
	 * 관리자 삭제
	 * @param no
	 * @throws SQLException
	 */
	public int delete(int no) throws SQLException {
		return sqlMapper.delete("member.delete", no);
	}

	/**
	 * 관리자 상세
	 * @param no
	 * @return
	 * @throws SQLException
	 */
	public HashMap<String, Object> read(int no) throws SQLException {
		HashMap<String, Object> vo = (HashMap<String, Object>)sqlMapper.queryForObject("member.read", no);
		return vo;
	}

	/**
	 * 관리자 로그인체크
	 * id, password로 조회 후 존재하면 true 리턴
	 * @param id
	 * @param password
	 * @return boolean
	 * @throws SQLException
	 */
	public boolean loginCheck(HashMap<String, Object> param) throws SQLException {
		int cnt = (Integer)sqlMapper.queryForObject("member.loginCheck", param);
		logger.info("여기가 로그인");
		boolean result = false;
		if (cnt == 1) {
			result = true;
		}
		return result;
	}

	public HashMap<String, Object> getLoginSessionInfo(HashMap<String, Object> param) throws SQLException {
		
		HashMap<String, Object> hm = (HashMap<String, Object>) sqlMapper.queryForObject("member.loginSessionInfo", param);
		return hm;
	}

	/**
	 * 관리자 접속 기록 rowPageCount
	 * @param param
	 * @return rowPageCount배열 (전체로우수, 페이지수)
	 * @throws SQLException
	 */
	public int[] countLoginHistory(HashMap<String, Object> param) throws SQLException {
		int rowCount = (Integer)sqlMapper.queryForObject("member.countLoginHistory", param);
		int[] rowPageCount = new int[2];
		int pageCount = Page.getPageCount(Function.getIntParameter(String.valueOf(param.get("pageRows"))), rowCount);
		rowPageCount[0] = rowCount;
		rowPageCount[1] = pageCount;
		return rowPageCount;
	}
	
	public ArrayList listLoginHistory(HashMap<String, Object> param) throws SQLException {
		ArrayList list = (ArrayList)sqlMapper.queryForList("member.listLoginHistory", param);
		return list;
	}
	
	public void insertLoginHistory(HashMap<String, Object> param) throws SQLException {
		sqlMapper.insert("member.insertLoginHistory", param);
	}

	/**
	 * 관리자 아이디체크
	 * @param param
	 * @return
	 * @throws SQLException
	 */
	public int idcheck(HashMap<String, Object> param) throws SQLException {
		return (Integer) sqlMapper.queryForObject("member.idcheck", param);
	}
	
	public static void main(String[] args) throws Exception {
		MemberDAO ad = MemberDAO.getInstance();
		HashMap<String, Object> param = new HashMap();
		param.put("reqPageNo", 1);
		param.put("pageRows", 10);
		param.put("startPageNo", Function.getStartPageNo(Function.getIntParameter(String.valueOf(param.get("reqPageNo"))), Function.getIntParameter(String.valueOf(param.get("pageRows")))));
//		av.setStype("all");
//		av.setSval("test");
		
//		int[] rowPageCount = ad.count(param);
//		System.out.println(rowPageCount[0]);
//		System.out.println(rowPageCount[1]);
//		
//		ad.list(param);
//		
//		System.out.println(Function.getIntParameter(String.valueOf("")));
		
		param.put("id", "sanggong");
		param.put("password", "sanggong1121!");
		System.out.println(ad.loginCheck(param));
		
		HashMap hm = new HashMap();
		hm.put("id", "sanggong");
		hm.put("password", "sanggong1121!");
		HashMap adminInfo = ad.getLoginSessionInfo(hm);
		ad.insertLoginHistory(adminInfo);
		
		
	}

}
