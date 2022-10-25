package member;
import java.util.List;

import org.apache.poi.hssf.util.CellReference;
import org.apache.poi.xssf.eventusermodel.XSSFSheetXMLHandler.SheetContentsHandler;

public class Sheet2ListHandler implements SheetContentsHandler {
	
	private List<String[]> rows;
	private String[] row;
	private int columnCnt;
	private int currColNum = 0;
	
	private int currentCol = -1;
	
	public Sheet2ListHandler(
			List<String[]> rows,
			int columnsCnt
			) {
		this.rows = rows;
		this.columnCnt = columnsCnt;
	}
	
	@Override
	public void startRow(int rowNum) {
		this.row = new String[columnCnt];
		currColNum = 0;
	}
	
	@Override
	public void endRow() {
		boolean addFlag = false;
		for (String data : row) {
			if (!"".equals(data)) {
				addFlag = true;
			}
		}
		
		if (addFlag) rows.add(row);
	}

	@Override
	public void cell(String columnNum, String value) {
		int thisCol = (new CellReference(columnNum)).getCol();
		int missedCols = thisCol - currentCol -1;
		for (int i=0; i<missedCols; i++) {
			row[currColNum++] = "";
		}
		currentCol = thisCol;
		row[currColNum++] = value == null ? "" : value;
		
		//row[currColNum++] = value == null ? "" : value;
	}
	
	public String[] getRow() {
		return row;
	}

	

	@Override
	public void headerFooter(String arg0, boolean arg1, String arg2) {
		// TODO Auto-generated method stub
		
	}

	
}
