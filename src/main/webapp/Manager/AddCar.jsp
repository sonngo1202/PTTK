<%@page import="Model.Contract"%>
<%@page import="Model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Car</title>
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

        .container {
            text-align: center;
            max-width: 800px;
            width: 100%;
        }

        h2 {
            color: #343a40;
            font-size: 40px;
        }
        
        .partner-info{
             text-align: left;
             margin-bottom: 50px;
        }
        
        p{
            font-size: 18px;
            font-weight: bold;
        }

        form {
            flex-direction: column;
            align-items: center;
            width: 100%;
        }

        .form-group {
            display: flex;
            margin-bottom: 10px;
        }

        .form-input {
            flex: 1;
            text-align: left;
            margin-right: 10px;
        }

        label {
            color: #555;
            font-weight: bold;
        }

        input {
            padding: 10px;
            border: 1px solid #007bff;
            border-radius: 4px;
            font-size: 14px;
            width: 100%;
            box-sizing: border-box;
        }

        .form-submit {
            margin-top: 20px;
            text-align: right;
            margin-right: 10px;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
            padding: 10px;
            border: none;
            border-radius: 4px;
            width: 20%;
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
            width: 20%;
        }
    </style>
</head>
<%
Member member = (Member) session.getAttribute("member");
if(member == null){
	response.sendRedirect(request.getContextPath()+ "/Login.jsp?err=timeout");
}
Contract contract = (Contract)session.getAttribute("contract");
%>
<body>
	<div class="container">
        <h2>Thêm xe mới</h2>
        <div class="partner-info">
            <p>Số CCCCD: <%=contract!=null?contract.getPartner().getCccd():"" %></p>
            <p>Tên đối tác: <%=contract!=null?contract.getPartner().getFullname():""  %></p>
        </div>
        <form action="doAddCar.jsp" method="post">
            <div class="form-group">
                <div class="form-input">
                    <label>Biển số:</label> <input type="text" name="txtLicensePlate" required/>
                </div>

                <div class="form-input">
                    <label>Tên xe:</label> <input type="text" name="txtName" required />
                </div>
            </div>

            <div class="form-group">
                <div class="form-input">
                    <label>Màu sắc:</label> <input type="text" name="txtColor" required />
                </div>

                <div class="form-input">
                    <label>Năm sản xuất:</label> <input type="number" name="txtYear" required />
                </div>
            </div>

            <div class="form-group">
                <div class="form-input">
                    <label>Mô tả:</label> <input type="text" name="txtDes" />
                </div>
                <div class="form-input">
                    
                </div>
            </div>
            <div class="form-submit">
                <input type="submit" value="Lưu" />
            </div>
        </form>
        <div class="action-back"><button onclick="history.back()">Quay lại</button></div>
    </div>
</body>
</html>