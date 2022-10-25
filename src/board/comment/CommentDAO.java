package board.comment;

import java.sql.SQLException;
import java.util.ArrayList;

import com.ibatis.sqlmap.client.SqlMapClient;
import db.SqlConfigiBatis;

public class CommentDAO {

	private static CommentDAO instance;
	private static SqlMapClient sqlMapper;

	/**
	 * instance, sqlMapper 생성
	 * @return instance
	 */
	public static CommentDAO getInstance() {
		if (instance == null) {
			instance = new CommentDAO();
		}
		sqlMapper = SqlConfigiBatis.getInstance().getSqlMapper();
		return instance;
	}


	/**
	 * 목록 조회
	 * @param vo
	 * @return ArrayList
	 * @throws SQLException
	 */
	public ArrayList list(CommentVO vo) throws SQLException {
		ArrayList list = (ArrayList)sqlMapper.queryForList("comment.list", vo);
		return list;
	}

	/**
	 * 게시글 저장 [게시글 저장 후 게시글의 번호를 가져옴]
	 * @param vo NoticeVO
	 * @param realPath request.getRealPath(uploadPath)
	 * @return no Integer
	 * @throws SQLException
	 */
	public int insert(CommentVO vo) throws SQLException {
		int no = (Integer)sqlMapper.insert("comment.insert",vo);
		return no;
	}

	/**
	 * 답변 저장 [게시글 저장 후 게시글의 번호를 가져옴]
	 * @param param NoticeVO
	 * @return no Integer
	 * @throws SQLException
	 */
	public int reply(CommentVO vo) throws SQLException {
		int no = (Integer)sqlMapper.insert("comment.reply",vo);
		return no;
	}


	/**
	 * 수정
	 * @param vo
	 * @throws SQLException
	 */
	public int update(CommentVO vo) throws SQLException {
		return sqlMapper.update("comment.update", vo);
	}

	/**
	 * 삭제
	 * @param vo
	 * @throws SQLException
	 */
	public int delete(CommentVO vo) throws SQLException {
		int r = sqlMapper.delete("comment.delete", vo);
		return r;
	}

	/**
	 * 비밀번호 확인
	 * @param tablename 테이블명
	 * @param no 해당글 no
	 * @param password 비밀번호
	 * @param db_encryption 암호화방식
	 * @return boolean
	 * @throws SQLException
	 */
	public boolean checkPassword(CommentVO vo) throws SQLException {
		Integer cnt = (Integer)sqlMapper.queryForObject("comment.checkPassword", vo);
		if (cnt > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	public boolean checkAuth(CommentVO vo) throws SQLException {
		Integer cnt = (Integer)sqlMapper.queryForObject("comment.checkAuth", vo);
		if (cnt > 0) {
			return true;
		} else {
			return false;
		}
	}

	public static void main(String[] args) throws Exception {
		CommentDAO cd = CommentDAO.getInstance();
		CommentVO vo = new CommentVO(100, "notice", 4);
		
		//cd.list(vo);
		vo.setNo(2);
		vo.setMember_fk(6);

		System.out.println(cd.checkAuth(vo));
		// 등록
//		vo.setParent_fk(1);
//		vo.setPassword("111");
//		vo.setDb_encryption(SiteProperty.DB_ENCRYPTION);
//		vo.setName("서민구");
//		vo.setContents("댓글4");
//		System.out.println(cd.insert(vo));

		// 목록
//		vo.setParent_fk(1);
//		ArrayList<CommentVO> list = cd.list(vo);
//		for (int i=0; i<list.size(); i++) {
//			System.out.println(list.get(i).getNo()+"\t"+list.get(i).getParent_fk()+"\t"+list.get(i).getName());
//		}

		// 삭제
		//System.out.println(cd.delete(3, "reply_comment"));

		// 비밀번호 체크
//		System.out.println(cd.checkPassword("reply_comment", 2, "1111", SiteProperty.DB_ENCRYPTION));
	}

}
