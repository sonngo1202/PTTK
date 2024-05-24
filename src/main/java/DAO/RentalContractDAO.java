package DAO;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Model.Customer;
import Model.RentalContract;
import Model.RentalContractDetail;

public class RentalContractDAO extends DAO{
	public List<RentalContract> getRentalContractofCar(int idCar, Date date){
		List<RentalContract> listRentalContract = new ArrayList<>();
		String sql = "call getRentalContractofCar(?, ?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setDate(1, date);
			ps.setInt(2, idCar);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				RentalContract rentalContract = new RentalContract();
				rentalContract.setId(rs.getInt("idRC"));
				rentalContract.setSignTime(rs.getDate("SignTime"));
				rentalContract.setRules(rs.getString("rules"));
				rentalContract.setDes(rs.getString("desDC"));
				Customer customer = new Customer();
				customer.setId(rs.getInt("idCus"));
				customer.setFullname(rs.getString("fullname"));
				customer.setDob(rs.getDate("dob"));
				customer.setAddress(rs.getString("address"));
				customer.setPhoneNumber(rs.getString("phoneNumber"));
				customer.setEmail(rs.getString("email"));
				rentalContract.setCustomer(customer);
				RentalContractDetail rentalContractDetail = new RentalContractDetail();
				rentalContractDetail.setId(rs.getInt("id"));
				rentalContractDetail.setPrice(rs.getFloat("price"));
				rentalContractDetail.setFine(rs.getFloat("fine"));
				rentalContractDetail.setCost(rs.getFloat("cost"));
				rentalContractDetail.setBorrowedDate(rs.getDate("borrowedDate"));
				rentalContractDetail.setReturnDate(rs.getDate("returnDate"));
				rentalContractDetail.setRealReturnDate(rs.getDate("realReturnDate"));
				rentalContractDetail.setTotalDamgeAmount(rs.getFloat("totalDamgeAmount"));
				rentalContractDetail.setTotalRent(rs.getFloat("totalRent"));
				rentalContractDetail.setTotalFine(rs.getFloat("totalFine"));
				rentalContractDetail.setTotalSublease(rs.getFloat("totalSublease"));
				rentalContractDetail.setTotalPayment(rentalContractDetail.getTotalDamgeAmount()
						+rentalContractDetail.getTotalRent()+rentalContractDetail.getTotalFine());
				rentalContract.setListRentalContractDetail(new ArrayList<>());
				rentalContract.getListRentalContractDetail().add(rentalContractDetail);
				listRentalContract.add(rentalContract);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return listRentalContract;
	}
}
