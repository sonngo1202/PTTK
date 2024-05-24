<%@page import="Model.Member"%>
<%@page import="DAO.ContractDAO"%>
<%@page import="Model.Contract"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Contract</title>
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
            width: 80%;
        }
        
        h2 {
            color: #343a40;
            font-size: 40px;
            margin-bottom: 80px;
        }
        
        .action-addContract{
            text-align: left;
            margin-bottom: 25px;
        }
        
        a {
            padding: 10px 20px;
            background-color: #28a745;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            font-size: 20px;
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
List<Contract> listContract = null;
ContractDAO contractDAO = new ContractDAO();
listContract = contractDAO.getAllContract();
session.setAttribute("listContract", listContract);
%>
<body>
	<div class="contener">
        <h2>Kí hợp đồng cho thuê lại xe</h2>
        <div class="action-addContract"><a href="SelectPartner.jsp">Thêm hợp đồng mới</a></div>
        <table>
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Mã hợp đồng</th>
                    <th>Số CCCD</th>
                    <th>Họ tên</th>
                    <th>Số xe</th>
                    <th>Thời gian kí</th>
                    <th>Chọn</th>
                </tr>
            </thead>
            <tbody>
                <%if(listContract!=null && !listContract.isEmpty()){
                	for(int i=0; i < listContract.size(); i++){%>
                		<tr>
		                   <td><%=i+1 %></td>
		                   <td><%= listContract.get(i).getId() %></td>
		                   <td><%= listContract.get(i).getPartner().getCccd() %></td>
		                   <td><%= listContract.get(i).getPartner().getFullname() %></td>
		                   <td><%= listContract.get(i).getTotalCar() %></td>
		                   <td><%= listContract.get(i).getSigningTime() %></td>
		                   <td>
		                       <a href="#">Xem</a>
		                       <a href="#">Sửa</a>
		                       <a href="#">Xóa</a>
		                   </td>
		               </tr>
                <% }}%>
            </tbody>
        </table>
        <div class="action-back"><button onclick="openPage('ManagerHome.jsp')">Quay lại</button></div>
    </div>
    <script type="text/javascript">
	 function openPage(pageURL){
	    window.location.href = pageURL;
	 }
	</script>
</body>
</html>