package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Model.Member;

public class MemberDAO extends DAO{

	public MemberDAO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public boolean checkLogin(Member member) {
		boolean kq = false;
		String sql = "SELECT * FROM tblperson, tblmember \r\n"
				+ "WHERE tblPerson.id = tblmember.tblPersonid \r\n"
				+ "AND tblmember.username = ? \r\n"
				+ "AND tblmember.password = ?";
	    try {
	    	PreparedStatement ps = con.prepareStatement(sql);
	    	ps.setString(1, member.getUsername());
	    	ps.setString(2, member.getPassword());
	    	ResultSet rs = ps.executeQuery();
	    	if(rs.next()) {
	    		member.setId(rs.getInt("id"));
	    		member.setFullname(rs.getString("fullname"));
	    		member.setDob(rs.getDate("dob"));
	    		member.setAddress(rs.getString("address"));
	    		member.setPhoneNumber(rs.getString("phoneNumber"));
	    		member.setEmail(rs.getString("email"));
	    		member.setDes(rs.getString("des"));
	    		member.setPosition(rs.getString("position"));
	    		kq = true;
	    	}
	    }catch (Exception e) {
			// TODO: handle exception
	    	e.printStackTrace();
	    	kq = false;
		}
		return kq;
	}
}
