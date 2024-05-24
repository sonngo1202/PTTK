package Model;

import java.sql.Date;

public class RentalContractDetail {
	private int id;
	private float price;
	private float fine;
	private float cost;
	private Date borrowedDate;
	private Date returnDate;
	private Date realReturnDate;
	private float totalRent;
	private float totalFine;
	private float totalDamgeAmount;
	private float totalPayment;
	private float totalAmountIncured;
	private float totalSublease;
	private Car car;
	public RentalContractDetail() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RentalContractDetail(int id, float price, float fine, float cost, Date borrowedDate, Date returnDate,
			Date realReturnDate, float totalRent, float totalFine, float totalDamgeAmount, float totalPayment,
			float totalAmountIncured, float totalSublease, Car car) {
		super();
		this.id = id;
		this.price = price;
		this.fine = fine;
		this.cost = cost;
		this.borrowedDate = borrowedDate;
		this.returnDate = returnDate;
		this.realReturnDate = realReturnDate;
		this.totalRent = totalRent;
		this.totalFine = totalFine;
		this.totalDamgeAmount = totalDamgeAmount;
		this.totalPayment = totalPayment;
		this.totalAmountIncured = totalAmountIncured;
		this.totalSublease = totalSublease;
		this.car = car;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public float getCost() {
		return cost;
	}
	public void setCost(float cost) {
		this.cost = cost;
	}
	public Date getBorrowedDate() {
		return borrowedDate;
	}
	public void setBorrowedDate(Date borrowedDate) {
		this.borrowedDate = borrowedDate;
	}
	public Date getReturnDate() {
		return returnDate;
	}
	public void setReturnDate(Date returnDate) {
		this.returnDate = returnDate;
	}
	public Date getRealReturnDate() {
		return realReturnDate;
	}
	public void setRealReturnDate(Date realReturnDate) {
		this.realReturnDate = realReturnDate;
	}
	public float getTotalRent() {
		return totalRent;
	}
	public void setTotalRent(float totalRent) {
		this.totalRent = totalRent;
	}
	public float getTotalFine() {
		return totalFine;
	}
	public void setTotalFine(float totalFine) {
		this.totalFine = totalFine;
	}
	public float getTotalDamgeAmount() {
		return totalDamgeAmount;
	}
	public void setTotalDamgeAmount(float totalDamgeAmount) {
		this.totalDamgeAmount = totalDamgeAmount;
	}
	public float getTotalPayment() {
		return totalPayment;
	}
	public void setTotalPayment(float totalPayment) {
		this.totalPayment = totalPayment;
	}
	public float getTotalAmountIncured() {
		return totalAmountIncured;
	}
	public void setTotalAmountIncured(float totalAmountIncured) {
		this.totalAmountIncured = totalAmountIncured;
	}
	public float getTotalSublease() {
		return totalSublease;
	}
	public void setTotalSublease(float totalSublease) {
		this.totalSublease = totalSublease;
	}
	public Car getCar() {
		return car;
	}
	public void setCar(Car car) {
		this.car = car;
	}
	
	
}
