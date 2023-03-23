package logic;

public class Likes {
	private int bno;
	private String userid;
	private String kbn;
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getKbn() {
		return kbn;
	}
	public void setKbn(String kbn) {
		this.kbn = kbn;
	}
	@Override
	public String toString() {
		return "Likes [bno=" + bno + ", userid=" + userid + ", kbn=" + kbn + "]";
	}
}
