package Model;

import java.sql.Date;

public class Customer extends Member{
	private String cusCode;

	public Customer() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Customer(int id, String fullname, Date dob, String address, String phoneNumber, String email, String des,
			String username, String password, String position, String cusCode) {
		super(id, fullname, dob, address, phoneNumber, email, des, username, password, position);
		this.cusCode = cusCode;
		// TODO Auto-generated constructor stub
	}

	public String getCusCode() {
		return cusCode;
	}

	public void setCusCode(String cusCode) {
		this.cusCode = cusCode;
	}
	
}
