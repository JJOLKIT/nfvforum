package email;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;

import com.ibatis.sqlmap.client.SqlMapClient;
import db.SqlConfigiBatis;
import util.Function;
import util.Page;

public class MailDAO {

	private static MailDAO instance = null;
	private static SqlMapClient sqlMapper;
	
	public static MailDAO getInstance() {
		if (instance == null) {
			instance = new MailDAO();
		}
		sqlMapper = SqlConfigiBatis.getInstance().getSqlMapper();
		return instance;
	}
	
	/**
	 * 총 글 수, 총 글 페이지
	 * @param vo
	 * @return rowPageCount Integer[]
	 * @throws SQLException
	 */
	public int[] count(MailVO vo) throws SQLException {
		int rowCount = (Integer)sqlMapper.queryForObject("email.count", vo);
		int[] rowPageCount = new int[2];
		int pageCount = Page.getPageCount(vo.getPageRows(), rowCount);
		rowPageCount[0] = rowCount;
		rowPageCount[1] = pageCount;
		return rowPageCount;
	}
	
	/**
	 * 게시글 저장 [게시글 저장 후 게시글의 번호를 가져옴]
	 * @param vo MailVO
	 * @return no Integer
	 * @throws SQLException
	 */
	public int insert(MailVO vo) throws SQLException {
		vo.setFilesize(Function.getFileSize(vo.getUploadPath(), vo.getFilename()));	// 파일 사이즈 구하기
		vo.setFilesize2(Function.getFileSize(vo.getUploadPath(), vo.getFilename2()));	// 파일 사이즈 구하기
		vo.setFilesize3(Function.getFileSize(vo.getUploadPath(), vo.getFilename3()));	// 파일 사이즈 구하기
		int no = (Integer)sqlMapper.insert("email.insert",vo);
		return no;
	}
	
	/**
	 * 상세
	 * @param vo
	 * @return
	 * @throws SQLException
	 */
	public MailVO read(MailVO vo) throws SQLException {
		MailVO data = (MailVO)sqlMapper.queryForObject("email.read", vo);
		return data;
	}
	
	/**
	 * 삭제
	 * @param vo
	 * @throws SQLException
	 */
	public int delete(MailVO vo) throws SQLException {
		MailVO data = (MailVO)sqlMapper.queryForObject("email.read", vo);
		int r = sqlMapper.delete("email.delete", vo);
		if (r > 0) {
			Function.fileDelete(vo.getUploadPath(), data.getFilename());
			Function.fileDelete(vo.getUploadPath(), data.getFilename2());
			Function.fileDelete(vo.getUploadPath(), data.getFilename3());
		}
		return r;
	}	
	
	/**
	 * 목록 조회
	 * @param vo
	 * @return ArrayList
	 * @throws SQLException
	 */
	public ArrayList list(MailVO vo) throws SQLException {
		ArrayList list = (ArrayList)sqlMapper.queryForList("email.list", vo);
		return list;
	}
	
	/**
	 * 총 발송수 구하기
	 * @param vo
	 * @return int
	 * @throws SQLException
	 */
	public int getTotalcount(MailVO vo) throws SQLException {
		int totalCount = (Integer)sqlMapper.queryForObject("email.getTotalcount", vo);
		return totalCount;
	}

	/**
	 * 총 발송수 수정
	 * @param vo
	 * @throws SQLException
	 */
	public int updateTotalcount(MailVO vo) throws SQLException {
		return sqlMapper.update("email.updateTotalcount", vo);
	}

// ####################################################################################################
	
	/**
	 * 발송내역 저장
	 * 발송된 이메일 주소를 ,로 구분해서 한꺼번에 insert
	 * @param listtablename 발송내역 테이블명
	 * @param emailhistory_fk 이메일히스토리FK
	 * @param receiveemail 발송이메일내역(,로 구분)
	 * @throws SQLException
	 */
	public int insertMailList(String listtablename, int emailhistory_fk, String receiveemail) throws SQLException {
		int li = 0;
		StringBuffer emailList = new StringBuffer();	// values절의 insert할 값 세팅
		StringTokenizer st = new StringTokenizer(receiveemail, ",");
		while (st.hasMoreElements()) {
			String email = st.nextToken().trim();
			if (!"".equals(email)) {
				emailList.append("("+emailhistory_fk+", '"+email+"'),");
			}
			li++;
		}
		String values = emailList.substring(0, emailList.length()-1).toString();
		HashMap hm = new HashMap();
		hm.put("listtablename", listtablename);
		hm.put("values", values);
		sqlMapper.insert("email.insertMailList",hm);
		return li;
	}
	
	/**
	 * 해당 이메일히스토리의 전체 발송 내역조회
	 * @param listtablename 발송내역 테이블명
	 * @param emailhistory_fk 이메일히스토리FK
	 * @return ArrayList
	 * @throws SQLException
	 */
	public ArrayList listMailList(String listtablename, int emailhistory_fk) throws SQLException {
		HashMap hm = new HashMap();
		hm.put("listtablename", listtablename);
		hm.put("emailhistory_fk", emailhistory_fk);
		ArrayList list = (ArrayList)sqlMapper.queryForList("email.listMailList", hm);
		return list;
	}
	
	public static void main(String[] args) throws Exception {
		MailDAO md = MailDAO.getInstance();
		MailVO vo = new MailVO(10, "emailhistory", "emaillist");
		
//		int[] rowPageCount = md.count(vo);
//		System.out.println(rowPageCount[0]+"\t"+rowPageCount[1]);
		
//		vo.setTitle("테스트");
//		vo.setSendman("서민구");
//		vo.setTotalcount(100);
//		System.out.println(md.insert(vo));
		
//		vo.setNo(2);
//		MailVO data = md.read(vo);
//		System.out.println(data.getTitle()+"\t"+data.getSendman()+"\t"+data.getTotalcount());
		
//		ArrayList<MailVO> list = md.list(vo);
//		for (int i=0; i<list.size(); i++) {
//			System.out.println(list.get(i).getNo()+"\t"+list.get(i).getTitle()+"\t"+list.get(i).getSendman()+"\t"+list.get(i).getTotalcount());
//		}
		
//		System.out.println(md.getTotalcount(vo));
//		vo.setNo(2);
//		vo.setTotalcount(200);
//		System.out.println(md.updateTotalcount(vo));
		
//		md.insertMailList("emaillist", 2, "withsky@vizensoft.com, test@vizensoft.com, withsky999@naver.com, withsky999@hotmail.com, withsky999@gmail.com");
		
//		ArrayList<MailListVO> list = md.listMailList("emaillist", 2);
//		for (int i=0; i<list.size(); i++) {
//			System.out.println(list.get(i).getNo()+"\t"+list.get(i).getEmailhistory_fk()+"\t"+list.get(i).getReceiveemail()+"\t"+list.get(i).getRegistdate());
//		}
	}

}
