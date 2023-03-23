package logic;

import java.sql.Timestamp;
import java.util.Date;

import javax.validation.constraints.NotEmpty;

import org.apache.ibatis.annotations.Param;

public class Comment {
	
	private int cno; //댓글의 번호
	@NotEmpty(message="내용을 입력하세요")
	private String content; //댓글의 내용
	private Date wdate;//댓글이 작성된 시간
	private int grp; //모댓글의 번호
	private int grps; //동일 모댓글내의 대댓글 순서
	private int grpl; //모댓글과 답글을 구분
	private String userid; //아이디
	private int bno; //게시물 번호
	private String nickname; // 닉네임 받아올 부분 추가
	
	public Comment() {}
	
	public Comment(@Param("content") String content, @Param("userid") String userid,  @Param("bno") int bno) {
		this.content = content;
		this.userid = userid;
		this.bno = bno;
	}
	public Comment(@Param("content") String content, @Param("userid") String userid,  @Param("bno") int bno, @Param("cno") int cno) {
		this.content = content;
		this.userid = userid;
		this.bno = bno;
		this.cno = cno;
	}
	
	public Comment(@Param("cno") int cno) {
		this.cno = cno;
	}
	
//getter,setter,toString
	public int getcno() {
		return cno;
	}
	public void setcno(int cno) {
		this.cno = cno;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getWdate() {
		return wdate;
	}
	public void setWdate(Date wdate) {
		this.wdate = wdate;
	}
	public int getGrp() {
		return grp;
	}
	public void setGrp(int grp) {
		this.grp = grp;
	}
	public int getGrps() {
		return grps;
	}
	public void setGrps(int grps) {
		this.grps = grps;
	}
	public int getGrpl() {
		return grpl;
	}
	public void setGrpl(int grpl) {
		this.grpl = grpl;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	@Override
	public String toString() {
		return "Comment [cno=" + cno + ", content=" + content + ", wdate=" + wdate + ", grp=" + grp + ", grps="
				+ grps + ", grpl=" + grpl + ", userid=" + userid + ", bno=" + bno + ",nickname=" +nickname +"]";
	}
}
