package logic;


import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;


public class User {
	@Size(min=3,max=10,message="아이디는 3자이상 10자 이하로 입력하세요.")
	private String userid;
	@Size(min=5,max=15,message="비밀번호는 5자이상 15자 이하로 입력하세요.")
	private String password;
	@NotEmpty(message="사용자이름은 필수입니다.")
	private String name;
	@NotEmpty(message="닉네임은 필수입력사항입니다.")
	@Size(min=4,max=10,message="닉네임은 4자이상 10자 이하로 입력하세요.")
	private String nickname;
	@NotEmpty(message="이메일은 필수입니다.")
	@Email(message="email 형식으로 입력하세요")
	private String email;
	private String phoneno;
	private int gender;
	@NotEmpty(message="직장이름은 필수입력사항입니다.")
	private String address;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhoneno() {
		return phoneno;
	}
	public void setPhoneno(String phoneno) {
		this.phoneno = phoneno;
	}
	public int getGender() {
		return gender;
	}
	public void setGender(int gender) {
		this.gender = gender;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddress() {
		return address;
	}
	@Override
	public String toString() {
		return "User [userid=" + userid + ", password=" + password + ", name=" + name + ", nickname=" + nickname
				+ ", email=" + email + ", phoneno=" + phoneno + ", gender=" + gender + ", address=" + address + "]";
	}
	
}
