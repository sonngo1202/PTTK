package DAO;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import Model.Car;
import Model.CarError;

public class CarDAO extends DAO{
	public boolean saveCar(Car car) {
		boolean kq = false;
		String check = "SELECT * FROM tblcar WHERE licensePlate = ?"
;		String sql = "INSERT INTO tblcar(licensePlate, name, color, year, price, fine, des) \r\n"
				+ "VALUES(?, ?, ?, ?, ?, ?, ?)";
		try {
			con.setAutoCommit(false);
			PreparedStatement psCheck =  con.prepareStatement(check);
			psCheck.setString(1, car.getLicensePlate());
			ResultSet rsCheck = psCheck.executeQuery();
			if(rsCheck.next()) {
				return false;
			}
			PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, car.getLicensePlate());
			ps.setString(2, car.getName());
			ps.setString(3, car.getColor());
			ps.setString(4, car.getYear());
			ps.setFloat(5, car.getPrice());
			ps.setFloat(6, car.getFine());
			ps.setString(7, car.getDes());
			ps.executeUpdate();
			ResultSet generatedKeys = ps.getGeneratedKeys();
		    if(generatedKeys.next()) {
				car.setId(generatedKeys.getInt(1));
			}
		    con.commit();
			kq = true;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			kq = false;
		}
		return kq;
	}
	
	public List<Car> searchCarofPartner(int idPartner, String key){
		List<Car> listCar = new ArrayList<>();
		String sqlCar = "SELECT tblcar.*\r\n"
				+ "FROM tblcar\r\n"
				+ "WHERE NOT EXISTS(\r\n"
				+ "	SELECT 1\r\n"
				+ "    FROM tbldetailcontract\r\n"
				+ "    INNER JOIN tblcontract ON tbldetailcontract.tblContractid = tblcontract.id\r\n"
				+ "    WHERE tbldetailcontract.tblCarid = tblcar.id AND tblcontract.tblPartnerid != ?\r\n"
				+ ")\r\n"
				+ "AND (licensePlate LIKE ? OR name LIKE ?);";
		String sqlCarE = "SELECT tblcarerror.*, tblerror.id as idError, tblerror.name FROM tblcarerror \r\n"
				+ "INNER JOIN tblerror ON tblcarerror.tblErrorid = tblerror.id\r\n"
				+ "WHERE tblcarerror.tblCarid = ?";
		try {
			con.setAutoCommit(false);
			PreparedStatement psCar = con.prepareStatement(sqlCar);
			psCar.setInt(1, idPartner);
			psCar.setString(2, "%"+key+"%");
			psCar.setString(3, "%"+key+"%");
			ResultSet rsCar = psCar.executeQuery();
			while(rsCar.next()) {
				Car car = new Car();
				car.setId(rsCar.getInt("id"));
				car.setLicensePlate(rsCar.getString("licensePlate"));
				car.setColor(rsCar.getString("color"));
				car.setName(rsCar.getString("name"));
				car.setYear(rsCar.getString("year"));
				car.setPrice(rsCar.getFloat("price"));
				car.setFine(rsCar.getFloat("fine"));
				car.setDes(rsCar.getString("des"));
				listCar.add(car);
			}
			for(Car c: listCar) {
				List<CarError> listCarError = new ArrayList<>();
				PreparedStatement psCE = con.prepareStatement(sqlCarE);
				psCE.setInt(1, c.getId());
				ResultSet rsCE = psCE.executeQuery();
				int i = 0;
				while(rsCE.next()) {
					CarError carE = new CarError();
					carE.setId(i++);
					carE.setDateError(rsCE.getDate("dateError"));
					carE.setCost(rsCE.getFloat("cost"));
					carE.setType(rsCE.getInt("type"));
					carE.setStatus(rsCE.getInt("status"));
					Model.Error error = new Model.Error();
					error.setId(rsCE.getInt("idError"));
					error.setName(rsCE.getString("name"));
					carE.setError(error);
					listCarError.add(carE);
				}
				c.setListCarError(listCarError);
			}
			con.commit();
		}catch(Exception e) {
			e.printStackTrace();
			try {
				con.rollback();
			}catch(Exception ex) {
				ex.printStackTrace();
			}
		}finally{
            try{
                con.setAutoCommit(true);
            }catch(Exception e){
                e.printStackTrace();                
            }
        }
		return listCar;
	}
	public boolean updateCarErrorofCar(Car car) {
		boolean kq = false;
		String sqlDelete = "DELETE FROM tblcarerror WHERE tblCarid = ?";
		String sqlInsert = "INSERT INTO tblcarerror(status, type, cost, dateError, tblErrorid, tblCarid) VALUES(?, ?, ?, ?, ?, ?)";
		try {
			con.setAutoCommit(false);
			PreparedStatement psD = con.prepareStatement(sqlDelete);
			psD.setInt(1, car.getId());
			psD.executeUpdate();
			PreparedStatement psI = con.prepareStatement(sqlInsert);
			for(CarError ce : car.getListCarError()) {
				psI.setInt(1, ce.getStatus());
				psI.setInt(2, ce.getType());
				psI.setFloat(3, ce.getCost());
				psI.setDate(4, ce.getDateError());
				psI.setInt(5, ce.getError().getId());
				psI.setInt(6, car.getId());
				psI.addBatch();
			}
			psI.executeBatch();
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
                e.printStackTrace(); 
                kq = false;
            }
        }
		return kq;
	}
	
	public List<Car> getCarofPartnerToPay(Date date, int idPartner) {
		List<Car> listCar = new ArrayList<>();
		String sqlCar = "call getCarofPartnerToPay(?, ?)";
		String sqlCarE = "SELECT tblcarerror.*, tblerror.id as idError, tblerror.name FROM tblcarerror \r\n"
				+ "INNER JOIN tblerror ON tblcarerror.tblErrorid = tblerror.id\r\n"
				+ "WHERE tblcarerror.tblCarid = ?";
		try {
			con.setAutoCommit(false);
			PreparedStatement psCar = con.prepareStatement(sqlCar);
			psCar.setDate(1, date);
			psCar.setInt(2, idPartner);
			ResultSet rsCar = psCar.executeQuery();
			while(rsCar.next()) {
				Car car = new Car();
				car.setId(rsCar.getInt("id"));
				car.setLicensePlate(rsCar.getString("licensePlate"));
				car.setColor(rsCar.getString("color"));
				car.setName(rsCar.getString("name"));
				car.setYear(rsCar.getString("year"));
				car.setPrice(rsCar.getFloat("price"));
				car.setFine(rsCar.getFloat("fine"));
				car.setDes(rsCar.getString("des"));
				listCar.add(car);
			}
			for(Car c: listCar) {
				List<CarError> listCarError = new ArrayList<>();
				PreparedStatement psCE = con.prepareStatement(sqlCarE);
				psCE.setInt(1, c.getId());
				ResultSet rsCE = psCE.executeQuery();
				int i = 0;
				while(rsCE.next()) {
					CarError carE = new CarError();
					carE.setId(i++);
					carE.setDateError(rsCE.getDate("dateError"));
					carE.setCost(rsCE.getFloat("cost"));
					carE.setType(rsCE.getInt("type"));
					carE.setStatus(rsCE.getInt("status"));
					Model.Error error = new Model.Error();
					error.setId(rsCE.getInt("idError"));
					error.setName(rsCE.getString("name"));
					carE.setError(error);
					listCarError.add(carE);
				}
				c.setListCarError(listCarError);
			}
			con.commit();
		}catch(Exception e) {
			e.printStackTrace();
			try {
				con.rollback();
			}catch(Exception ex) {
				ex.printStackTrace();
			}
		}finally{
            try{
                con.setAutoCommit(true);
            }catch(Exception e){
                e.printStackTrace();                
            }
        }
		return listCar;
	}
}
