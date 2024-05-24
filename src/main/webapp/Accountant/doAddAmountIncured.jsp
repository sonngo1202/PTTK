<%@page import="Model.RentalContractDetail"%>
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
String idRCD = request.getParameter("txtIdRCD");
String totalAmountIncured = request.getParameter("txtTotalIncured");
if(totalAmountIncured != null && idRCD != null){
	for(RentalContractDetail r : bill.getListRentalContractDetails()){
		if(r.getId()==Integer.parseInt(idRCD.trim())){
			bill.setTotalAmountIncured(bill.getTotalAmountIncured()-r.getTotalAmountIncured());
			r.setTotalAmountIncured(Float.parseFloat(totalAmountIncured.trim()));
			bill.setTotalAmountIncured(bill.getTotalAmountIncured()+r.getTotalAmountIncured());
			break;
		}
	}
	bill.setTotalPayment(bill.getTotalAmountIncured()+bill.getTotalSublease());
}
session.setAttribute("bill", bill);
response.sendRedirect("AddPaymentInvoiceInfo.jsp");
%>
</html>