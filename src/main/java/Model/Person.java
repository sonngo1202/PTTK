package Model;

import java.sql.Date;

public class Person {
	private int id;
	private String fullname;
	private Date dob;
	private String address;
	private String phoneNumber;
	private String email;
	private String des;
	public Person() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Person(int id, String fullname, Date dob, String address, String phoneNumber, String email, String des) {
		super();
		this.id = id;
		this.fullname = fullname;
		this.dob = dob;
		this.address = address;
		this.phoneNumber = phoneNumber;
		this.email = email;
		this.des = des;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public Date getDob() {
		return dob;
	}
	public void setDob(Date dob) {
		this.dob = dob;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDes() {
		return des;
	}
	public void setDes(String des) {
		this.des = des;
	}
}
