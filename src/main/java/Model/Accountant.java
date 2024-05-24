package Model;

import java.sql.Date;

public class Accountant extends Staff{

	public Accountant() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Accountant(int id, String fullname, Date dob, String address, String phoneNumber, String email, String des,
			String username, String password, String position, float salary) {
		super(id, fullname, dob, address, phoneNumber, email, des, username, password, position, salary);
		// TODO Auto-generated constructor stub
	}
	
}
