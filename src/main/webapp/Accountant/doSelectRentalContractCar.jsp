<%@page import="java.util.Arrays"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.RentalContractDetail"%>
<%@page import="Model.RentalContract"%>
<%@page import="java.util.List"%>
<%@page import="Model.Car"%>
<%@page import="Model.Bill"%>
<%@page import="Model.Member"%>
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
Bill bill = (Bill) session.getAttribute("bill");
Car car = (Car) session.getAttribute("car");
List<RentalContract> listRentalContract = (List<RentalContract>) session.getAttribute("listRentalContract");
String []idRCD = request.getParameterValues("cbInfoRentalContractDetail");
if(idRCD==null){%>
	<script type="text/javascript">
		alert("Hãy chọn ít nhất 1 hợp đồng để thanh toán")
		history.back()
	</script>
<%}else{
	List<Integer> listIdRCD = new ArrayList<>();
	for(String id : idRCD){
		listIdRCD.add(Integer.parseInt(id.trim()));
	}
	if(bill.getListRentalContractDetails() == null) bill.setListRentalContractDetails(new ArrayList<>());
	Iterator<RentalContractDetail> iterator = bill.getListRentalContractDetails().iterator();
	while (iterator.hasNext()) {
	    RentalContractDetail rcd = iterator.next();
	    if (rcd.getCar().getId() == car.getId() && !listIdRCD.contains(rcd.getId())) {
	    	bill.setTotalAmountIncured(bill.getTotalAmountIncured()-rcd.getTotalAmountIncured());
	    	bill.setTotalSublease(bill.getTotalSublease()-rcd.getTotalSublease());
	    	bill.setTotalPayment(bill.getTotalAmountIncured()+bill.getTotalSublease());
	        iterator.remove();
	    }else if(listIdRCD.contains(rcd.getId())){
	    	listIdRCD.remove(Integer.valueOf(rcd.getId()));
	    }
	}
	for(RentalContract rc: listRentalContract){
		for(int id: listIdRCD){
			if(rc.getListRentalContractDetail().get(0).getId()==id){
				bill.getListRentalContractDetails().add(rc.getListRentalContractDetail().get(0));
				bill.setTotalAmountIncured(bill.getTotalAmountIncured()+rc.getListRentalContractDetail().get(0).getTotalAmountIncured());
		    	bill.setTotalSublease(bill.getTotalSublease()+rc.getListRentalContractDetail().get(0).getTotalSublease());
		    	bill.setTotalPayment(bill.getTotalAmountIncured()+bill.getTotalSublease());
				continue;
			}
		}
	}
	session.setAttribute("bill", bill);
	response.sendRedirect("AddPaymentInvoiceInfo.jsp");
}
%>
</html>
