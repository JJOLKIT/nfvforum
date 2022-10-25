package member;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.opencsv.CSVWriter;

import db.SqlConfigiBatis;
import property.SiteProperty;
import util.CodeUtil;
import util.DateUtil;
import util.Function;
import util.Page;
import util.PasswordUtil;

public class MemberDAO {

	public static MemberDAO instance;
	public static SqlMapClient sqlMapper;
	private Logger logger = Logger.getLogger(getClass());

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
			if(!"".equals(Function.checkNull(Function.parseStr(hm.get("sgrade"))))){
				strList.append("&sgrade="+Function.parseStr(hm.get("sgrade")));
			}
			if(!"".equals(Function.checkNull(Function.parseStr(hm.get("ssite"))))){
				strList.append("&ssite="+Function.parseStr(hm.get("ssite")));
			}
			if (!"0".equals(index)) {
				strList.append("&no="+index);
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
	
	public ArrayList orderinfo(String user_key) throws SQLException {
		ArrayList list = (ArrayList)sqlMapper.queryForList("member.orderinfo", user_key);
		return list;
	}

	/**
	 * 관리자 등록
	 * @param vo
	 * @return no 마지막 등록된 no
	 * @throws SQLException
	 */
	public int insert(HashMap<String, Object> param) throws SQLException {
		PasswordUtil pu = new PasswordUtil();
		param.put("USER_PWD", pu.encode(Function.parseStr(param.get("password"))));
		int no = (Integer) sqlMapper.insert("member.insert", param);
		return no;
	}

	/**
	 * 관리자 수정
	 * @param vo
	 * @throws SQLException
	 */
	public int update(HashMap<String, Object> param) throws SQLException {
		if (param.get("password") != null && !"".equals(param.get("password"))) {
			PasswordUtil pu = new PasswordUtil();
			param.put("USER_PWD", pu.encode(Function.parseStr(param.get("password"))));
		}
		return sqlMapper.update("member.update", param);
	}
	
	// 사용자 수정
	public int updateUser(HashMap<String, Object> param) throws SQLException {
		if (param.get("password") != null && !"".equals(param.get("password"))) {
			PasswordUtil pu = new PasswordUtil();
			param.put("USER_PWD", pu.encode(Function.parseStr(param.get("password"))));
		}
		return sqlMapper.update("member.updateUser", param);
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
		String reqUserPwd = String.valueOf(param.get("password"));		
		String user_pwd = (String) sqlMapper.queryForObject("member.loginCheck", param);		
		logger.info("여기가 로그인");		
		boolean result = false;
		PasswordUtil pu = new PasswordUtil();
				if (pu.matches(reqUserPwd, user_pwd)) {
			result = true;
		}
		return result;
	}

	public HashMap<String, Object> getLoginSessionInfo(HashMap<String, Object> param) throws SQLException {
		
		HashMap<String, Object> hm = (HashMap<String, Object>) sqlMapper.queryForObject("member.loginSessionInfo", param);
		return hm;
	}
	
	// 탈퇴처리
	public int secession(int user_key) throws SQLException {
		return sqlMapper.update("member.secession", user_key);
	}
	
	/**
	 * 회원 탈퇴 신청
	 * @param vo
	 * @throws SQLException
	 */
	/*public int updateSecession(int no) throws SQLException {
		return sqlMapper.update("member.updateSecession", no);
	}*/
	
	/**
	 * 임시 비밀번호로 변경
	 * @param vo
	 * @throws SQLException
	 */
	public boolean updateTempPass(int no, String temppass) throws SQLException {
		HashMap<String, Object> param = new HashMap();
		
		
		if (temppass != null && !"".equals(temppass)) {
			PasswordUtil pu = new PasswordUtil();
			param.put("USER_PWD", pu.encode(Function.parseStr(temppass)));
		}
		
		param.put("no", no);
		//logger.debug("12123123123");
		
		//m.put("db_encryption", SiteProperty.DB_ENCRYPTION);
		int r = sqlMapper.update("member.updateTempPass", param);
		boolean result = false;
		if( r > 0) {
			result = true;
		}
		return result;
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

	/**
	 * 아이디체크
	 * @param param
	 * @return
	 * @throws SQLException
	 */
	public int idcheck(HashMap<String, Object> param) throws SQLException {
		return (Integer) sqlMapper.queryForObject("member.idcheck", param);
	}
	
	public int emailcheck(HashMap<String, Object> param) throws SQLException {
		return (Integer) sqlMapper.queryForObject("member.emailcheck", param);
	}
	
	public void insertChild(HashMap<String, Object> param) throws SQLException {
		sqlMapper.insert("member.insertChild", param);
	}
	
	public ArrayList listChild(int user_key) throws SQLException {
		ArrayList list = (ArrayList)sqlMapper.queryForList("member.listChild", user_key);
		return list;
	}
	
	public int deleteChild(int user_key) throws SQLException {
		return sqlMapper.delete("member.deleteChild", user_key);
	}
	
	public boolean checkPassword(HashMap<String, Object> param) throws SQLException {
		String reqUserPwd = String.valueOf(param.get("USER_PWD"));
		String user_pwd = (String) sqlMapper.queryForObject("member.checkPassword", param);
		boolean result = false;
		PasswordUtil pu = new PasswordUtil();
		if (pu.matches(reqUserPwd, user_pwd)) {
			result = true;
		}
		return result;
	}
	
	/*아이디 찾기*/
	public HashMap<String, Object> idsearch(HashMap<String, Object> param) throws SQLException {
		return (HashMap<String, Object>) sqlMapper.queryForObject("member.idsearch", param);
	}

	public HashMap<String, Object> pwsearch(HashMap<String, Object> param) throws SQLException {
		return (HashMap<String, Object>) sqlMapper.queryForObject("member.pwsearch", param);
	}
	
	public String excelDownload(HashMap<String, Object> param) throws SQLException, IOException {
		param.put("pageRows", 9999);
		List<LinkedHashMap<String, Object>> list = (ArrayList)sqlMapper.queryForList("member.list", param);
			
	
		XSSFWorkbook xlsWb = new XSSFWorkbook(); //xlsx
		Sheet sheet1 = xlsWb.createSheet("회원목록");
		Row row = null;
        Cell cell = null;
        
        int rowIdx = 0;
        row = sheet1.createRow(rowIdx++);
		String[] title = {"NO","구분","ID","이름","소속", "직위", "연락처", "이메일", "가입일", "상태"};
		for(int i=0; i<title.length; i++) {
			cell = row.createCell(i);
	        cell.setCellValue(title[i]);
	        cell.setCellStyle(cellStyle(xlsWb, "head")); // 셀 스타일 적용
		}
		
		sheet1.setColumnWidth(1, 4000);
		sheet1.setColumnWidth(2, 4000);
		sheet1.setColumnWidth(3, 4000);
		sheet1.setColumnWidth(4, 4000);
		sheet1.setColumnWidth(5, 4000);
		sheet1.setColumnWidth(6, 4000);
		sheet1.setColumnWidth(7, 5000);
		sheet1.setColumnWidth(8, 6000);
		
		
		HashMap<String, Object> data;
		for(int j = 0; j < list.size(); j ++) {
			data = list.get(j);
			
			row = sheet1.createRow(rowIdx++);
			int cellIdx = 0;
			String state = "일반";
			if("1".equals(data.get("secession"))) {
	        	state = "탈퇴";
	        }else {
	        	state = "일반";
	        }
			
			
			//data 출력하기
	        cell = row.createCell(cellIdx++);
	        cell.setCellValue(j+1);
	        cell = row.createCell(cellIdx++);
	        cell.setCellValue(CodeUtil.getMemberGradeName(Function.parseInt(data.get("grade"))));
	        cell = row.createCell(cellIdx++);
	        cell.setCellValue(Function.parseStr(data.get("id")));
	        cell = row.createCell(cellIdx++);
	        cell.setCellValue(Function.parseStr(data.get("name")));
	        cell = row.createCell(cellIdx++);
	        cell.setCellValue(Function.parseStr(data.get("division")));
	        cell = row.createCell(cellIdx++);
	        cell.setCellValue(Function.parseStr(data.get("position")));
	        cell = row.createCell(cellIdx++);
	        cell.setCellValue(Function.parseStr(data.get("cell")));
	        cell = row.createCell(cellIdx++);
	        cell.setCellValue(Function.parseStr(data.get("email")));
	        cell = row.createCell(cellIdx++);
	        cell.setCellValue(Function.parseDateTime(data.get("registdate")));
	        cell = row.createCell(cellIdx++);
	        cell.setCellValue(state);
	        
	        //cell.setCellStyle(cellStyle(xlsWb, "data")); // 셀 스타일 적용
		}
		try {
        	String path = property.SiteProperty.MEMBER_EXCEL_PATH; //경로
        	String fileName = "member_"+DateUtil.getToday()+".xlsx"; //파일명
            File xlsFile = new File(path+fileName); //저장경로 설정
            FileOutputStream fileOut = new FileOutputStream(xlsFile);
            xlsWb.write(fileOut);
            return fileName;
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            return "";
        } catch (IOException e) {
            e.printStackTrace();
            return "";
        }
        
		
		/*
		String fileName = new Date().getTime()+"_member.xlsx";
		CSVWriter cw = new CSVWriter(new OutputStreamWriter(new FileOutputStream("D:/jsphome/nfvforum/www/upload/forum/"+fileName), "EUC-KR"),',', '"');
		DecimalFormat f = new DecimalFormat("######.####");
		f.setGroupingUsed(false);
		f.setMaximumFractionDigits(10);
		
		
		try {
			if (list.size() > 0) {
				cw.writeNext(new String[] { 
                		String.valueOf("No."),
                		String.valueOf("구분"),
                		String.valueOf("ID"),
                		String.valueOf("이름"),
                		String.valueOf("소속"),
                		String.valueOf("직위"),
                		String.valueOf("휴대폰"),
                		String.valueOf("이메일"),
                		String.valueOf("가입일"),
                });
					
				int i = 1;
					for(Map<String, Object> m : list) {
	                    //배열을 이용하여 row를 CSVWriter 객체에 write
	                    cw.writeNext(new String[] { 
	                    		String.valueOf(i),
	                    		String.valueOf(CodeUtil.getMemberGradeName(Function.parseInt(m.get("grade")))),
	                    		String.valueOf(m.get("id")),
	                    		String.valueOf(Function.parseStr(m.get("name"))),
	                    		String.valueOf(Function.parseStr(m.get("division"))),
	                    		String.valueOf(Function.parseStr(m.get("position"))),
	                    		String.valueOf(Function.parseStr(m.get("cell"))),
	                    		String.valueOf(Function.parseStr(m.get("email"))),
	                    		String.valueOf(Function.parseDateTime(m.get("registdate")))
	                    });
	                    i++;
	                }
			
				
			}
			
			return 1;
		
			
		} catch (Exception e) {
			return 0;
			
		} finally {
			//필수로 닫아주어야함
			cw.close();
		}
		
		*/
	}
	
	
	private CellStyle cellStyle(XSSFWorkbook xlsWb, String kind) {
		// TODO Auto-generated method stub
		CellStyle cellStyle = xlsWb.createCellStyle();
	
		
		return null;
	}

	public String tempPass() {
        Random oRandom = new Random();
        String str;
        // 대문자 매칭
        int ascno1 = oRandom.nextInt(25) + 65;
        str = String.format ( "%c" ,(char) ascno1);

        // 소문자 매칭
        int ascno2 = oRandom.nextInt(25) + 97;
        str = str+String.format ( "%c" ,(char) ascno2);

        // 일부 특수문자 매칭
        /*int ascno3 = oRandom.nextInt(3) + 35;
        str = str+String.format ( "%c" ,(char) ascno3);*/

        // 숫자 매칭
        int ascno4 = oRandom.nextInt(10) + 48;
        str = str+String.format ( "%c" ,(char) ascno4);

        int ascno5 = oRandom.nextInt(25) + 65;
        str = str+String.format ( "%c" ,(char) ascno5);

        // 숫자 매칭
        int ascno6 = oRandom.nextInt(10) + 48;
        str = str+String.format ( "%c" ,(char) ascno6);

        // 대문자 매칭
        int ascno7 = oRandom.nextInt(25) + 65;
        str = str+String.format ( "%c" ,(char) ascno7);

        return str;
    }
	
	public int updatePwd(HashMap<String, Object> param) throws SQLException {
		if (param.get("USER_PWD_NEW") != null && !"".equals(param.get("USER_PWD_NEW"))) {
			PasswordUtil pu = new PasswordUtil();
			param.put("USER_PWD", pu.encode(Function.parseStr(param.get("USER_PWD_NEW"))));
		}
		return sqlMapper.update("member.updatePwd", param);
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
		
		param.put("USER_ID", "admin");
		param.put("USER_PWD", "okok0505!!");
		System.out.println(ad.loginCheck(param));
		
		
	}
}
