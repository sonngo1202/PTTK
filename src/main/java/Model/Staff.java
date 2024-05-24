package Model;

import java.sql.Date;

public class Staff extends Member{
	private float salary;

	public Staff() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Staff(int id, String fullname, Date dob, String address, String phoneNumber, String email, String des,
			String username, String password, String position, float salary) {
		super(id, fullname, dob, address, phoneNumber, email, des, username, password, position);
		this.salary = salary;
	}

	public float getSalary() {
		return salary;
	}

	public void setSalary(float salary) {
		this.salary = salary;
	}
	
	
}
