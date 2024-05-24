<%@page import="Model.DetailContract"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.CarDAO"%>
<%@page import="Model.Car"%>
<%@page import="Model.Member"%>
<%@page import="javax.print.attribute.standard.MediaSize.NA"%>
<%@page import="Model.Manager"%>
<%@page import="Model.Contract"%>
<%@page import="Model.Partner"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Select Car</title>
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
        
        .action-button{
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
session.setAttribute("checkEdit", "false");
Contract contract = null;
List<Car> listCar = null;
String idPartner = request.getParameter("id");
if(idPartner == null){
	contract = (Contract) session.getAttribute("contract");
	
}else{
	List<Partner> listPartner = (List<Partner>)session.getAttribute("listPartner");
	contract = new Contract();
	for(Partner partner : listPartner){
		if(partner.getId()==Integer.parseInt(idPartner.trim())){
			contract.setPartner(partner);
			break;
		}
	}
	Manager manager = new Manager();
	manager.setId(member.getId());
	manager.setFullname(member.getFullname());
	manager.setAddress(member.getAddress());
	manager.setPhoneNumber(member.getPhoneNumber());
	manager.setEmail(member.getEmail());
	manager.setDes(member.getDes());
	contract.setManager(manager);
	session.setAttribute("contract", contract);
}
String key = request.getParameter("keyword");
if(key != null && key.trim()!=""){
	CarDAO carDAO = new CarDAO();
	listCar = carDAO.searchCarofPartner(contract.getPartner().getId(), key);
	session.setAttribute("listCar", listCar);
}
List<Integer> listIdCar = new ArrayList<>();
if(contract.getListDetailContract()!=null && !contract.getListDetailContract().isEmpty()){
	for(DetailContract dc : contract.getListDetailContract()){
		listIdCar.add(dc.getCar().getId());
	}
}
%>
<body>
	<div class="contener">
        <h2>Chọn xe để kí hợp đồng</h2>
        <div class="content-item">
            <form action="SelectCar.jsp" method="get">
                <input type="text" name="keyword" required placeholder="Nhập tên hoặc biển số xe để tìm"/>
                <input type="submit" value="Tìm kiếm"/>
                <a href="AddCar.jsp">Thêm xe mới</a>
            </form>
        </div>
        <table>
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Biển số</th>
                    <th>Tên xe</th>
                    <th>Màu sắc</th>
                    <th>Năm sản xuất</th>
                    <th>Mô tả</th>
                    <th>Chọn</th>
                </tr>
            </thead>
            <tbody>
                <%if(listCar!=null && !listCar.isEmpty()){
                	for(int i=0; i < listCar.size(); i++){%>
                	<tr>
                		<td><%= i+1 %></td>
                		<td><%= listCar.get(i).getLicensePlate() %></td>
                		<td><%= listCar.get(i).getName() %></td>
                		<td><%= listCar.get(i).getColor() %></td>
                		<td><%= listCar.get(i).getYear() %></td>
                		<td><%= listCar.get(i).getDes() %></td>
                		<td>
                			<a href="EnterCarRentalInfo.jsp?id=<%=listCar.get(i).getId()%>" 
                			<%if(listIdCar.contains(listCar.get(i).getId())){%> style="display:none" <%}%>>Chọn</a>
                		</td>
                	<tr/>
                <% }}%>
            </tbody>
        </table>
        <div class="action-button">
            <button onclick="openPage('SelectPartner.jsp')" style="background-color: black">Quay lại</button><br/>
        	<button onclick="confirmCancel('SignContract.jsp')">Hủy</button>
        </div>
    </div>
    <script type="text/javascript">
		 function openPage(pageURL){
		    window.location.href = pageURL;
		 }
		 function confirmCancel(pageURL){
		    if(confirm("Bạn có chắc muốn hủy quá trình kí hợp đồng ?")){
		    	window.location.href = pageURL;
		    }
		 }
	</script>
</body>
</html>