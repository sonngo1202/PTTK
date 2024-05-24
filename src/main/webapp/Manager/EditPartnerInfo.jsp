<%@page import="Model.Member"%>
<%@page import="java.util.List"%>
<%@page import="Model.Partner"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Partner Info</title>
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
String content = "";
String button = "";
Partner partner = null;
String action = request.getParameter("action");
if(action.equals("them")){
	content = "Thêm đối tác mới";
	button = "Lưu";
}else{
	String id = (String) request.getParameter("id");
	if(action.equals("sua")){
		content = "Sửa đối tác";
		button = "Cập nhật";
	}else{
		content = "Thông tin đối tác";
		button = "";
	}
	List<Partner> listPartner = (List<Partner>)session.getAttribute("listPartner");
	if(listPartner!=null && !listPartner.isEmpty() ){
		for(Partner p: listPartner){
			if(p.getId()==Integer.parseInt(id.trim())){
				partner = p;
				session.setAttribute("partner", partner);
				break;
			}
		}
	}
	
}
%>
<body>
    <div class="container">
        <h2><%=content %></h2>
        <form action="doEditPartnerInfo.jsp" method="post" accept-charset="UTF-8">
            <div class="form-group">
                <div class="form-input">
                    <label>Số CCCD:</label> <input type="number" name="txtCccd" value="<%=partner!=null?partner.getCccd():"" %>" required 
                    <% if (partner != null) { %>readonly<% } %> >
                </div>
                <div class="form-input">
                    <label>Họ và tên:</label> <input type="text" name="txtFullname" value="<%=partner!=null?partner.getFullname():""%>" required <% if (button.isEmpty()) { %>readonly<% } %>/>
                </div>
            </div>

            <div class="form-group">
                <div class="form-input">
                    <label>Ngày sinh:</label> <input type="date" name="txtDob" value="<%=partner!=null?partner.getDob():"" %>" required <% if (button.isEmpty()) { %>readonly<% } %>/>
                </div>
                <div class="form-input">
                    <label>Địa chỉ:</label> <input type="text" name="txtAddress" value="<%=partner!=null?partner.getAddress():""%> " required <% if (button.isEmpty()) { %>readonly<% } %>/>
                </div>
            </div>

            <div class="form-group">
                <div class="form-input">
                    <label>Số điện thoại:</label> <input type="number" name="txtPhoneNumber" value="<%=partner!=null?partner.getPhoneNumber():"" %>" required <% if (button.isEmpty()) { %>readonly<% } %>/>
                </div>
                <div class="form-input">
                    <label>Email:</label> <input type="text" name="txtEmail" value="<%=partner!=null?partner.getEmail():"" %>" required <% if (button.isEmpty()) { %>readonly<% } %>/>
                </div>
            </div>

            <div class="form-group">
                <div class="form-input">
                    <label>Ngân hàng:</label> <input type="text" name="txtBankName" value="<%=partner!=null?partner.getBankName():"" %>" required <% if (button.isEmpty()) { %>readonly<% } %>/>
                </div>
                <div class="form-input">
                    <label>Số tài khoản:</label> <input type="text" name="txtBankNumber" value="<%=partner!=null?partner.getBankNumber():"" %>" required <% if (button.isEmpty()) { %>readonly<% } %>/>
                </div>
            </div>
            
            <div class="form-group">
            	<div class="form-input">
                    <label>Mô tả:</label> <input type="text" name="txtDes" value="<%=partner!=null?partner.getDes():"" %>" <% if (button.isEmpty()) { %>readonly<% } %>/>
                </div>
                <div class="form-input">
                    
                </div>
            </div>
            
            <%if(!button.isEmpty()){ %>
	            <div class="form-submit">
	                <input type="submit" value="<%=button %>" />
	            </div>
            <%} %>
        </form>
        <div class="action-back"><button onclick="history.back()">Quay lại</button></div>
    </div>
</body>
</html>
