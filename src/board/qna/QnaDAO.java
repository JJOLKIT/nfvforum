package board.qna;

import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import com.ibatis.sqlmap.client.SqlMapClient;

import db.SqlConfigiBatis;
import util.Function;
import util.Page;

public class QnaDAO {

	private static QnaDAO instance;
	private static SqlMapClient sqlMapper;

	/**
	 * instance, sqlMapper 생성
	 * @return instance
	 */
	public static QnaDAO getInstance() {
		if (instance == null) {
			instance = new QnaDAO();
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
				strList.append("&no="+index);
			}
		}
		return strList.toString();
	}

	/**
	 * 총 글 수, 총 글 페이지
	 * @param param
	 * @return rowPageCount Integer[]
	 * @throws SQLException
	 */
	public int[] count(HashMap<String, Object> vo) throws SQLException {
		int rowCount = (Integer)sqlMapper.queryForObject("qna.count", vo);
		int[] rowPageCount = new int[2];
		int pageCount = Page.getPageCount(Function.getIntParameter(String.valueOf(vo.get("pageRows"))), rowCount);
		rowPageCount[0] = rowCount;
		rowPageCount[1] = pageCount;
		return rowPageCount;
	}

	/**
	 * 목록 조회
	 * @param param
	 * @return ArrayList
	 * @throws SQLException
	 */
	public ArrayList list(HashMap<String, Object> vo) throws SQLException {
		ArrayList list = (ArrayList)sqlMapper.queryForList("qna.list", vo);
		return list;
	}
	
	/**
	 * 상세 조회
	 * @param param
	 * @return ArrayList
	 * @throws SQLException
	 */
	public HashMap<String, Object> read(HashMap<String, Object> vo, boolean userCon) throws SQLException {
		HashMap<String, Object> data = (HashMap<String, Object>)sqlMapper.queryForObject("qna.read", vo);
		return data;
	}

	/**
	 * 게시글 저장 [게시글 저장 후 게시글의 번호를 가져옴]
	 * @param param FaqVO
	 * @param realPath request.getRealPath(uploadPath)
	 * @return no Integer
	 * @throws SQLException
	 */
	public int insert(HashMap<String, Object> vo) throws SQLException {
		int no = (Integer)sqlMapper.insert("qna.insert",vo);
		return no;
	}

	/**
	 * 수정
	 * @param vo
	 * @param realPath request.getRealPath(uploadPath)
	 * @throws SQLException
	 */
	public int update(HashMap<String, Object> vo) throws SQLException {
		int r = sqlMapper.update("qna.update", vo);

		return r;
	}
	
	/**
	 * 답변
	 * @param vo
	 * @param realPath request.getRealPath(uploadPath)
	 * @throws SQLException
	 */
	public int answer(HashMap<String, Object> vo) throws SQLException {
		int r = sqlMapper.update("qna.answer", vo);

		return r;
	}

	/**
	 * 상세 (readno 수정을 위해 테이블명 필요)
	 * userCon true시 조회수 +1
	 * @param no
	 * @param tablename 테이블명
	 * @param category_tablename 카테고리 테이블명 없을 시 null
	 * @param userCon 사용자 접속여부
	 * @return
	 * @throws SQLException
	 */
	public HashMap<String, Object> read(HashMap<String, Object> vo) throws SQLException {
		HashMap<String, Object> data = (HashMap<String, Object>)sqlMapper.queryForObject("qna.read", vo);
		
		return data;
	}

	/**
	 * 삭제
	 * no로 해당글 첨부파일명 조회해서 삭제
	 * @param no
	 * @throws SQLException
	 */
	public int delete(HashMap<String, Object> vo) throws SQLException {
		HashMap<String, Object> data = (HashMap<String, Object>)sqlMapper.queryForObject("qna.read", vo);
		int r = sqlMapper.delete("qna.delete", vo);
		return r;
	}
	
	public int passwordCheck(HashMap<String, Object> vo) throws SQLException {
		int cnt = (Integer)sqlMapper.queryForObject("qna.passwordCheck", vo);
		return cnt;
	}


	public static void main(String[] args) throws Exception {
		QnaDAO fd = QnaDAO.getInstance();
		HashMap<String, Object> param = new HashMap();
		param.put("reqPageNo", 1);
		param.put("pageRows", 10);
		param.put("startPageNo", Function.getStartPageNo(Function.getIntParameter(String.valueOf(param.get("reqPageNo"))), Function.getIntParameter(String.valueOf(param.get("pageRows")))));
		//String realPath = "D:/workspace/branch/www/upload/faq/";

		// 카테고리 등록
//		vo.setName("카테고리2");
//		System.out.println(fd.insertCategory(vo));

		// faq 등록
//		vo.setCategory_fk(2);
//		vo.setTitle("faq4");
//		vo.setTop("1");
//		vo.setMain("1");
//		vo.setNewicon("1");
//		vo.setContents("내용");
//		System.out.println(fd.insert(vo, "D:/workspace/branch/www/upload/faq/"));

		 //faq count
//		int[] r = fd.count(param);
//		System.out.println(r[0]+"\t"+r[1]);
		
		//param.put("no", 6);
		//param.put("password", "test1234");
		//int r = fd.passwordCheck(param);
		
		//System.out.println(r);

		// faq list
//		ArrayList<FaqVO> list = fd.list(vo);
//		for (int i=0; i<list.size(); i++) {
//			System.out.println(list.get(i).getNo()+"\t"+list.get(i).getTitle());
//		}

		// faq update
//		vo.setNo(1);
//		vo.setCategory_fk(2);
//		vo.setTitle("faq-1");
//		vo.setTop("1");
//		vo.setMain("1");
//		vo.setNewicon("1");
//		vo.setContents("내용-1");
//		System.out.println(fd.update(vo, realPath));

		// faq read
//		vo.setNo(1);
//		FaqVO data = fd.read(1, "faq", "faq_category", true);
//		System.out.println(data.getNo());
//		System.out.println(data.getTitle());

		// faq delete
//		System.out.println(fd.delete(4, "faq", realPath));

		// faq mainList
//		ArrayList<FaqVO> list = fd.mainList("faq", "faq_category", 3);
//		for (int i=0; i<list.size(); i++) {
//			System.out.println(list.get(i).getNo()+"\t"+list.get(i).getTitle()+"\t"+list.get(i).getCategory_name());
//		}

		// category list
//		ArrayList<FaqVO> list = fd.listCategory(vo);
//		for (int i=0; i<list.size(); i++) {
//			System.out.println(list.get(i).getNo()+"\t"+list.get(i).getName());
//		}

		// category update
//		vo.setNo(2);
//		vo.setName("카테고리2-1");
//		System.out.println(fd.updateCategory(vo));

		// category delete
//		System.out.println(fd.deleteCategory(2, "faq_category"));

		// category selectBoxList
//		System.out.println(fd.selectBoxList("faq_category", 3));

		// category getCategoryName
//		System.out.println(fd.getCategoryName("faq_category", 3));

	}

}
