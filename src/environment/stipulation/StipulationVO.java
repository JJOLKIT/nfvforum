package environment.stipulation;

import java.sql.Timestamp;
import util.*;

public class StipulationVO {

	private int no;
	private String privacy_text;	// 개인정보취급방침
	private String privacy_mini_text;	// 개인정보취급방침간소
	private String join_text;		// 회원약관
	private String editname;		// 수정자
	private Timestamp editdate;		// 수정일시
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getPrivacy_text() {
		return Function.RegexReplace(privacy_text);
	}
	public void setPrivacy_text(String privacy_text) {
		this.privacy_text = Function.RegexReplace(privacy_text);
	}
	public String getPrivacy_mini_text() {
		return Function.RegexReplace(privacy_mini_text);
	}
	public void setPrivacy_mini_text(String privacy_mini_text) {
		this.privacy_mini_text = Function.RegexReplace(privacy_mini_text);
	}
	public String getJoin_text() {
		return Function.RegexReplace(join_text);
	}
	public void setJoin_text(String join_text) {
		this.join_text = Function.RegexReplace(join_text);
	}
	public String getEditname() {
		return editname;
	}
	public void setEditname(String editname) {
		this.editname = editname;
	}
	public Timestamp getEditdate() {
		return editdate;
	}
	public void setEditdate(Timestamp editdate) {
		this.editdate = editdate;
	}
}
