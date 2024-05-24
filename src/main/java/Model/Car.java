package Model;

import java.util.List;

public class Car {
	private int id;
	private String licensePlate;
	private String name;
	private String color;
	private String year;
	private float price;
	private float fine;
	private String des;
	private List<CarError> listCarError;
	public Car() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Car(int id, String licensePlate, String name, String color, String year, float price, float fine, String des,
			List<CarError> listCarError) {
		super();
		this.id = id;
		this.licensePlate = licensePlate;
		this.name = name;
		this.color = color;
		this.year = year;
		this.price = price;
		this.fine = fine;
		this.des = des;
		this.listCarError = listCarError;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getLicensePlate() {
		return licensePlate;
	}
	public void setLicensePlate(String licensePlate) {
		this.licensePlate = licensePlate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public float getFine() {
		return fine;
	}
	public void setFine(float fine) {
		this.fine = fine;
	}
	public String getDes() {
		return des;
	}
	public void setDes(String des) {
		this.des = des;
	}
	public List<CarError> getListCarError() {
		return listCarError;
	}
	public void setListCarError(List<CarError> listCarError) {
		this.listCarError = listCarError;
	}
	
	
}
