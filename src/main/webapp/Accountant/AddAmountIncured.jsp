<%@page import="Model.CarError"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="Model.RentalContractDetail"%>
<%@page import="Model.Bill"%>
<%@page import="Model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Amount Incured</title>
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
            width: 600px;
        }
        
        h2 {
            color: #343a40;
            font-size: 40px;
            margin-bottom: 80px;
        }
        
        .content{
        	display: flex;
        	padding-right: 10px;
        }
        
        .content-label{
        	text-align: left;
        }
        
        .content-label p{
        	font-weight: bold;
        	font-size: 18px;
        }
        
        .content-value{
        	flex:1;
        	text-align: right;
        }
        
        .content-value p{
        	font-weight: bold;
        	font-size: 18px;
        }
       

        form {
        	text-align: left;
        }

        input[type="text"] {
            padding: 10px;
            margin-right: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            margin-bottom: 20px;
            width: 96%;
        }
        
        .action-submit{
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
            width: 15%;
        }
        
        .action-back{
            text-align: left;
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
            width: 15%;
        }
    </style>
    <%!
	    public String convertSqlDateToString(Date sqlDate) {
	        if (sqlDate == null) {
	            return null;
	        }
	        SimpleDateFormat outputFormat = new SimpleDateFormat("dd/MM/yyyy");
	
	        try {
	            return outputFormat.format(sqlDate);
	        } catch (Exception e) {
	            e.printStackTrace();
	            return null;
	        }
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
RentalContractDetail rcd = null;
String listCE = "";
if(id!=null){
	for(RentalContractDetail r : bill.getListRentalContractDetails()){
		if(r.getId()==Integer.parseInt(id.trim())){
			rcd = r;
			break;
		}
	}
	for(CarError ce : rcd.getCar().getListCarError()){
		if(ce.getType()==1&&
				(ce.getDateError().before(rcd.getRealReturnDate())&&
				ce.getDateError().after(rcd.getBorrowedDate()))||
				ce.getDateError().equals(rcd.getRealReturnDate())||
				ce.getDateError().equals(rcd.getBorrowedDate())){
			listCE += ce.getError().getName()+", ";
		}
	}
}
%>
<body>
	<div class="contener">
		<h2>Thêm chi phí phát sinh</h2>
		<div class="content">
			<div class="content-label">
				<p>Tên xe:</p>
				<p>Biển số:</p>
				<p>Thời gian bắt đầu thuê:</p>
				<p>Thời gian trả xe đúng hạn:</p>
				<p>Thời gian trả thực tế:</p>
				<p>Tình trạng xe khi trả</p>
			</div>
			<div class="content-value">
				<p><%=rcd.getCar().getName() %></p>
				<p><%=rcd.getCar().getLicensePlate() %></p>
				<p><%=convertSqlDateToString(rcd.getBorrowedDate()) %></p>
				<p><%=convertSqlDateToString(rcd.getReturnDate()) %></p>
				<p <%if (!rcd.getRealReturnDate().equals(rcd.getReturnDate())) {%>style="color: #dc3545;"<% } %>><%=convertSqlDateToString(rcd.getRealReturnDate()) %></p>
				<p <%if (!listCE.isEmpty()) {%>style="color: #dc3545;"<% } %>><%= listCE.isEmpty() ? "Không có" : listCE.substring(0, listCE.length() - 2) %></p>
			</div>
		</div>
		<form action="doAddAmountIncured.jsp" method="post">
			<input type="text" name="txtIdRCD" value=<%=rcd.getId() %> hidden=""/>
			<input type="text" required name="txtTotalIncured" <%if(rcd.getTotalAmountIncured() > 0){ %> value=<%=rcd.getTotalAmountIncured() %>  <%} %> placeholder="Nhập tổng chi phí phát sinh"/><br/>
			<input type="submit" value="Xác nhận" />
		</form>
		<div class="action-back"><button onclick="openPage('AddPaymentInvoiceInfo.jsp')">Quay lại</button></div>
	</div>
	<script type="text/javascript">
	 function openPage(pageURL){
	    window.location.href = pageURL;
	 }
	</script>
</body>
</html>