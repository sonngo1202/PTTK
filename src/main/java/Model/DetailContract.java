package Model;

import java.sql.Date;

public class DetailContract {
	private int id;
	private Date checkin;
	private Date checkout;
	private float cost;
	private Car car;
	public DetailContract() {
		super();
		// TODO Auto-generated constructor stub
	}
	public DetailContract(int id, Date checkin, Date checkout, float cost, Car car) {
		super();
		this.id = id;
		this.checkin = checkin;
		this.checkout = checkout;
		this.cost = cost;
		this.car = car;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getCheckin() {
		return checkin;
	}
	public void setCheckin(Date checkin) {
		this.checkin = checkin;
	}
	public Date getCheckout() {
		return checkout;
	}
	public void setCheckout(Date checkout) {
		this.checkout = checkout;
	}
	public float getCost() {
		return cost;
	}
	public void setCost(float cost) {
		this.cost = cost;
	}
	public Car getCar() {
		return car;
	}
	public void setCar(Car car) {
		this.car = car;
	}
	
	
}
