<%@page import="Model.Accountant"%>
<%@page import="Model.Bill"%>
<%@page import="Model.Partner"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="DAO.CarDAO"%>
<%@page import="Model.Car"%>
<%@page import="java.util.List"%>
<%@page import="Model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Select Car to Pay</title>
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
            text-align: center;
            align-items: center;
            width: 70%;
        }

        h2 {
            color: #343a40;
            font-size: 40px;
        }
        
        .partner-info{
             text-align: left;
             margin-bottom: 30px;
        }
        
        p{
            font-size: 18px;
            font-weight: bold;
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
        
        .action-back{
            text-align: right;
            margin-right: 10px;
        }

        button {
            padding: 10px;
            background-color: black;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
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
Bill bill = null;
List<Car> listCar = null;
List<Partner> listPartner = (List<Partner>) session.getAttribute("listPartner");
String idPartner = request.getParameter("id");
String month = (String) session.getAttribute("month");
if(idPartner != null && listPartner != null){
	bill = new Bill();
	for(Partner partner : listPartner){
		if(partner.getId()==Integer.parseInt(idPartner)){
			bill.setPartner(partner);
			break;
		}
	}
	Accountant accountant = new Accountant();
	accountant.setId(member.getId());
	accountant.setFullname(member.getFullname());
	accountant.setAddress(member.getAddress());
	accountant.setPhoneNumber(member.getPhoneNumber());
	accountant.setEmail(member.getEmail());
	accountant.setDes(member.getDes());
	bill.setAccountant(accountant);
	bill.setPaymentTime(new Date(new java.util.Date().getTime()));
	session.setAttribute("bill", bill);
}else{
	bill = (Bill) session.getAttribute("bill");
}
if(month != null){
	CarDAO carDAO = new CarDAO();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	listCar = carDAO.getCarofPartnerToPay(new Date(sdf.parse(month+"-01").getTime()), bill.getPartner().getId());
	session.setAttribute("listCar", listCar);
}
%>
<body>
	<div class="contener">
		<h2>Chọn xe để thanh toán</h2>
        <div class="partner-info">
            <p>Số CCCCD: <%=bill.getPartner().getCccd() %></p>
            <p>Tên đối tác: <%=bill.getPartner().getFullname() %></p>
        </div>
        <table>
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Biển số</th>
                    <th>Tên xe</th>
                    <th>Màu sắc</th>
                    <th>Năm sản xuất</th>
                    <th>Mô tả</th>
                    <th>Chọn</th>
                </tr>
            </thead>
            <tbody>
                <%if(listCar!=null && !listCar.isEmpty())
                	for(int i = 0; i < listCar.size(); i++){ %>
                		<tr>
		                    <td><%=i+1 %></td>
		                    <td><%=listCar.get(i).getLicensePlate() %></td>
		                    <td><%=listCar.get(i).getName() %></td>
		                    <td><%=listCar.get(i).getColor() %></td>
		                    <td><%=listCar.get(i).getYear() %></td>
		                    <td><%=listCar.get(i).getDes() %></td>
		                    <td>
		                        <a href="SelectRentalContractCar.jsp?id=<%=listCar.get(i).getId()%>">Chọn</a>
		                    </td>
                		</tr>
                <%} %>
            </tbody>
        </table>
        <div class="action-back">
            <button onclick="openPage('PayPartnerMonthly.jsp')">Quay lại</button><br/>
        </div>
	</div>
	<script type="text/javascript">
	 function openPage(pageURL){
	    window.location.href = pageURL;
	 }
	</script>
</body>
</html>