package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import Model.Car;
import Model.Contract;
import Model.DetailContract;
import Model.Partner;

public class ContractDAO extends DAO{

	public ContractDAO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public List<Contract> getAllContract(){
		List<Contract> listContract = new ArrayList<>();
		String sql = "SELECT tblcontract.id as idContract, tblcontract.signingTime, tblcontract.rules, tblcontract.des,\r\n"
				+ "tblperson.*, tblpartner.cccd, tblpartner.bankName, tblpartner.bankNumber,\r\n"
				+ "COUNT(tblcar.id) as totalCar\r\n"
				+ "FROM tblcontract, tblperson, tblpartner, tblcar, tbldetailcontract\r\n"
				+ "WHERE tblcontract.tblPartnerid = tblpartner.tblPartnerid \r\n"
				+ "AND tblpartner.tblPartnerid = tblperson.id\r\n"
				+ "AND tblcontract.id = tbldetailcontract.tblContractid\r\n"
				+ "AND tbldetailcontract.tblCarid = tblcar.id\r\n"
				+ "AND tblcontract.status = 1\r\n"
				+ "GROUP BY tblcontract.id";
		String sqlDetail = "SELECT * FROM tbldetailcontract WHERE tblContractid = ?";
		try {
			con.setAutoCommit(false);
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				Contract contract = new Contract();
				contract.setId(rs.getInt("idContract"));
				contract.setSigningTime(rs.getDate("signingTime"));
				contract.setRules("rules");
				contract.setDes(rs.getString("des"));
				contract.setTotalCar(rs.getInt("totalCar"));
				Partner partner = new Partner();
				partner.setCccd(rs.getString("cccd"));
				partner.setBankName(rs.getString("bankName"));
				partner.setBankNumber(rs.getString("bankNumber"));
				partner.setId(rs.getInt("id"));
	    		partner.setFullname(rs.getString("fullname"));
	    		partner.setDob(rs.getDate("dob"));
	    		partner.setAddress(rs.getString("address"));
	    		partner.setPhoneNumber(rs.getString("phoneNumber"));
	    		partner.setEmail(rs.getString("email"));
	    		partner.setDes(rs.getString("des"));
	    		contract.setPartner(partner);
	    		listContract.add(contract);
			}
			for(Contract c : listContract) {
				PreparedStatement psDetail = con.prepareStatement(sqlDetail);
				psDetail.setInt(1, c.getId());
				ResultSet rsDetail = psDetail.executeQuery();
				List<DetailContract> listDC = new ArrayList<>();
				while(rsDetail.next()) {
					DetailContract dc = new DetailContract();
					dc.setId(rsDetail.getInt("id"));
					dc.setCheckin(rsDetail.getDate("checkin"));
					dc.setCheckout(rsDetail.getDate("checkout"));
					dc.setCost(rsDetail.getFloat("cost"));
					Car car = new Car();
					car.setId(rsDetail.getInt("tblCarid"));
					dc.setCar(car);
					listDC.add(dc);
				}
				c.setListDetailContract(listDC);
			}
			con.commit();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return listContract;
	}
	
	public boolean saveContract(Contract contract) {
		boolean kq = false;
		String sqlSC = "INSERT INTO tblcontract(signingTime, rules, status, des, tblPartnerid, tblManagerid) VALUES(?, ?, ?, ?, ?, ?)";
		String sqlSDC = "INSERT INTO tbldetailcontract(checkin, checkout, cost, tblCarid, tblContractid) VALUES(?, ?, ?, ?, ?)";
		try {
			con.setAutoCommit(false);
			PreparedStatement psSC = con.prepareStatement(sqlSC, Statement.RETURN_GENERATED_KEYS);
			psSC.setDate(1, contract.getSigningTime());
			psSC.setString(2, contract.getRules());
			psSC.setInt(3, 1);
			psSC.setString(4, contract.getDes());
			psSC.setInt(5, contract.getPartner().getId());
			psSC.setInt(6, contract.getManager().getId());
			psSC.executeUpdate();
			int idContract = 0;
			ResultSet generatedKeys = psSC.getGeneratedKeys();
		    if(generatedKeys.next()) {
				idContract = generatedKeys.getInt(1);
			}
		    PreparedStatement psSDC = con.prepareStatement(sqlSDC);
		    for(DetailContract dc : contract.getListDetailContract()) {
		    	psSDC.setDate(1, dc.getCheckin());
		    	psSDC.setDate(2, dc.getCheckout());
		    	psSDC.setFloat(3, dc.getCost());
		    	psSDC.setInt(4, dc.getCar().getId());
		    	psSDC.setInt(5, idContract);
		    	psSDC.addBatch();
		    }
		    psSDC.executeBatch();
		    con.commit();
		    kq = true;
		}catch(Exception e) {
			e.printStackTrace();
			try {
				con.rollback();
			}catch(Exception ex) {
				ex.printStackTrace();
				kq = false;
			}
		}finally{
            try{
                con.setAutoCommit(true);
            }catch(Exception e){
                kq=false;
                e.printStackTrace();                
            }
        }
		return kq;
	}
}
