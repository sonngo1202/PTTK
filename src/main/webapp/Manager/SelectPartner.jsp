<%@page import="Model.Member"%>
<%@page import="Model.Partner"%>
<%@page import="DAO.PartnerDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Select Partner</title>
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
        
        .content-item {
            display: flex;
            justify-content: space-between;
            align-items: center; /* Căn giữa theo chiều dọc */
            width: 100%;
            margin-bottom: 10px;
        }

        form {
            display: flex;
            align-items: center;
            width: 60%;
        }

        input[type="text"] {
            flex: 1;
            padding: 10px;
            margin-right: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
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
        
        .action-cancel{
            text-align: right;
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
            width: 10%;
        }
    </style>
</head>
<%
Member member = (Member) session.getAttribute("member");
if(member == null){
	response.sendRedirect(request.getContextPath()+ "/Login.jsp?err=timeout");
}
List<Partner> listPartner = null;
String key = request.getParameter("keyword");
if(key != null && key.trim() != ""){
	PartnerDAO partnerDAO = new PartnerDAO();
	listPartner = partnerDAO.searchPartner(key);
	session.setAttribute("listPartner", listPartner);
}
%>
<body>
	<div class="contener">
        <h2>Chọn đối tác để kí hợp đồng</h2>
        <div class="content-item">
            <form action="SelectPartner.jsp" method="get">
                <input type="text" name="keyword" required placeholder="Nhập tên đối tác để tìm"/>
                <input type="submit" value="Tìm kiếm"/>
                <a href="AddPartner.jsp">Thêm đối tác mới</a>
            </form>
        </div>
        <table>
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Số CCCD</th>
                    <th>Họ tên</th>
                    <th>Ngày sinh</th>
                    <th>Địa chỉ</th>
                    <th>Số điện thoại</th>
                    <th>Email</th>
                    <th>Ngân hàng</th>
                    <th>Số tài khoản</th>
                    <th>Chọn</th>
                </tr>
            </thead>
            <tbody>
            	<%if(listPartner!=null && !listPartner.isEmpty()){
                	for(int i = 0; i < listPartner.size(); i++){ %>
                	<tr>
	                    <td><%=i+1 %></td>
	                    <td><%=listPartner.get(i).getCccd() %></td>
	                    <td><%=listPartner.get(i).getFullname() %></td>
	                    <td><%=listPartner.get(i).getDob() %></td>
	                    <td><%=listPartner.get(i).getAddress() %></td>
	                    <td><%=listPartner.get(i).getPhoneNumber() %></td>
	                    <td><%=listPartner.get(i).getEmail() %></td>
	                    <td><%=listPartner.get(i).getBankName() %></td>
	                    <td><%=listPartner.get(i).getBankNumber() %></td>
	                    <td>
	                        <a href="SelectCar.jsp?id=<%= listPartner.get(i).getId()%>">Chọn</a>
	                    </td>
	                </tr>
                <%}} %>
            </tbody>
        </table>
        <div class="action-cancel"><button onclick="confirmCancel('SignContract.jsp')">Hủy</button></div>
    </div>
    <script type="text/javascript">
		 function confirmCancel(pageURL){
		    if(confirm("Bạn có chắc muốn hủy quá trình kí hợp đồng ?")){
		    	window.location.href = pageURL;
		    }
		 }
	</script>
</body>
</html>