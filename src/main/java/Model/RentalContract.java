package Model;

import java.sql.Date;
import java.util.List;

public class RentalContract {
	private int id;
	private Date SignTime;
	private String rules;
	private int totalCar;
	private float totalPayment;
	private String des;
	private Manager manager;
	private Customer customer;
	private List<RentalContractDetail> listRentalContractDetail;
	public RentalContract() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RentalContract(int id, Date signTime, String rules, int totalCar, float totalPayment, String des,
			Manager manager, Customer customer, List<RentalContractDetail> listRentalContractDetail) {
		super();
		this.id = id;
		SignTime = signTime;
		this.rules = rules;
		this.totalCar = totalCar;
		this.totalPayment = totalPayment;
		this.des = des;
		this.manager = manager;
		this.customer = customer;
		this.listRentalContractDetail = listRentalContractDetail;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getSignTime() {
		return SignTime;
	}
	public void setSignTime(Date signTime) {
		SignTime = signTime;
	}
	public String getRules() {
		return rules;
	}
	public void setRules(String rules) {
		this.rules = rules;
	}
	public int getTotalCar() {
		return totalCar;
	}
	public void setTotalCar(int totalCar) {
		this.totalCar = totalCar;
	}
	public float getTotalPayment() {
		return totalPayment;
	}
	public void setTotalPayment(float totalPayment) {
		this.totalPayment = totalPayment;
	}
	public String getDes() {
		return des;
	}
	public void setDes(String des) {
		this.des = des;
	}
	public Manager getManager() {
		return manager;
	}
	public void setManager(Manager manager) {
		this.manager = manager;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public List<RentalContractDetail> getListRentalContractDetail() {
		return listRentalContractDetail;
	}
	public void setListRentalContractDetail(List<RentalContractDetail> listRentalContractDetail) {
		this.listRentalContractDetail = listRentalContractDetail;
	}
	
}
