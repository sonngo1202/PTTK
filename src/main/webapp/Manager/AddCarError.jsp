<%@page import="DAO.ErrorDAO"%>
<%@page import="Model.Error"%>
<%@page import="java.util.List"%>
<%@page import="Model.Car"%>
<%@page import="Model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Car Error</title>
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
            width: 600px;
        }
        
        h2 {
            color: #343a40;
            font-size: 40px;
            margin-bottom: 80px;
        }
        
        .car-info{
             text-align: left;
             margin-bottom: 50px;
        }
        
        p{
            font-size: 18px;
            font-weight: bold;
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
        	margin-top: 30px;
        	text-align: left;
        }
        

        input[type="text"] {
            padding: 10px;
            margin-right: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            width: 77%;
        }
        
        select{
        	margin-right: 5px;
        	padding: 10px;
        	border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            width: 81%;
        }
        

        input[type="submit"] {
            flex:1;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 18%;
        }
        
        .action-back{
            text-align: right;
            margin-top: 15px;
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
            width: 18%;
        }
    </style>
</head>
<%
Member member = (Member) session.getAttribute("member");
if(member == null){
	response.sendRedirect(request.getContextPath()+ "/Login.jsp?err=timeout");
}
Car car = (Car) session.getAttribute("car");
List<Error> listError = (List<Error>) session.getAttribute("listError");
if(listError == null){
	ErrorDAO errorDAO = new ErrorDAO();
	listError = errorDAO.getAllError();
	session.setAttribute("listError", listError);
}
request.setCharacterEncoding("UTF-8");
String txtError = request.getParameter("txtError");
if(txtError !=null && txtError.trim()!= ""){
	Error error = new Error();
	error.setName(txtError);
	ErrorDAO errorDAO = new ErrorDAO();
	boolean kq = errorDAO.saveError(error);
	if(kq){
		listError.add(error);
		session.setAttribute("listError", listError);
		%>
		<script>
			alert("Lưu thành công lỗi mới");
			window.location.href = "AddCarError.jsp"
		</script>
	<%}else{%>
		<script type="text/javascript">
			alert("Lưu thất bại")
		    history.back()
		</script>
<%}}
%>
<body>
	<div class="contener">
		<h2>Thêm lỗi xe</h2>
		<div class="car-info">
			<p>Biển số: <%=car != null? car.getLicensePlate():"" %></p>
			<p>Tên xe: <%=car != null? car.getName():"" %></p>
			<p>Màu sắc: <%=car != null? car.getColor():"" %></p>
			<p>Năm sản xuất: <%=car != null? car.getYear():"" %></p>
		</div>
		<form action="AddCarError.jsp" method="post">
			<input type="text" name="txtError" placeholder="Nhập tên lỗi nếu lỗi chưa tồn tại" required />
			<input type="submit" value="Lưu lỗi mới"/>
		</form>
		<form action="doAddCarError.jsp" method="post">
			<select name="idError">
				<option value="-1" selected>Chọn lỗi</option>
				<% for(Error e: listError){%>
                    <option value="<%=e.getId()%>"><%=e.getName() %></option>
                <%}
                %>
			</select>
			<input type="submit" value="Lưu" />
		</form>
		<div class="action-back"><button onclick="openPage('EnterCarRentalInfo.jsp')">Quay lại</button></div>
	</div>
	<script type="text/javascript">
	 function openPage(pageURL){
	    window.location.href = pageURL;
	 }
	</script>
</body>
</html>