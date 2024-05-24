package Model;

import java.sql.Date;
import java.util.List;

public class Contract {
	private int id;
	private Date signingTime;
	private String rules;
	private int status;
	private int totalCar;
	private String des;
	private Partner partner;
	private Manager manager;
	private List<DetailContract> listDetailContract;
	public Contract() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Contract(int id, Date signingTime, String rules, int status, int totalCar, String des, Partner partner,
			Manager manager, List<DetailContract> listDetailContract) {
		super();
		this.id = id;
		this.signingTime = signingTime;
		this.rules = rules;
		this.status = status;
		this.totalCar = totalCar;
		this.des = des;
		this.partner = partner;
		this.manager = manager;
		this.listDetailContract = listDetailContract;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getSigningTime() {
		return signingTime;
	}
	public void setSigningTime(Date signingTime) {
		this.signingTime = signingTime;
	}
	public String getRules() {
		return rules;
	}
	public void setRules(String rules) {
		this.rules = rules;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getDes() {
		return des;
	}
	public void setDes(String des) {
		this.des = des;
	}
	public Partner getPartner() {
		return partner;
	}
	public void setPartner(Partner partner) {
		this.partner = partner;
	}
	public Manager getManager() {
		return manager;
	}
	public void setManager(Manager manager) {
		this.manager = manager;
	}
	public List<DetailContract> getListDetailContract() {
		return listDetailContract;
	}
	public void setListDetailContract(List<DetailContract> listDetailContract) {
		this.listDetailContract = listDetailContract;
	}

	public int getTotalCar() {
		return totalCar;
	}

	public void setTotalCar(int totalCar) {
		this.totalCar = totalCar;
	}
	
	
}
