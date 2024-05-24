<%@page import="Model.DetailContract"%>
<%@page import="Model.CarError"%>
<%@page import="Model.Contract"%>
<%@page import="Model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Contract Info</title>
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
        
        .action-addCar{
        	text-align: left;
        	margin-bottom: 30px;
        }
        
        a {
            padding: 15px 15px;
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
        
        tbody>tr>td a{
        	padding: 6px 8px;
            background-color: #28a745;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
        }
        
        form {
            align-items: center;
        }
        
        .rules-input{
        	width: 98%;
        	margin-bottom: 20px;
        }
        
        textarea {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            width: 100%;
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
            width: 12%;
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
            width: 12%;
        }
    </style>
</head>
<%
Member member = (Member) session.getAttribute("member");
if(member == null){
	response.sendRedirect(request.getContextPath()+ "/Login.jsp?err=timeout");
}
Contract contract = (Contract) session.getAttribute("contract");
String idDC = request.getParameter("idDC");
if(idDC != null){
	for(DetailContract dc: contract.getListDetailContract()){
		if(dc.getId()==Integer.parseInt(idDC.trim())){
			contract.getListDetailContract().remove(dc);
			break;
		}
	}
}
%>
<body>
	<div class="contener">
		<h2>Thêm thông tin hợp đồng</h2>
		<div class="action-addCar"><a href="SelectCar.jsp">Thêm xe vào hợp đồng</a></div>
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
                    <th>Chọn</th>
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
		                    <td><a href="#" onclick="confirmDelete('<%=contract.getListDetailContract().get(i).getId()%>');">Xóa</a></td>
		                </tr>
                <%} }%>
            </tbody>
        </table>
        <form action="doAddContractInfo.jsp" method="post">
        	<div class="rules-input"><textarea rows="4" cols="5" name="txtRules" placeholder="Nhập nội dung điều khoản" required></textarea></div>
        	<div class="action-submit"><input type="submit" value="Lưu hợp đồng"> </div>
        </form>
        <div class="action-cancel">
        	<button onclick="confirmCancel('SignContract.jsp')">Hủy</button>
        </div>
	</div>
	<script type="text/javascript">
		 function openPage(pageURL){
		    window.location.href = pageURL;
		 }
		 function confirmDelete(id) {
		    if (confirm("Bạn có chắc chắn muốn xóa?")) {
		        window.location.href = "AddContractInfo.jsp?idDC=" + id;
		    }
		}
		 function confirmCancel(pageURL){
		    if(confirm("Bạn có chắc muốn hủy quá trình kí hợp đồng ?")){
		    	window.location.href = pageURL;
		    }
		 }
	</script>
</body>
</html>