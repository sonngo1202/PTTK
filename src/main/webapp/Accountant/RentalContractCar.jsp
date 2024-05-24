<%@page import="Model.CarError"%>
<%@page import="Model.Car"%>
<%@page import="Model.RentalContract"%>
<%@page import="java.util.List"%>
<%@page import="Model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Rental Contract Car</title>
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

        p {
            padding: 10px;
            border: 1px solid #007bff;
            border-radius: 4px;
            font-size: 14px;
            width: 100%;
            box-sizing: border-box;
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
RentalContract rc = null;
List<RentalContract> listRentalContract = (List<RentalContract>)session.getAttribute("listRentalContract");
String listCE = "";
String id = request.getParameter("id");
if(id != null){
	for(RentalContract rentalContract : listRentalContract){
		if(rentalContract.getId()==Integer.parseInt(id.trim())){
			rc = rentalContract;
			break;
		}
	}
	for(CarError ce : rc.getListRentalContractDetail().get(0).getCar().getListCarError()){
		if(ce.getType()==1&&
				(ce.getDateError().before(rc.getListRentalContractDetail().get(0).getRealReturnDate())&&
				ce.getDateError().after(rc.getListRentalContractDetail().get(0).getBorrowedDate()))||
				ce.getDateError().equals(rc.getListRentalContractDetail().get(0).getRealReturnDate())||
				ce.getDateError().equals(rc.getListRentalContractDetail().get(0).getBorrowedDate())){
			listCE += ce.getError().getName()+", ";
		}
	}
}

%>
<body>
	<div class="contener">
		<h2>Thông tin hợp đồng cho thuê xe</h2>
		<div class="form-group">
             <div class="form-input">
                 <label>Mã hợp đồng</label><p><%=rc.getId() %></p>
             </div>

             <div class="form-input">
                 <label>Tên khách thuê</label><p><%=rc.getCustomer().getFullname() %></p>
             </div>
         </div>

         <div class="form-group">
             <div class="form-input">
                 <label>Số điện thoại khách thuê</label><p><%=rc.getCustomer().getPhoneNumber() %></p>
             </div>

             <div class="form-input">
                 <label>Tên xe</label> <p><%=rc.getListRentalContractDetail().get(0).getCar().getName() %></p>
             </div>
         </div>

         <div class="form-group">
             <div class="form-input">
                 <label>Biển số</label> <p><%=rc.getListRentalContractDetail().get(0).getCar().getLicensePlate() %></p>
             </div>

             <div class="form-input">
                 <label>Giá thuê</label><p><%=formatCurrency(rc.getListRentalContractDetail().get(0).getPrice()) %>/ngày</p>
             </div>
         </div>

         <div class="form-group">
             <div class="form-input">
                 <label>Thời gian bắt đầu thuê</label> <p><%=rc.getListRentalContractDetail().get(0).getBorrowedDate() %></p>
             </div>

             <div class="form-input">
                 <label>Thời gian trả đúng hạn</label> <p><%=rc.getListRentalContractDetail().get(0).getReturnDate() %></p>
             </div>
         </div>

         <div class="form-group">
             <div class="form-input">
                 <label>Thời gian trả thực tế</label> <p><%=rc.getListRentalContractDetail().get(0).getRealReturnDate() %></p>
             </div>

             <div class="form-input">
                 <label>Tình trạng khi trả</label><p><%=listCE.isEmpty()?"Không có": listCE %></p>
             </div>
         </div>
         
         <div class="form-group">
             <div class="form-input">
                 <label>Tiền phạt do hỏng</label> <p><%=formatCurrency(rc.getListRentalContractDetail().get(0).getTotalDamgeAmount()) %></p>
             </div>

             <div class="form-input">
                 <label>Tiền phạt do muộn</label> <p><%=formatCurrency(rc.getListRentalContractDetail().get(0).getTotalFine()) %></p>
             </div>
         </div>
         <div class="form-group">
             <div class="form-input">
                 <label>Tổng tiền thuê xe</label> <p><%=formatCurrency(rc.getListRentalContractDetail().get(0).getTotalRent()) %></p>
             </div>

             <div class="form-input">
                 <label>Tổng tiền thanh toán</label> <p><%=formatCurrency(rc.getListRentalContractDetail().get(0).getTotalPayment()) %></p>
             </div>
         </div>
         <div class="action-back"><button onclick="history.back()">Đóng</button></div>
	</div>
</body>
</html>