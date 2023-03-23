package logic;

import java.util.Date;

import javax.validation.constraints.NotEmpty;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

public class Board {
	private int bno;
	@NotEmpty(message="제목을 입력하세요")
	private String article;
	@NotEmpty(message="내용을 입력하세요")
	private String subsistence;
	private MultipartFile img;
	private String imgurl;
	private String boardid;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date regdate;
	private String ip;
	private int readcnt;
	private int grade;
	private int heart;
	private int price;
	private String menu;
	//-----추가부분------
	private String pname;
	private String paddress;
	private String phone;
	//---------------------
	private double map_a;
	private double map_b;
	private String userid;
	private String password;
	//getter setter toString
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getArticle() {
		return article;
	}
	public void setArticle(String article) {
		this.article = article;
	}
	public String getSubsistence() {
		return subsistence;
	}
	public void setSubsistence(String subsistence) {
		this.subsistence = subsistence;
	}
	public MultipartFile getImg() {
		return img;
	}
	public void setImg(MultipartFile img) {
		this.img = img;
	}
	public String getImgurl() {
		return imgurl;
	}
	public void setImgurl(String imgurl) {
		this.imgurl = imgurl;
	}
	public String getBoardid() {
		return boardid;
	}
	public void setBoardid(String boardid) {
		this.boardid = boardid;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public int getHeart() {
		return heart;
	}
	public void setHeart(int heart) {
		this.heart = heart;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getMenu() {
		return menu;
	}
	public void setMenu(String menu) {
		this.menu = menu;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPaddress() {
		return paddress;
	}
	public void setPaddress(String paddress) {
		this.paddress = paddress;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public double getMap_a() {
		return map_a;
	}
	public void setMap_a(double map_a) {
		this.map_a = map_a;
	}
	public double getMap_b() {
		return map_b;
	}
	public void setMap_b(double map_b) {
		this.map_b = map_b;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	@Override
	public String toString() {
		return "Board [bno=" + bno + ", article=" + article + ", subsistence=" + subsistence + ", img=" + img
				+ ", imgurl=" + imgurl + ", boardid=" + boardid + ", regdate=" + regdate + ", ip=" + ip + ", readcnt="
				+ readcnt + ", grade=" + grade + ", heart=" + heart + ", price=" + price + ", menu=" + menu + ", pname="
				+ pname + ", paddress=" + paddress + ", phone=" + phone + ", map_a=" + map_a + ", map_b=" + map_b
				+ ", userid=" + userid + ", password=" + password + "]";
	}
	
	
	
}