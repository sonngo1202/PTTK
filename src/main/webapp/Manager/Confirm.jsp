<%@page import="Model.CarError"%>
<%@page import="Model.Contract"%>
<%@page import="Model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Confirm Contract</title>
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
            width: 60%;
        }
        
        h2 {
            color: #343a40;
            font-size: 40px;
            margin-bottom: 60px;
        }
        
        .partner-info{
             text-align: left;
        }
        
        .rules-info{
        	text-align: left;
        }
        
        .manager-info{
        	text-align: left;
        }
        
        p{
            font-size: 18px;
            font-weight: bold;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            margin-bottom: 20px;
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

        .action-confirm {
            margin-top:40px;
            padding: 10px 15px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 12%;
            margin-right: 5px;
        }
        
        .action-cancel {
            margin-top:40px;
            padding: 10px 15px;
            background-color: #dc3545;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 12%;
            margin-left: 5px;
        }
    </style>
</head>
<%
Member member = (Member) session.getAttribute("member");
if(member == null){
	response.sendRedirect(request.getContextPath()+ "/Login.jsp?err=timeout");
}
Contract contract = (Contract) session.getAttribute("contract");
%>
<body>
	<div class="contener">
		<h2>Thông tin hợp đồng</h2>
		<div class="partner-info">
            <p>Số CCCCD: <%=contract.getPartner().getCccd() %></p>
            <p>Tên đối tác: <%=contract.getPartner().getFullname() %></p>
            <p>Ngày sinh: <%=contract.getPartner().getDob() %></p>
            <p>Địa chỉ: <%=contract.getPartner().getAddress() %></p>
            <p>Điện thoại: <%=contract.getPartner().getPhoneNumber() %></p>
            <p>Email: <%=contract.getPartner().getEmail() %></p>
            <p>Danh sách xe:</p>
        </div>
        <table>
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Biển số</th>
                    <th>Tên xe</th>
                    <th>Màu sắc</th>
                    <th>Năm sản xuất</th>
                    <th>Lỗi có sẵn</th>
                    <th>Chi phí(đ/ngày)</th>
                    <th>Mô tả</th>
                </tr>
            </thead>
            <tbody>
                <%if(contract.getListDetailContract()!=null && !contract.getListDetailContract().isEmpty()){
                	for(int i =0; i< contract.getListDetailContract().size(); i++){%>
                		<tr>
		                    <td><%=i+1 %></td>
		                    <td><%=contract.getListDetailContract().get(i).getCar().getLicensePlate() %></td>
		                    <td><%=contract.getListDetailContract().get(i).getCar().getName() %></td>
		                    <td><%=contract.getListDetailContract().get(i).getCar().getColor() %></td>
		                    <td><%=contract.getListDetailContract().get(i).getCar().getYear() %></td>
		                    <%String listError = "";
		                      if(contract.getListDetailContract().get(i).getCar().getListCarError()!=null){
		                    	  for(CarError ce : contract.getListDetailContract().get(i).getCar().getListCarError()){
			                    	  listError += ce.getError().getName()+", ";
			                      }
			                      if(listError!="") listError = listError.substring(0, listError.length()-2);
		                      }
		                    %>
		                    <td><%=listError %></td>
		                    <td><%=contract.getListDetailContract().get(i).getCost() %></td>
		                    <td><%=contract.getListDetailContract().get(i).getCar().getDes() %></td>
		                </tr>
                <%} }%>
            </tbody>
        </table>
        <div class="rules-info"><p>Điều khoản: <%=contract.getRules() %></p></div>
        <div class="rules-info"><p>Ngày kí: <%=contract.getSigningTime() %></p></div>
        <div class="manager-info">
        	<p>Mã nhân viên: <%=contract.getManager().getId() %></p>
        	<p>Tên quản lí: <%=contract.getManager().getFullname() %></p>
        </div>
        <button class="action-confirm" onclick="openPage('doSaveContract.jsp')">Xác nhận</button>
        <button class="action-cancel" onclick="openPage('AddContractInfo.jsp')">Hủy</button>
	</div>
	<script type="text/javascript">
		 function openPage(pageURL){
		    window.location.href = pageURL;
		 }
	</script>
</body>
</html>