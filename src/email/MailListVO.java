package email;

import java.sql.Timestamp;

public class MailListVO {
	
	private int no;
	private int emailhistory_fk;
	private String receiveemail;
	private Timestamp registdate;

	public MailListVO() {
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getEmailhistory_fk() {
		return emailhistory_fk;
	}

	public void setEmailhistory_fk(int emailhistory_fk) {
		this.emailhistory_fk = emailhistory_fk;
	}

	public String getReceiveemail() {
		return receiveemail;
	}

	public void setReceiveemail(String receiveemail) {
		this.receiveemail = receiveemail;
	}

	public Timestamp getRegistdate() {
		return registdate;
	}

	public void setRegistdate(Timestamp registdate) {
		this.registdate = registdate;
	}

	
}
