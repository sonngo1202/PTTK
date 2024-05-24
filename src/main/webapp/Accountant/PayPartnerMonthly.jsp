<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="DAO.PartnerDAO"%>
<%@page import="Model.Partner"%>
<%@page import="java.util.List"%>
<%@page import="Model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pay Partnet Monthly</title>
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
            width: 80%;
        }
        
        h2 {
            color: #343a40;
            font-size: 40px;
            margin-bottom: 80px;
        }

        form {
            display: flex;
        }
        .form-group{
        	text-align: left;
        }
        
        .form-submit{
        	padding-top: 38px;
        }
        
        label {
            color: #555;
            font-weight: bold;
            display: block;
        }

        input[type="month"] {
            padding: 10px;
            margin-right: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            width: 300px;
        }

        input[type="submit"] {
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100px;
        }
        
        a {
            padding: 10px 15px;
            background-color: #28a745;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            font-size: 16px;
            margin-left: 10px;
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
            width: 10%;
        }
    </style>
</head>
<%
Member member = (Member) session.getAttribute("member");
if(member == null){
	response.sendRedirect(request.getContextPath()+ "/Login.jsp?err=timeout");
}
session.removeAttribute("bill");
String month = request.getParameter("txtMonth");
List<Partner> listPartner = null;
if(month != null){
	session.setAttribute("month", month);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	if(new Date(System.currentTimeMillis()).before(new Date(sdf.parse(month+"-01").getTime()))){%>
		<script type="text/javascript">
			alert("Thời gian muốn thanh toán chưa tới! Vui lòng chọn thời gian phù hợp!")
			window.location.href = "PayPartnerMonthly.jsp";
		</script>
	<%}
	PartnerDAO partnerDAO = new PartnerDAO();	
	listPartner = partnerDAO.getPartnerToPay(new Date(sdf.parse(month.trim()+"-1").getTime()));
	session.setAttribute("listPartner", listPartner);
}
%>
<body>
	<div class="contener">
		<h2>Thanh toán cho đối tác hàng tháng</h2>
		<form action="PayPartnerMonthly.jsp" method="get">
			<div class="form-group">
				<label>Tháng thanh toán</label><br/>
				<input type="month" name="txtMonth" required />
			</div>
			<div class="form-submit"><input type="submit" value="Tìm"/></div>
		</form>
		<table>
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Số CCCD</th>
                    <th>Họ tên</th>
                    <th>Ngày sinh</th>
                    <th>Địa chỉ</th>
                    <th>Số điện thoại</th>
                    <th>Email</th>
                    <th>Chọn</th>
                </tr>
            </thead>
            <tbody>
                <%if(listPartner!=null && !listPartner.isEmpty()){
                	for(int i = 0; i < listPartner.size(); i++){ %>
                		<tr>
		                    <td><%=i+1 %></td>
		                    <td><%=listPartner.get(i).getCccd() %></td>
		                    <td><%=listPartner.get(i).getFullname()%></td>
		                    <td><%=listPartner.get(i).getDob() %></td>
		                    <td><%=listPartner.get(i).getAddress() %></td>
		                    <td><%=listPartner.get(i).getPhoneNumber() %></td>
		                    <td><%=listPartner.get(i).getEmail() %></td>
		                    <td>
		                        <a href="SelectCarToPay.jsp?id=<%= listPartner.get(i).getId()%>">Chọn</a>
		                    </td>
		                </tr>
                <%} }%>
            </tbody>
        </table>
        <div class="action-back"><button onclick="openPage('AccountantHome.jsp')">Quay lại</button></div>
	</div>
	<script type="text/javascript">
	 function openPage(pageURL){
	    window.location.href = pageURL;
	 }
	</script>
</body>
</html>