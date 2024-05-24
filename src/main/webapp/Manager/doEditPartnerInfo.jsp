<%@page import="DAO.PartnerDAO"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="Model.Member"%>
<%@page import="Model.Partner"%>
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
Partner partner = (Partner) session.getAttribute("partner");
request.setCharacterEncoding("UTF-8");
String fullname = request.getParameter("txtFullname");
String dob = request.getParameter("txtDob");
String address = request.getParameter("txtAddress");
String phoneNumber = request.getParameter("txtPhoneNumber");
String email = request.getParameter("txtEmail");
String des = request.getParameter("txtDes");
String cccd = request.getParameter("txtCccd");
String bankName = request.getParameter("txtBankName");
String bankNumber = request.getParameter("txtBankNumber");
if(partner == null){
	partner = new Partner();
}
partner.setFullname(fullname);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
partner.setDob(new Date(sdf.parse(dob).getTime()));
partner.setAddress(address);
partner.setPhoneNumber(phoneNumber);
partner.setEmail(email);
partner.setCccd(cccd);
partner.setBankName(bankName);
partner.setBankNumber(bankNumber);
partner.setDes(des);
PartnerDAO partnerDAO = new PartnerDAO();
boolean kq = false;
if(partner.getId() != 0){
	kq = partnerDAO.updatePartner(partner);
}else{
	kq = partnerDAO.addPartner(partner);
}
if(kq){
	session.removeAttribute("listPartner");
	session.removeAttribute("partner");
	%>
	<script>
		alert("Lưu thành công đối tác");
		window.location.href = "ManagerHome.jsp"
	</script>
<%}else{%>
	<script type="text/javascript">
		alert("Lưu thất bại")
	    history.back()
	</script>
<%} %>
</html>