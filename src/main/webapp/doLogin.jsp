<%@page import="DAO.MemberDAO"%>
<%@page import="Model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<%
String txtUsername = request.getParameter("txtUsername");
String txtPassword = request.getParameter("txtPassword");
Member member = new Member();
member.setUsername(txtUsername);
member.setPassword(txtPassword);
MemberDAO memberDAO = new MemberDAO();
boolean kq = memberDAO.checkLogin(member);
if(kq){
	session.setAttribute("member", member);
	if(member.getPosition().equalsIgnoreCase("quan li")){
		response.sendRedirect("./Manager/ManagerHome.jsp");
	}else if(member.getPosition().equalsIgnoreCase("ke toan")){
		response.sendRedirect("./Accountant/AccountantHome.jsp");
	}else{%>
		<script type="text/javascript">
			alert("Đây là trang của khách hàng");
			history.back();
		</script>
	<%}
}else{
	response.sendRedirect("Login.jsp?err=fail");
}
%>
</html>