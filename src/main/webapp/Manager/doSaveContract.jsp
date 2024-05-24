<%@page import="DAO.ContractDAO"%>
<%@page import="Model.Contract"%>
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
Contract contract = (Contract) session.getAttribute("contract");
ContractDAO contractDAO = new ContractDAO();
boolean kq = contractDAO.saveContract(contract);
if(kq){
	session.removeAttribute("contract");
	session.removeAttribute("car");
	session.removeAttribute("listCar");
	session.removeAttribute("listPartner");
	session.removeAttribute("checkEdit");
	%>
	<script>
		alert("Lưu thành công hợp đồng");
		window.location.href = "ManagerHome.jsp"
	</script>
<%}else{%>
	<script type="text/javascript">
		alert("Lưu thất bại")
	    history.back()
	</script>
<%}%>
%>
</html>