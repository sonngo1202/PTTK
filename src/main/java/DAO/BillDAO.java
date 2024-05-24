package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import Model.Bill;
import Model.RentalContractDetail;

public class BillDAO extends DAO{

	public BillDAO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public boolean saveBill(Bill bill) {
		boolean kq = false;
		String sqlBill = "INSERT INTO tblbill(paymentTime, bankName, bankNumber, tblPartnerid, tblAccountantid)\r\n"
				+ "VALUES(?, ?, ?, ?, ?)";
		String sqlURCD = "UPDATE tblrentalcontractdetail SET tblBillid = ?, totalAmountIncured = ? WHERE id = ?";
		try {
			con.setAutoCommit(false);
			PreparedStatement psBill = con.prepareStatement(sqlBill, Statement.RETURN_GENERATED_KEYS);
			psBill.setDate(1, bill.getPaymentTime());
			psBill.setString(2, bill.getBankName());
			psBill.setString(3, bill.getBankNumber());
			psBill.setInt(4, bill.getPartner().getId());
			psBill.setInt(5, bill.getAccountant().getId());
			psBill.executeUpdate();
			ResultSet generatedKeys = psBill.getGeneratedKeys();
		    if(generatedKeys.next()) {
				bill.setId(generatedKeys.getInt(1));
			}
		    PreparedStatement psRCD = con.prepareStatement(sqlURCD);
		    for(RentalContractDetail rcd : bill.getListRentalContractDetails()) {
		    	psRCD.setInt(1, bill.getId());
		    	psRCD.setFloat(2, rcd.getTotalAmountIncured());
		    	psRCD.setInt(3, rcd.getId());
		    	psRCD.addBatch();
		    }
		    psRCD.executeBatch();
		    con.commit();
		    kq = true;
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
		return kq;
	}
}
