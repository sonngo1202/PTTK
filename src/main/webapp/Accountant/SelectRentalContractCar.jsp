<%@page import="Model.RentalContractDetail"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="DAO.RentalContractDAO"%>
<%@page import="Model.RentalContract"%>
<%@page import="DAO.ContractDAO"%>
<%@page import="Model.Car"%>
<%@page import="java.util.List"%>
<%@page import="Model.Bill"%>
<%@page import="Model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Select Rental Contract Car</title>
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
            width: 1000px;
        }
        
        h2 {
            color: #343a40;
            font-size: 40px;
            margin-bottom: 80px;
        }
        
        .car-info{
             text-align: left;
             margin-bottom: 20px;
        }
        
        p{
            font-size: 18px;
            font-weight: bold;
        }
        
        form {
        	margin-top: 30px;
        	text-align: center;
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
        
        .action-submit{
        	text-align: right;
        	margin-top: 30px;
        }
        

        input[type="submit"] {
            flex:1;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 18%;
        }
        
        .action-back{
            text-align: right;
            margin-top: 5px;
        }
        
        button {
            padding: 10px 15px;
            background-color: black;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
            width: 18%;
        }
    </style>
</head>
<%
Member member = (Member) session.getAttribute("member");
if(member == null){
	response.sendRedirect(request.getContextPath()+ "/Login.jsp?err=timeout");
}
Car car = null;
List<RentalContract> listRentalContract = null;
Bill bill = (Bill) session.getAttribute("bill");
List<Car> listCar = (List<Car>) session.getAttribute("listCar");
String month = (String) session.getAttribute("month");
String id = request.getParameter("id");
if(id != null){
	for(Car c : listCar){
		if(c.getId()==Integer.parseInt(id.trim())){
			car = c;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			RentalContractDAO rentalContractDAO = new RentalContractDAO();
			listRentalContract = rentalContractDAO.getRentalContractofCar(car.getId(), new Date(sdf.parse(month+"-01").getTime()));
			break;
		}
	}
}
if(listRentalContract !=null && !listRentalContract.isEmpty()){
	for(RentalContract rc : listRentalContract){
		rc.getListRentalContractDetail().get(0).setCar(car);
	}
}

session.setAttribute("car", car);
session.setAttribute("listRentalContract", listRentalContract);
%>
<body>
	<div class="contener">
		<h2>Chọn hợp đồng thuê xe để thanh toán</h2>
		<div class="car-info">
			<p>Biển số: <%=car.getLicensePlate() %></p>
			<p>Tên xe: <%=car.getName() %></p>
			<p>Màu sắc: <%=car.getColor() %></p>
			<p>Năm sản xuất: <%=car.getYear() %></p>
		</div>
		<form action="doSelectRentalContractCar.jsp" method="post">
			<table>
	            <thead>
	                <tr>
	                    <th>STT</th>
	                    <th>Mã hợp đồng</th>
	                    <th>Họ tên</th>
	                    <th>Số CCCD</th>
	                    <th>Số điện thoại</th>
	                    <th>Ngày thuê</th>
	                    <th>Ngày trả</th>
	                    <th>Xem chi tiết</th>
	                    <th>Chọn</th>
	                </tr>
	            </thead>
	            <tbody>
	                <%if(listRentalContract !=null && !listRentalContract.isEmpty()){
	                	for(int i = 0; i < listRentalContract.size();i++){ %>
	                		<tr>
			                    <td><%=i+1 %></td>
			                    <td><%=listRentalContract.get(i).getId() %></td>
			                    <td><%=listRentalContract.get(i).getCustomer().getFullname() %></td>
			                    <td><%=listRentalContract.get(i).getCustomer().getDob() %></td>
			                    <td><%=listRentalContract.get(i).getCustomer().getPhoneNumber() %></td>
			                    <td><%=listRentalContract.get(i).getListRentalContractDetail().get(0).getBorrowedDate() %></td>
			                    <td><%=listRentalContract.get(i).getListRentalContractDetail().get(0).getRealReturnDate() %></td>
			                    <td><a href="RentalContractCar.jsp?id=<%=listRentalContract.get(i).getId() %>">Xem</a></td>
			                    <td>
								    <input type="checkbox" name="cbInfoRentalContractDetail" value="<%=listRentalContract.get(i).getListRentalContractDetail().get(0).getId() %> "
								        <% 
								        if (bill.getListRentalContractDetails() != null) {
								            boolean contains = false;
								            for (RentalContractDetail rcd : bill.getListRentalContractDetails()) {
								                if (rcd.getId() == listRentalContract.get(i).getListRentalContractDetail().get(0).getId()) {
								                    contains = true;
								                    break;
								                }
								            }
								            if (contains) { %>
								                checked="checked"
								        <% } } %>
								    />
								</td>
			                    
			                </tr>
	                <% }}%>
	            </tbody>
	        </table>
	        <div class="action-submit"><input type="submit" value="Tiếp tục"/></div>
		</form>
		<div class="action-back"><button onclick="openPage('SelectCarToPay.jsp')">Quay lại</button></div>
	</div>
	<script type="text/javascript">
		 function openPage(pageURL){
		    window.location.href = pageURL;
		 }
	</script>
</body>
</html>