package committee;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xssf.eventusermodel.ReadOnlySharedStringsTable;
import org.apache.poi.xssf.eventusermodel.XSSFReader;
import org.apache.poi.xssf.eventusermodel.XSSFSheetXMLHandler;
import org.apache.poi.xssf.model.StylesTable;
import org.xml.sax.ContentHandler;
import org.xml.sax.InputSource;
import org.xml.sax.XMLReader;

import com.ibatis.sqlmap.client.SqlMapClient;

import committee.Sheet2ListHandler;
import db.SqlConfigiBatis;
import util.Function;
import util.Page;

public class CommitteeDAO {

	private static CommitteeDAO instance;
	private static SqlMapClient sqlMapper;

	/**
	 * instance, sqlMapper 생성
	 * @return instance
	 */
	public static CommitteeDAO getInstance() {
		if (instance == null) {
			instance = new CommitteeDAO();
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
			if(!"".equals(Function.checkNull(Function.parseStr(hm.get("smain"))))){
				strList.append("&smain="+Function.parseStr(hm.get("smain")));
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
		int rowCount = (Integer)sqlMapper.queryForObject("committee.count", vo);
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
		ArrayList list = (ArrayList)sqlMapper.queryForList("committee.list", vo);
		return list;
	}

	public ArrayList listAll(HashMap<String, Object> vo) throws SQLException {
		ArrayList list = (ArrayList)sqlMapper.queryForList("committee.listAll", vo);
		return list;
	}

	/**
	 * 게시글 저장 [게시글 저장 후 게시글의 번호를 가져옴]
	 * @param vo NoticeVO
	 * @return no Integer
	 * @throws SQLException
	 */
	public int insert(HashMap<String, Object> vo) throws SQLException {
		int no = (Integer)sqlMapper.insert("committee.insert",vo);
		return no;
	}
	
	public int insertExcel(HashMap<String, Object> vo ) throws Exception {
		sqlMapper = SqlConfigiBatis.getInstance().getSqlMapper();
		
		
		sqlMapper.delete("committee.alldelete", vo);
		String fileName = Function.parseStr(vo.get("filename"));
		
		List<String[]> dataList = getExcel(property.SiteProperty.COMMITTEE_EXCEL_PATH+fileName, 5);
		
		try {
			sqlMapper.startTransaction();
			sqlMapper.startBatch();
			

			
			for (int i=0; i<dataList.size(); i++) {
				if (i>0) {
					String[] rows = dataList.get(i);
					//vo.setSaledate(DateUtil.formattedDate(rows[0], "mm/dd/yy", "yyyy-mm-dd"));
					vo.put("category", vo.get("category"));
					vo.put("division", rows[0]);
					vo.put("position", rows[1]);
					vo.put("name", rows[2]);
					vo.put("etc", rows[3]);
					
					
					//System.out.println(vo.getSaledate());
					sqlMapper.insert("committee.insert", vo);
				}
			}
			
			sqlMapper.executeBatch();
			sqlMapper.commitTransaction();
			
			return 1;
		} catch (Exception e) {
			System.out.println(e.toString());
			return 0;
		} finally {
			sqlMapper.endTransaction();
			Function.fileDelete(property.SiteProperty.COMMITTEE_EXCEL_PATH, fileName);
			
		}
		//int r = sqlMapper.delete("music.delete", vo);
	}

	/**
	 * 수정
	 * @param vo
	 * @throws SQLException
	 */
	public int update(HashMap<String, Object> vo) throws SQLException {
		HashMap<String, Object> data = (HashMap<String, Object>)sqlMapper.queryForObject("committee.filenames", vo);
		if("1".equals(vo.get("filename_chk"))){
			Function.fileDelete(Function.parseStr(vo.get("uploadPath")), Function.parseStr(data.get("filename")));
		}
		if("1".equals(vo.get("filename2_chk"))){
			Function.fileDelete(Function.parseStr(vo.get("uploadPath")), Function.parseStr(data.get("filename2")));
		}
		if("1".equals(vo.get("filename3_chk"))){
			Function.fileDelete(Function.parseStr(vo.get("uploadPath")), Function.parseStr(data.get("filename3")));
		}
		int r = sqlMapper.update("committee.update", vo);
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
		HashMap<String, Object> data = (HashMap<String, Object>)sqlMapper.queryForObject("committee.read", vo);
		
		if (userCon) {
			sqlMapper.update("committee.updateReadno", vo);
		}
		return data;
	}

	/**
	 * 삭제
	 * @param vo
	 * @throws SQLException
	 */
	public int delete(HashMap<String, Object> vo) throws SQLException {
		HashMap<String, Object> data = (HashMap<String, Object>)sqlMapper.queryForObject("committee.read", vo);
		int r = sqlMapper.delete("committee.delete", vo);
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
		ArrayList list = (ArrayList)sqlMapper.queryForList("committee.mainList", vo);
		return list;
	}
	
	public List<String[]> getExcel(String file_name, int colCount) throws Exception {
		File file = new File(file_name);
		
		FileInputStream fis = new FileInputStream(file);
		List<String[]> dataList = new ArrayList<String[]>();
		try {
			OPCPackage opc = OPCPackage.open(fis);
			XSSFReader xssfReader = new XSSFReader(opc);
			XSSFReader.SheetIterator itr = (XSSFReader.SheetIterator)xssfReader.getSheetsData();
			
			StylesTable styles = xssfReader.getStylesTable();
			ReadOnlySharedStringsTable strings = new ReadOnlySharedStringsTable(opc);
			
			while (itr.hasNext()) {
				InputStream sheetStream = itr.next();
				InputSource sheetSource = new InputSource(sheetStream);
				
				Sheet2ListHandler sheet2ListHandler = new Sheet2ListHandler(dataList, colCount);
				
				ContentHandler handler = new XSSFSheetXMLHandler(styles, strings, sheet2ListHandler, false);
				
				SAXParserFactory saxFactory = SAXParserFactory.newInstance();
				SAXParser saxParser = saxFactory.newSAXParser();
				XMLReader sheetParser = saxParser.getXMLReader();
				sheetParser.setContentHandler(handler);
				sheetParser.parse(sheetSource);
				
				sheetStream.close();
			}
			opc.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) fis.close();
		}
//		System.out.println(dataList.size());
//		for (int i=0; i<10; i++) {
//			String[] rows = dataList.get(i);
//			for (int j=0; j<rows.length; j++) {
//				System.out.println(rows[j]);
//			}
//		}
		return dataList;
	}
	
	public static void main(String[] args) throws Exception {
		CommitteeDAO dao = CommitteeDAO.getInstance();
		HashMap<String, Object> param = new HashMap();
		param.put("reqPageNo", 1);
		param.put("pageRows", 10);
		param.put("startPageNo", Function.getStartPageNo(Function.getIntParameter(String.valueOf(param.get("reqPageNo"))), Function.getIntParameter(String.valueOf(param.get("pageRows")))));
		int[] rowPageCount = dao.count(param);
		dao.list(param);
	}


}
