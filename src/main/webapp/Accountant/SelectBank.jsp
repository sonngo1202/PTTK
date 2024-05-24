<%@page import="Model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Select Bank</title>
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

        form {
        	text-align: left;
        }
        
        label{
        	display: block;
        	color: #555;
            font-weight: bold;
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
            width: 15%;
        }
    </style>
</head>
<%
Member member = (Member) session.getAttribute("member");
if(member == null){
	response.sendRedirect(request.getContextPath()+ "/Login.jsp?err=timeout");
}
%>
<body>
	<div class="contener">
	    <h2>Chọn ngân hàng thanh toán</h2>
		<form action="Transfer.jsp" method="post">
			<label>Tên ngân hàng</label>
			<input type="text" required name="txtBankName"/>
			<label>Số tài khoản</label>
			<input type="text" required name="txtBankNumber"/>
			<div class="action-submit"><input type="submit" value="Xác nhận" /></div>
		</form>
		<div class="action-back"><button onclick="openPage('Transfer.jsp')">Quay lại</button></div>
	</div>
	<script type="text/javascript">
	 function openPage(pageURL){
	    window.location.href = pageURL;
	 }
	</script>
</body>
</html>