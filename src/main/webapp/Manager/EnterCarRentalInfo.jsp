<%@page import="Model.CarError"%>
<%@page import="java.util.List"%>
<%@page import="Model.Car"%>
<%@page import="Model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Enter Car Rental Info</title>
	<style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 60vh;
        }

        .contener {
            text-align:center;
            align-items: center;
            width: 900px;
        }
        
        h2 {
            color: #343a40;
            font-size: 40px;
            margin-bottom: 80px;
        }
        
        .car-info{
             text-align: left;
             margin-bottom: 50px;
        }
        
        p{
            font-size: 18px;
            font-weight: bold;
        }
        
        .content-item {
            display: flex;
            justify-content: space-between;
            align-items: center; /* Căn giữa theo chiều dọc */
            width: 100%;
            margin-bottom: 10px;
        }
        
        .action-addCarError{
        	text-align: left;
        }
        
        a {
            padding: 10px 15px;
            background-color: #28a745;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            font-size: 16px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #dee2e6;
            padding: 12px;
            text-align: center;
            font-size: 16px;
        }

        th {
            background-color: #007bff;
            color: #fff;
        }

        tbody tr:hover {
            background-color: #f5f5f5;
        }
        
        td a {
            display: inline-block;
            margin: 10px 0;
            padding: 10px 15px;
            background-color: #28a745;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            font-size: 16px;
        }
        
        form {
        	margin-top: 30px;
        }
        
        .cost-input{
            text-align: left;
        }

        input[type="text"] {
            padding: 10px;
            margin-right: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            width: 98%;
            margin-top: 15px;
        }
        input[type="date"] {
            padding: 10px;
            margin-right: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            width: 98%;
            margin-top: 15px;
        }
        
        .action-submit{
        	margin-top:20px;
        	text-align: right;
        }

        input[type="submit"] {
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 10%;
        }
        
        .action-button{
            text-align: right;
        }
        
        button {
            padding: 10px 15px;
            background-color: #dc3545;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
            width: 10%;
        }
    </style>
</head>
<%
Member member = (Member) session.getAttribute("member");
if(member == null){
	response.sendRedirect(request.getContextPath()+ "/Login.jsp?err=timeout");
}
Car car = null;
String idCar = request.getParameter("id");
if(idCar == null){
	car = (Car) session.getAttribute("car");
}else{
	List<Car> listCar = (List<Car>) session.getAttribute("listCar");
	for(Car c: listCar){
		if(c.getId()==Integer.parseInt(idCar.trim())){
			car = c;
			session.setAttribute("car", car);
			break;
		}
	}
}
//Xóa lỗi xe
String idCE = request.getParameter("idCE");
if(idCE!=null && idCE.trim()!=""){
	for(CarError ce : car.getListCarError()){
		if(ce.getId()==Integer.parseInt(idCE.trim())){
			ce.setStatus(1);
			response.sendRedirect("EnterCarRentalInfo.jsp");
		}
	}
	session.setAttribute("checkEdit", "true");
}
%>
<body>
	<div class="contener">
	    <h2>Thêm thông tin xe cho thuê</h2>
		<div class="car-info">
			<p>Biển số: <%=car != null? car.getLicensePlate():"" %></p>
			<p>Tên xe: <%=car != null? car.getName():"" %></p>
			<p>Màu sắc: <%=car != null? car.getColor():"" %></p>
			<p>Năm sản xuất: <%=car != null? car.getYear():"" %></p>
		</div>
		<div class="action-addCarError"><a href="AddCarError.jsp">Thêm lỗi mới</a></div>
		<table>
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Tên lỗi</th>
                    <th>Ngày bị lỗi</th>
                    <th>Chọn</th>
                </tr>
            </thead>
            <tbody>
                <%if(car.getListCarError()!=null && !car.getListCarError().isEmpty()){
                    for(int i=0; i< car.getListCarError().size();i++){
                       if(car.getListCarError().get(i).getStatus() == 0){%>
                    	<tr>
		                    <td><%= i+1 %></td>
		                    <td><%=car.getListCarError().get(i).getError().getName()  %></td>
		                    <td><%=car.getListCarError().get(i).getDateError() %></td>
		                    <td>
		                        <a href="EnterCarRentalInfo.jsp?idCE=<%= car.getListCarError().get(i).getId()%>">Xóa</a>
		                    </td>
                		</tr>
                <%}}} %>
            </tbody>
        </table>
        <form action="doEnterCarRentalInfo.jsp" method="post">
            <div class="cost-input"><input type="date" name="txtCheckin" placeholder="Nhập ngày bắt đầu cho thuê" required/></div>
            <div class="cost-input"><input type="date" name="txtCheckout" placeholder="Nhập ngày kết thúc cho thuê" required/></div>
        	<div class="cost-input"><input type="text" name="txtCost" placeholder="Nhập chi phí thuê xe (tính theo đồng/ngày)" required/></div>
        	<div class="action-submit"><input type="submit" value="Tiếp tục"> </div>
        </form>
        <div class="action-button">
            <button onclick="openPage('SelectCar.jsp')" style="background-color: black">Quay lại</button><br/>
        	<button onclick="confirmCancel('SignContract.jsp')">Hủy</button>
        </div>
	</div>
	<script type="text/javascript">
		 function openPage(pageURL){
		    window.location.href = pageURL;
		 }
		 function confirmCancel(pageURL){
		    if(confirm("Bạn có chắc muốn hủy quá trình kí hợp đồng ?")){
		    	window.location.href = pageURL;
		    }
		 }
	</script>
</body>
</html>