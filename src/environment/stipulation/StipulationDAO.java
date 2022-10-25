package environment.stipulation;

import java.sql.SQLException;

import com.ibatis.sqlmap.client.SqlMapClient;
import db.SqlConfigiBatis;

public class StipulationDAO {
	private static StipulationDAO instance;
	private static SqlMapClient sqlMapper;
	
	public static StipulationDAO getInstance() {
		if (instance == null) {
			instance = new StipulationDAO();
		}
		sqlMapper = SqlConfigiBatis.getInstance().getSqlMapper();
		return instance;
	}
		
	/**
	 * 조회
	 */
	public StipulationVO select() throws SQLException {
		StipulationVO vo = (StipulationVO)sqlMapper.queryForObject("stipulation.select", 1);
		return vo;
	}
	
	/**
	 * 수정
	 */
	public int update(StipulationVO vo) throws SQLException {
		return sqlMapper.update("stipulation.update", vo);
	}
	
	public static void main(String[] args) throws Exception {
		StipulationDAO pd = StipulationDAO.getInstance();
		StipulationVO vo = pd.select();
		System.out.println(vo.getNo());
	}
}
