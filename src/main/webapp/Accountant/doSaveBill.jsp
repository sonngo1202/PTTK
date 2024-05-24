<%@page import="DAO.BillDAO"%>
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
BillDAO billDAO = new BillDAO();
boolean kq = billDAO.saveBill(bill);
if(kq){
	session.removeAttribute("bill");
	session.removeAttribute("car");
	session.removeAttribute("listCar");
	session.removeAttribute("listPartner");
	session.removeAttribute("listRentalContract");
	session.removeAttribute("month");
	%>
	<script>
		alert("Thanh toán thành công");
		window.location.href = "PayPartnerMonthly.jsp"
	</script>
<%}else{%>
	<script type="text/javascript">
		alert("Thanh toán thất bại")
	    history.back()
	</script>
<%}%>
%>
</html>