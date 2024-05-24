<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Model.Member"%>
<%@page import="Model.DetailContract"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="Model.Contract"%>
<%@page import="Model.Car"%>
<%@page import="DAO.CarDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<%
Member member = (Member) session.getAttribute("member");
if(member == null){
	response.sendRedirect(request.getContextPath()+ "/Login.jsp?err=timeout");
}
Car car = (Car) session.getAttribute("car");
Contract contract = (Contract) session.getAttribute("contract");
//Khởi tạo listDetailContract
if(contract.getListDetailContract() == null) contract.setListDetailContract(new ArrayList<>());
String checkEdit = (String) session.getAttribute("checkEdit");

//Kiểm tra cập nhật lỗi xe
if(checkEdit!=null && checkEdit.equals("true")&& !car.getListCarError().isEmpty()){
	CarDAO carDAO = new CarDAO();
	boolean kq = carDAO.updateCarErrorofCar(car);
	if(kq){
		%>
		<script>
			alert("Thêm thông tin xe thành công");
			window.location.href = "AddContractInfo.jsp"
		</script>
	<%}else{%>
		<script type="text/javascript">
			alert("Lỗi khi thêm thông tin xe")
		    history.back()
		</script>
	<%}
}

//Lấy hợp đồng chi tiết đã có của xe
DetailContract detailContractCheck = null;
List<Contract> listContract = (List<Contract>) session.getAttribute("listContract");
for(Contract c : listContract){
	if(c.getPartner().getId() == contract.getPartner().getId()){
		for(DetailContract dc : c.getListDetailContract()){
			if(dc.getCar().getId() == car.getId()){
				detailContractCheck = dc;
				break;
			}
		}
	}
}
String txtCost = request.getParameter("txtCost");
String txtCheckin = request.getParameter("txtCheckin");
String txtCheckout = request.getParameter("txtCheckout");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
Date checkinDate = new Date(sdf.parse(txtCheckin).getTime());
Date checkoutDate =  new Date(sdf.parse(txtCheckout).getTime());

//Kiểm tra thời gian gia hạn
if(checkoutDate.before(checkinDate)){%>
	<script type="text/javascript">
		alert("Ngày checkout trước ngày checkin");
		history.back()
	</script>
<%}else if(detailContractCheck != null && 
((detailContractCheck.getCheckin().before(checkoutDate)&&detailContractCheck.getCheckout().after(checkoutDate))||
		(detailContractCheck.getCheckin().before(checkinDate)&&detailContractCheck.getCheckout().after(checkinDate))||
		(detailContractCheck.getCheckin().before(checkinDate)&&detailContractCheck.getCheckout().after(checkoutDate)))){%>
	<script type="text/javascript">
		var checkinTime = "<%= detailContractCheck.getCheckin() %>";
	    var checkoutTime = "<%= detailContractCheck.getCheckout() %>";
		alert("Thời gian gia hạn xe trùng với thời gian gia hạn ở hợp đồng khác. Cụ thể, xe đang gia hạn ở hợp đồng khác từ "+checkinTime +" đến "+checkoutTime)
		history.back();
	</script>
<%}else{
	//
	DetailContract detailContract = new DetailContract();
	detailContract.setId(contract.getListDetailContract().size());
    detailContract.setCar(car);
	detailContract.setCheckin(checkinDate);
	detailContract.setCheckout(checkoutDate);
	detailContract.setCost(Float.parseFloat(txtCost.trim()));
	contract.getListDetailContract().add(detailContract);
	response.sendRedirect("AddContractInfo.jsp");
}%>

</html>