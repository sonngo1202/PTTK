<%@page import="Model.Manager"%>
<%@page import="Model.Contract"%>
<%@page import="Model.Member"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="DAO.PartnerDAO"%>
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
Partner partner = new Partner();
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
PartnerDAO partnerDAO = new PartnerDAO();
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
boolean kq = partnerDAO.addPartner(partner);
if(kq){
	Contract contract = new Contract();
	Manager manager = new Manager();
	manager.setId(member.getId());
	manager.setFullname(member.getFullname());
	manager.setAddress(member.getAddress());
	manager.setPhoneNumber(member.getPhoneNumber());
	manager.setEmail(member.getEmail());
	manager.setDes(member.getDes());
	contract.setManager(manager);
	contract.setPartner(partner);
	session.setAttribute("contract", contract);
	%>
	<script>
		alert("Lưu thành công đối tác");
		window.location.href = "SelectCar.jsp"
	</script>
<%}else{%>
	<script type="text/javascript">
		alert("Lưu thất bại! Hãy chắc chắn là số căn cước công dân chưa tồn tại!")
	    history.back()
	</script>
<%}%>
</html>