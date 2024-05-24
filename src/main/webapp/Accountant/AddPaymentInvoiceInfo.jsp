<%@page import="Model.RentalContractDetail"%>
<%@page import="Model.Bill"%>
<%@page import="Model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Payment Invoice Info</title>
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
        
        .action-add{
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
        
        .info-payment-item{
        	display: flex;
        }
        
        .item-label{
        	flex: 1;
        	text-align: left;
        	margin-left: 60%;
        }
        
        .item-label p{
        	font-size: 18px;
        	font-weight: bold;
        }
        
        .item-value{
         	flex:1;
        	text-align: right;
        }
        
        .item-value p{
        	font-size: 18px;
        	font-weight: bold;
        	color: red;
        }
        
        
        .action-button{
            text-align: right;
            margin-top: 10px;
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
            width: 18%;
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
String id = request.getParameter("id");
bill.setBankName(null);
bill.setBankNumber(null);
if(id!=null){
	for(RentalContractDetail rcd : bill.getListRentalContractDetails()){
		if(rcd.getId()==Integer.parseInt(id.trim())){
			bill.setTotalAmountIncured(bill.getTotalAmountIncured()-rcd.getTotalAmountIncured());
	    	bill.setTotalSublease(bill.getTotalSublease()-rcd.getTotalSublease());
	    	bill.setTotalPayment(bill.getTotalAmountIncured()+bill.getTotalSublease());
	    	bill.getListRentalContractDetails().remove(rcd);
	    	break;
		}
	}
}
%>
<body>
	<div class="contener">
		<h2>Thêm thông tin hóa đơn thanh toán</h2>
		<div class="action-add"><a href="SelectCarToPay.jsp">Thanh toán thêm</a></div>
		<table>
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Ngày thuê</th>
                    <th>Ngày trả</th>
                    <th>Phát sinh</th>
                    <th>Tiền phát sinh</th>
                    <th>Tiền thuê gốc</th>
                    <th>Chọn</th>
                </tr>
            </thead>
            <tbody>
                <%if(bill.getListRentalContractDetails()!=null && !bill.getListRentalContractDetails().isEmpty()){
                	for(int i=0; i<bill.getListRentalContractDetails().size(); i++){%>
                		<tr>
		                    <td><%=i+1 %></td>
		                    <td><%=bill.getListRentalContractDetails().get(i).getBorrowedDate() %></td>
		                    <td><%=bill.getListRentalContractDetails().get(i).getRealReturnDate() %></td>
		                    <td><%=(bill.getListRentalContractDetails().get(i).getTotalDamgeAmount() > 0||
		                    bill.getListRentalContractDetails().get(i).getTotalFine() > 0)?"Có":"Không" %></td>
		                    <td><%=formatCurrency(bill.getListRentalContractDetails().get(i).getTotalAmountIncured()) %></td>
		                    <td><%=formatCurrency(bill.getListRentalContractDetails().get(i).getTotalSublease()) %></td>
		                    <td><a href="AddAmountIncured.jsp?id=<%=bill.getListRentalContractDetails().get(i).getId() %> ">Thêm phát sinh</a>
		                    	<a href="#" onclick="confirmDelete('<%=bill.getListRentalContractDetails().get(i).getId()%>');">Xóa</a></td>
		                </tr>
                <% }}%>
            </tbody>
        </table>
        <div class="info-payment">
        	<div class="info-payment-item">
        		<div class="item-label"><p>Tổng chi phí thuê xe</p></div>
        		<div class="item-value"><p><%=formatCurrency(bill.getTotalSublease()) %></p></div>
        	</div>
        	<div class="info-payment-item">
        		<div class="item-label"><p>Tổng chi phí phát sinh</p></div>
        		<div class="item-value"><p><%=formatCurrency(bill.getTotalAmountIncured()) %></p></div>
        	</div>
        	<div class="info-payment-item">
        		<div class="item-label"><p>Tổng thanh toán</p></div>
        		<div class="item-value"><p><%=formatCurrency(bill.getTotalPayment()) %></p></div>
        	</div>
        </div>
        <div class="action-button">
        	<button onclick="openPage('Confirm.jsp')" style="background-color: #28a745">Thanh toán trực tiếp</button>
        	<button onclick="openPage('Transfer.jsp')" style="background-color: #007bff">Chuyển khoản</button>
        	<button onclick="confirmCancel('PayPartnerMonthly.jsp')">Hủy</button>
        </div>
	</div>
	<script type="text/javascript">
		 function openPage(pageURL){
		    window.location.href = pageURL;
		 }
		 function confirmCancel(pageURL){
		    if(confirm("Bạn có chắc muốn hủy quá trình thanh toán ?")){
		    	window.location.href = pageURL;
		    }
		 }
		 function confirmDelete(id) {
		    if (confirm("Bạn có chắc chắn muốn xóa?")) {
		        window.location.href = "AddPaymentInvoiceInfo.jsp?id=" + id;
		    }
		}
	</script>
</body>
</html>