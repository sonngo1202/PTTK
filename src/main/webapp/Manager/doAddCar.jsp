<%@page import="DAO.CarDAO"%>
<%@page import="Model.Car"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<%
request.setCharacterEncoding("UTF-8");
String licensePlate = request.getParameter("txtLicensePlate");
String name = request.getParameter("txtName");
String color = request.getParameter("txtColor");
String year = request.getParameter("txtYear");
String des = request.getParameter("txtDes");
Car car = new Car();
car.setLicensePlate(licensePlate);
car.setName(name);
car.setColor(color);
car.setYear(year);
car.setDes(des);
CarDAO carDAO = new CarDAO();
boolean kq = carDAO.saveCar(car);
if(kq){
	session.setAttribute("car", car);
	%>
	<script>
		alert("Lưu thành công xe");
		window.location.href = "EnterCarRentalInfo.jsp"
	</script>
<%}else{%>
	<script type="text/javascript">
		alert("Lưu thất bại! Hãy chắc chắn là biển số xe chưa tồn tại!")
	    history.back()
	</script>
<%}%>
</html>