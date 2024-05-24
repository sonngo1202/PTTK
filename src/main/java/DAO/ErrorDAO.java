package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import Model.Error;

public class ErrorDAO extends DAO{

	public ErrorDAO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public List<Error> getAllError(){
		List<Error> listError = new ArrayList<>();
		String sql = "SELECT * FROM tblerror";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				Error error = new Error();
				error.setId(rs.getInt("id"));
				error.setName(rs.getString("name"));
				listError.add(error);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return listError;
	}
	
	public boolean saveError(Error error) {
		boolean kq = false;
		String sql = "INSERT INTO tblerror(name) VALUES(?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		    ps.setString(1, error.getName());
		    ps.executeUpdate();
		    ResultSet generatedKeys = ps.getGeneratedKeys();
		    if(generatedKeys.next()) {
				error.setId(generatedKeys.getInt(1));
			}
		    kq = true;
		}catch(Exception e) {
			e.printStackTrace();
			kq = false;
		}
		
		return kq;
	}

}
