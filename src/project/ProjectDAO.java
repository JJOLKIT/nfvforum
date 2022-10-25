package project;

import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import com.ibatis.sqlmap.client.SqlMapClient;

import db.SqlConfigiBatis;
import util.Function;
import util.Page;

public class ProjectDAO {

	private static ProjectDAO instance;
	private static SqlMapClient sqlMapper;

	/**
	 * instance, sqlMapper 생성
	 * @return instance
	 */
	public static ProjectDAO getInstance() {
		if (instance == null) {
			instance = new ProjectDAO();
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
			if(!"".equals(Function.checkNull(Function.parseStr(hm.get("scategory"))))){
				strList.append("&scategory="+Function.parseStr(hm.get("scategory")));
			}
			if(!"".equals(Function.checkNull(Function.parseStr(hm.get("sdisplay"))))){
				strList.append("&sdisplay="+Function.parseStr(hm.get("sdisplay")));
			}
			if (!"0".equals(index)) {
				strList.append("&no="+index);
			}
		}
		return strList.toString();
	}

	/**
	 * 총 글 수, 총 글 페이지
	 * @param vo
	 * @return rowPageCount Integer[]
	 * @throws SQLException
	 */
	public int[] count(HashMap<String, Object> vo) throws SQLException {
		int rowCount = (Integer)sqlMapper.queryForObject("project.count", vo);
		int[] rowPageCount = new int[2];
		int pageCount = Page.getPageCount(Function.getIntParameter(String.valueOf(vo.get("pageRows"))), rowCount);
		rowPageCount[0] = rowCount;
		rowPageCount[1] = pageCount;
		return rowPageCount;
	}

	/**
	 * 목록 조회
	 * @param vo
	 * @return ArrayList
	 * @throws SQLException
	 */
	public ArrayList list(HashMap<String, Object> vo) throws SQLException {
		ArrayList list = (ArrayList)sqlMapper.queryForList("project.list", vo);
		return list;
	}

	/**
	 * 게시글 저장 [게시글 저장 후 게시글의 번호를 가져옴]
	 * @param vo HashMap
	 * @return no Integer
	 * @throws SQLException
	 */
	public int insert(HashMap<String, Object> vo) throws SQLException {
		int no = (Integer)sqlMapper.insert("project.insert",vo);
		return no;
	}

	/**
	 * 수정
	 * @param vo
	 * @throws SQLException
	 */
	public int update(HashMap<String, Object> vo) throws SQLException {
		HashMap<String, Object> data = (HashMap<String, Object>)sqlMapper.queryForObject("project.filenames", vo);
		if("1".equals(vo.get("filename_chk"))){
			Function.fileDelete(Function.parseStr(vo.get("uploadPath")), Function.parseStr(data.get("filename")));
		}
		if("1".equals(vo.get("filename2_chk"))){
			Function.fileDelete(Function.parseStr(vo.get("uploadPath")), Function.parseStr(data.get("filename2")));
		}
		if("1".equals(vo.get("filename3_chk"))){
			Function.fileDelete(Function.parseStr(vo.get("uploadPath")), Function.parseStr(data.get("filename3")));
		}
		int r = sqlMapper.update("project.update", vo);
		return r;
	}

	/**
	 * 상세 (readno 수정을 위해 테이블명 필요)
	 * @param vo
	 * @param userCon(조회수)
	 * @return
	 * @throws SQLException
	 */
	public HashMap<String, Object> read(HashMap<String, Object> vo, boolean userCon) throws SQLException {
		HashMap<String, Object> data = (HashMap<String, Object>)sqlMapper.queryForObject("project.read", vo);
		
		if (userCon) {
			sqlMapper.update("project.updateReadno", vo);
		}
		return data;
	}

	/**
	 * 삭제
	 * @param vo
	 * @throws SQLException
	 */
	public int delete(HashMap<String, Object> vo) throws SQLException {
		HashMap<String, Object> data = (HashMap<String, Object>)sqlMapper.queryForObject("project.read", vo);
		int r = sqlMapper.delete("project.delete", vo);
		if (r > 0) {
			Function.fileDelete(Function.parseStr(vo.get("uploadPath")), Function.parseStr(data.get("filename")));
			Function.fileDelete(Function.parseStr(vo.get("uploadPath")), Function.parseStr(data.get("filename2")));
			Function.fileDelete(Function.parseStr(vo.get("uploadPath")), Function.parseStr(data.get("filename3")));
		}
		return r;
	}


	/**
	 * 메인목록 조회
	 * @param tablename 테이블명
	 * @param number 로우수
	 * @return ArrayList
	 * @throws SQLException
	 */
	public ArrayList mainList(HashMap<String, Object> vo) throws SQLException {
		ArrayList list = (ArrayList)sqlMapper.queryForList("project.mainList", vo);
		return list;
	}
	
	public static void main(String[] args) throws Exception {
		ProjectDAO dao = ProjectDAO.getInstance();
		HashMap<String, Object> param = new HashMap();
		param.put("reqPageNo", 1);
		param.put("pageRows", 10);
		param.put("startPageNo", Function.getStartPageNo(Function.getIntParameter(String.valueOf(param.get("reqPageNo"))), Function.getIntParameter(String.valueOf(param.get("pageRows")))));
		int[] rowPageCount = dao.count(param);
		dao.list(param);
	}


}
