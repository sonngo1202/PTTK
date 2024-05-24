package Model;

import java.sql.Date;

public class Partner extends Person{
	private String cccd;
	private String bankName;
	private String bankNumber;
	public Partner() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Partner(int id, String fullname, Date dob, String address, String phoneNumber, String email, String des) {
		super(id, fullname, dob, address, phoneNumber, email, des);
		// TODO Auto-generated constructor stub
	}
	
	public Partner(String cccd, String bankName, String bankNumber) {
		super();
		this.cccd = cccd;
		this.bankName = bankName;
		this.bankNumber = bankNumber;
	}
	public String getCccd() {
		return cccd;
	}
	public void setCccd(String cccd) {
		this.cccd = cccd;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getBankNumber() {
		return bankNumber;
	}
	public void setBankNumber(String bankNumber) {
		this.bankNumber = bankNumber;
	}
	
	
}
