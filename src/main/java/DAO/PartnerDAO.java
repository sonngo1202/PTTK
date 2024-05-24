package DAO;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import Model.Partner;

public class PartnerDAO extends DAO{

	public PartnerDAO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public List<Partner> searchPartner(String key){
		List<Partner> listPartner = new ArrayList<>();
		String sql = "SELECT * FROM tblperson INNER JOIN tblpartner \r\n"
				+ "ON tblperson.id = tblpartner.tblPartnerid\r\n"
				+ "WHERE tblperson.fullname LIKE ? "
				+ "OR tblpartner.cccd LIKE ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, "%"+key+"%");
			ps.setString(2, "%"+key+"%");
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
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
	    		listPartner.add(partner);
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return listPartner;
	}
	
	public boolean addPartner(Partner partner) {
		boolean kq = false;
		String sqlCheck = "SELECT * FROM tblpartner WHERE cccd = ?";
		String sqlAddtblPerson = "INSERT INTO tblperson(fullname, dob, address, phoneNumber, email, des)\r\n"
				+ "VALUES(?, ?, ?, ?, ?, ?)";
		String sqlAddtblPartner = "INSERT INTO tblpartner(cccd, bankName, bankNumber, tblPartnerid)\r\n"
				+ "VALUES(?, ?, ?, ?)";
		try {
			con.setAutoCommit(false);
			PreparedStatement psCheck = con.prepareStatement(sqlCheck);
			psCheck.setString(1, partner.getCccd());
			ResultSet rsCheck = psCheck.executeQuery();
			if(rsCheck.next()) {
				return false;
			}
			PreparedStatement psPerson = con.prepareStatement(sqlAddtblPerson, Statement.RETURN_GENERATED_KEYS);
			psPerson.setString(1, partner.getFullname());
			psPerson.setDate(2, partner.getDob());
			psPerson.setString(3, partner.getAddress());
			psPerson.setString(4, partner.getPhoneNumber());
			psPerson.setString(5, partner.getEmail());
			psPerson.setString(6, partner.getDes());
		    psPerson.executeUpdate();
			int idPerson = 0;
			ResultSet generatedKeys = psPerson.getGeneratedKeys();
		    if(generatedKeys.next()) {
				idPerson = generatedKeys.getInt(1);
				partner.setId(idPerson);
			}
		    PreparedStatement psPartner = con.prepareStatement(sqlAddtblPartner);
		    psPartner.setString(1, partner.getCccd());
		    psPartner.setString(2, partner.getBankName());
		    psPartner.setString(3, partner.getBankNumber());
		    psPartner.setInt(4, idPerson);
		    psPartner.executeUpdate();
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
	
	public boolean updatePartner(Partner partner) {
		boolean kq = false;
		String sql = "UPDATE tblperson\r\n"
				+ "INNER JOIN tblpartner \r\n"
				+ "ON tblperson.id = tblpartner.tblPartnerid\r\n"
				+ "SET\r\n"
				+ "    tblperson.fullname = ?,\r\n"
				+ "    tblperson.dob = ?,\r\n"
				+ "    tblperson.address = ?,\r\n"
				+ "    tblperson.phoneNumber = ?,\r\n"
				+ "    tblperson.email = ?,\r\n"
				+ "    tblperson.des = ?,\r\n"
				+ "    tblpartner.cccd = ?,\r\n"
				+ "    tblpartner.bankName = ?,\r\n"
				+ "    tblpartner.bankNumber = ?\r\n"
				+ "WHERE tblperson.id = ?";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, partner.getFullname());
			ps.setDate(2, partner.getDob());
			ps.setString(3, partner.getAddress());
			ps.setString(4, partner.getPhoneNumber());
			ps.setString(5, partner.getEmail());
			ps.setString(6, partner.getDes());
			ps.setString(7, partner.getCccd());
		    ps.setString(8, partner.getBankName());
		    ps.setString(9, partner.getBankNumber());
		    ps.setInt(10, partner.getId());
		    ps.executeUpdate();
		    kq = true;
		}catch(Exception e) {
			e.printStackTrace();
			kq = false;
		}
		return kq;
	}
	
	public boolean deletePartner(int idPartner) {
		boolean kq = false;
		String sqlPartner = "DELETE FROM tblpartner WHERE tblPartnerid = ?";
		String sqlPerson = "DELETE FROM tblperson WHERE id = ?";
		try {
		    con.setAutoCommit(false);
			PreparedStatement psPartner = con.prepareStatement(sqlPartner);
			psPartner.setInt(1, idPartner);
			psPartner.executeUpdate();
			PreparedStatement psPerson = con.prepareStatement(sqlPerson);
			psPerson.setInt(1, idPartner);
			psPerson.executeUpdate();
			con.commit();
			kq = true;
		}catch(Exception e) {
			kq = false;
			e.printStackTrace();
		}
		return kq;
	}
    
	public List<Partner> getPartnerToPay(Date date){
		List<Partner> listPartner = new ArrayList<>();
		String sql = "call getPartnerToPay(?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setDate(1, date);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
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
	    		listPartner.add(partner);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return listPartner;
	}
}
