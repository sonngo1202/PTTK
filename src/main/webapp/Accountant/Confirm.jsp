<%@page import="Model.Bill"%>
<%@page import="Model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Confirm Bill</title>
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
        
        .payment-info{
        	text-align: left;
        }
        
        .manager-info{
        	text-align: left;
        }
        
        label{
        	font-size: 18px;
            font-weight: bold;
            color: black;
        }
        
        p{
            font-size: 18px;
            font-weight: bold;
            color: red;
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
    <%!
        public String formatCurrency(float amount) {
            return String.format("%,.0f đ", amount);
        }
    %>
</head>
<%
Member member = (Member) session.getAttribute("member");
if(member == null){
	response.sendRedirect(request.getContextPath()+ "/Login.jsp?err=timeout");
}
Bill bill = (Bill) session.getAttribute("bill");
if(bill.getListRentalContractDetails()==null || bill.getListRentalContractDetails().isEmpty()){%>
	<script type="text/javascript">
		alert("Hãy thêm hợp đồng để thanh toán");
		window.location.href = "SelectCarToPay.jsp";
	</script>
<%}%>
<body>
	<div class="contener">
		<h2>Thông tin hóa đơn</h2>
		<div class="partner-info">
            <p><label>Số CCCCD:</label> <%=bill.getPartner().getCccd() %></p>
            <p><label>Tên đối tác:</label> <%=bill.getPartner().getFullname() %></p>
            <p><label>Ngày sinh:</label> <%=bill.getPartner().getDob() %></p>
            <p><label>Địa chỉ:</label> <%=bill.getPartner().getAddress() %></p>
            <p><label>Điện thoại:</label> <%=bill.getPartner().getPhoneNumber() %></p>
            <p><label>Email:</label> <%=bill.getPartner().getEmail() %></p>
            <label>Danh sách hợp đồng thuê xe được thanh toán:</label>
        </div>
        <table>
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Tên xe</th>
                    <th>Biển số</th>
                    <th>Ngày thuê</th>
                    <th>Ngày trả</th>
                    <th>Phát sinh</th>
                    <th>Tiền phát sinh</th>
                    <th>Tiền thuê gốc</th>
                </tr>
            </thead>
            <tbody>
                <%if(bill.getListRentalContractDetails()!=null && !bill.getListRentalContractDetails().isEmpty()){
                	for(int i=0; i<bill.getListRentalContractDetails().size(); i++){%>
                		<tr>
		                    <td><%=i+1 %></td>
		                    <td><%=bill.getListRentalContractDetails().get(i).getCar().getName() %></td>
		                    <td><%=bill.getListRentalContractDetails().get(i).getCar().getLicensePlate() %></td>
		                    <td><%=bill.getListRentalContractDetails().get(i).getBorrowedDate() %></td>
		                    <td><%=bill.getListRentalContractDetails().get(i).getRealReturnDate() %></td>
		                    <td><%=(bill.getListRentalContractDetails().get(i).getTotalDamgeAmount() > 0||
		                    bill.getListRentalContractDetails().get(i).getTotalFine() > 0)?"Có":"Không" %></td>
		                    <td><%=formatCurrency(bill.getListRentalContractDetails().get(i).getTotalAmountIncured()) %></td>
		                    <td><%=formatCurrency(bill.getListRentalContractDetails().get(i).getTotalSublease()) %></td>
		                </tr>
                <% }}%>
            </tbody>
        </table>
        <div class="payment-info">
        	<p <%if(bill.getBankName()==null){ %> style="display:none;" <%} %>><label>Tên ngân hàng thanh toán:</label> <%=bill.getBankName() %></p>
        	<p <%if(bill.getBankNumber()==null){ %> style="display:none;" <%} %>><label>Số tài khoản thanh toán</label> <%=bill.getBankNumber() %></p>
        	<p><label>Tổng tiền thuê xe gốc:</label> <%=formatCurrency(bill.getTotalSublease()) %></p>
        	<p><label>Tổng tiền phát sinh:</label> <%=formatCurrency(bill.getTotalAmountIncured()) %></p>
        	<p><label>Tổng tiền cần thanh toán cho đối tác:</label> <%=formatCurrency(bill.getTotalPayment()) %></p>
        </div>
        <div class="manager-info">
        	<p><label>Mã nhân viên:</label> <%=bill.getAccountant().getId() %></p>
        	<p><label>Tên kế toán:</label> <%=bill.getAccountant().getFullname() %></p>
        </div>
        <button class="action-confirm" onclick="openPage('doSaveBill.jsp')">Xác nhận</button>
        <button class="action-cancel" onclick="history.back()">Hủy</button>
	</div>
	<script type="text/javascript">
		 function openPage(pageURL){
		    window.location.href = pageURL;
		 }
	</script>
</body>
</html>
