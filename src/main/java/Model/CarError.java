package Model;

import java.sql.Date;

public class CarError {
	private int id;
	private int status;
	private Date dateError;
	private float cost;
	private int type;
	private Error error;
	public CarError() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public CarError(int id, int status, Date dateError, float cost, int type, Error error) {
		super();
		this.id = id;
		this.status = status;
		this.dateError = dateError;
		this.cost = cost;
		this.type = type;
		this.error = error;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Date getDateError() {
		return dateError;
	}
	public void setDateError(Date dateError) {
		this.dateError = dateError;
	}
	public float getCost() {
		return cost;
	}
	public void setCost(float cost) {
		this.cost = cost;
	}
	public Error getError() {
		return error;
	}
	public void setError(Error error) {
		this.error = error;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}
	
	
}
