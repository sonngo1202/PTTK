<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Date"%>
<%@page import="Model.CarError"%>
<%@page import="Model.Car"%>
<%@page import="Model.Error"%>
<%@page import="java.util.List"%>
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
Car car = (Car) session.getAttribute("car");
List<Error> listError = (List<Error>) session.getAttribute("listError");
String idError = request.getParameter("idError");
CarError carE = new CarError();
for(Error e: listError){
	if(e.getId()==Integer.parseInt(idError.trim())){
		carE.setError(e);
		break;
	}
}
if(car.getListCarError()==null) car.setListCarError(new ArrayList<>());
carE.setId(car.getListCarError().size());
//Chưa sửa
carE.setStatus(0);
//Lỗi do chủ xe làm
carE.setType(0);
carE.setCost(0);
java.util.Date utilDate = new java.util.Date();
carE.setDateError(new Date(utilDate.getTime()));
car.getListCarError().add(carE);
session.setAttribute("car", car);
session.setAttribute("checkEdit", "true");
response.sendRedirect("EnterCarRentalInfo.jsp");
%>
</html>