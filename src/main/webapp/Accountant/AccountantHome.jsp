<%@page import="Model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accountant Home</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 75vh;
        }

        .container {
            text-align: center;
            max-width: 600px;
            width: 100%;
        }

        h2 {
            color: #343a40;
            font-size: 40px;
        }

        p {
            color: #6c757d;
            font-size: 18px;
            margin-bottom: 20px;
        }

        a {
            display: block;
            text-decoration: none;
            color: #007bff;
            margin: 10px auto;
            padding: 15px;
            width: 80%;
            border: 1px solid #007bff;
            border-radius: 4px;
            font-size: 18px;
            transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
        }

        a:hover {
            background-color: #007bff;
            color: #ffffff;
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
    <div class="container">
        <h2>Trang chủ Kế toán</h2>
        <p>Xin chào, <%=member.getFullname()!=null?member.getFullname():"" %>!</p>
        <a href="PayPartnerMonthly.jsp">Thanh toán cho đối tác hàng tháng</a>
    </div>
</body>
</html>
