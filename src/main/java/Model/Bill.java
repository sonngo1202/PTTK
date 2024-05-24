package Model;

import java.sql.Date;
import java.util.List;

public class Bill {
	private int id;
	private Date paymentTime;
	private float totalPayment;
	private float totalSublease;
	private float totalAmountIncured;
	private String bankName;
	private String bankNumber;
	private Accountant accountant;
	private Partner partner;
	private List<RentalContractDetail> listRentalContractDetails;
	public Bill() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Bill(int id, Date paymentTime, float totalPayment, float totalSublease, float totalAmountIncured,
			String bankName, String bankNumber, Accountant accountant, Partner partner,
			List<RentalContractDetail> listRentalContractDetails) {
		super();
		this.id = id;
		this.paymentTime = paymentTime;
		this.totalPayment = totalPayment;
		this.totalSublease = totalSublease;
		this.totalAmountIncured = totalAmountIncured;
		this.bankName = bankName;
		this.bankNumber = bankNumber;
		this.accountant = accountant;
		this.partner = partner;
		this.listRentalContractDetails = listRentalContractDetails;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getPaymentTime() {
		return paymentTime;
	}
	public void setPaymentTime(Date paymentTime) {
		this.paymentTime = paymentTime;
	}
	public float getTotalPayment() {
		return totalPayment;
	}
	public void setTotalPayment(float totalPayment) {
		this.totalPayment = totalPayment;
	}
	public float getTotalSublease() {
		return totalSublease;
	}
	public void setTotalSublease(float totalSublease) {
		this.totalSublease = totalSublease;
	}
	public float getTotalAmountIncured() {
		return totalAmountIncured;
	}
	public void setTotalAmountIncured(float totalAmountIncured) {
		this.totalAmountIncured = totalAmountIncured;
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
	public Accountant getAccountant() {
		return accountant;
	}
	public void setAccountant(Accountant accountant) {
		this.accountant = accountant;
	}
	public Partner getPartner() {
		return partner;
	}
	public void setPartner(Partner partner) {
		this.partner = partner;
	}
	public List<RentalContractDetail> getListRentalContractDetails() {
		return listRentalContractDetails;
	}
	public void setListRentalContractDetails(List<RentalContractDetail> listRentalContractDetails) {
		this.listRentalContractDetails = listRentalContractDetails;
	}
	
	
}
