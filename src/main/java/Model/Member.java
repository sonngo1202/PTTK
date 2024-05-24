package Model;

import java.sql.Date;

public class Member extends Person{
	private String username;
	private String password;
	private String position;
	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Member(int id, String fullname, Date dob, String address, String phoneNumber, String email, String des, String username, String password, String position) {
		super(id, fullname, dob, address, phoneNumber, email, des);
		this.username = username;
		this.password = password;
		this.position = position;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	
	
}
