<%@page import="java.sql.Date"%>
<%@page import="Model.Member"%>
<%@page import="Model.Contract"%>
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
Contract contract = (Contract)session.getAttribute("contract");
if(contract.getListDetailContract()==null || contract.getListDetailContract().isEmpty()){%>
	<script type="text/javascript">
		alert("Hãy thêm xe để kí hợp đồng")
		window.location.href = "SelectCar.jsp"
	</script>
<%}else{
	request.setCharacterEncoding("UTF-8");
	String rules = request.getParameter("txtRules");
	contract.setRules(rules);
	java.util.Date utilDate = new java.util.Date();
	contract.setSigningTime(new Date(utilDate.getTime()));
	response.sendRedirect("Confirm.jsp");
}
%>
</html>