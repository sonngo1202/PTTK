<%@page import="Model.Bill"%>
<%@page import="Model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Transfer</title>
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
            width: 800px;
        }
        
        h2 {
            color: #343a40;
            font-size: 40px;
            margin-bottom: 80px;
        }
        

        form {
        	text-align: left;
        }

        input[type="text"] {
            flex: 1;
            padding: 10px;
            margin-right: 5px;
            border: none;
            font-size: 24px;
            background-color: #f8f9fa;
            margin-left: 20px;
            color: #dc3545;
        }
        
        input[type="text"]:focus{
        	outline: none;
        }
        
        .info-pay{
        	margin-bottom: 10px;
        }
        
        #info-price{
        	color: #dc3545;
        }
        
        label{
        	font-size: 24px;
        }

        input[type="submit"] {
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
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
        
        .action-button{
            text-align: left;
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
            width: 15%;
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
String bankName = request.getParameter("txtBankName");
String bankNumber = request.getParameter("txtBankNumber");
if(bill.getListRentalContractDetails()==null || bill.getListRentalContractDetails().isEmpty()){%>
<script type="text/javascript">
	alert("Hãy thêm hợp đồng để thanh toán");
	window.location.href = "SelectCarToPay.jsp";
</script>
<%}%>
%>
<body>
	<div class="contener">
	    <h2>Chuyển khoản cho đối tác</h2>
		<form action="doTransfer.jsp" method="post">
			<label>Tên ngân hàng:</label><input type="text" name="txtBankName" value="<%=bankName!=null?bankName:bill.getPartner().getBankName() %>" readonly/><br/>
			<label>Số tài khoản:</label><input type="text" name="txtBankNumber" value="<%=bankNumber!=null?bankNumber:bill.getPartner().getBankNumber() %>" readonly/><br/>
			<div class="info-pay"><label>Tổng tiền thuê xe gốc: </label><label id="info-price"><%=formatCurrency(bill.getTotalSublease()) %></label><br/></div>
			<div class="info-pay"><label>Tổng tiền phát sinh: </label><label id="info-price"><%=formatCurrency(bill.getTotalAmountIncured()) %></label><br/></div>
			<div class="info-pay"><label>Tổng tiền cần thanh toán cho đối tác: </label><label id="info-price"><%=formatCurrency(bill.getTotalPayment()) %></label><br/></div>
			<input type="submit" value="Thanh toán" />
		</form>
		<div class="action-button">
		    <button onclick="openPage('SelectBank.jsp')" style="background-color: #28a745; width:24%">Chọn ngân hàng khác</button>
			<button onclick="openPage('AddPaymentInvoiceInfo.jsp')" style="background-color: black">Quay lại</button>
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
	</script>
</body>
</html>