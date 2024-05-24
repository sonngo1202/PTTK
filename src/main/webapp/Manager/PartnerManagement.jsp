<%@page import="Model.Member"%>
<%@page import="DAO.PartnerDAO"%>
<%@page import="Model.Partner"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Partner Management</title>
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
        td button{
        	margin: 10px 0;
            padding: 10px 15px;
        	background-color: #28a745;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            font-size: 16px;
            border: none;
        }
        .action-back{
            text-align: right;
        }

        .action-back button {
            padding: 10px 15px;
            background-color: black;
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
session.removeAttribute("partner");
String action = request.getParameter("action");
if(action!=null && action.equals("xoa")){
    String idPartner = request.getParameter("id");
    listPartner = (List<Partner>) session.getAttribute("listPartner");
    if(listPartner != null && !listPartner.isEmpty()){
    	PartnerDAO partnerDAO = new PartnerDAO();
        boolean kq = partnerDAO.deletePartner(Integer.parseInt(idPartner.trim()));
        if(kq){
        	for(Partner p: listPartner){
        		if(p.getId()==Integer.parseInt(idPartner.trim())){
        			listPartner.remove(p);
        			session.setAttribute("listPartner", listPartner);
        			break;
        		}
        	}
        }else{%>
            <script type="text/javascript">
            	alert("Xóa thất bại");
            </script>
<%}}}else{
	String key = request.getParameter("keyword");
	if(key!=null && !key.trim().isEmpty()){
		PartnerDAO partnerDAO = new PartnerDAO();
		listPartner = partnerDAO.searchPartner(key);
		session.setAttribute("listPartner", listPartner);
	}
}

%>
<body>
    <div class="contener">
        <h2>Quản lí đối tác cho thuê lại xe</h2>
        <div class="content-item">
            <form action="PartnerManagement.jsp" method="get">
                <input type="text" name="keyword" required placeholder="Nhập tên hoặc căn cước công dân đối tác để tìm"/>
                <input type="submit" value="Tìm kiếm"/>
                <a href="EditPartnerInfo.jsp?action=them">Thêm đối tác mới</a>
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
	                        <a href="EditPartnerInfo.jsp?action=xem&&id=<%=listPartner.get(i).getId() %>">Xem</a>
	                        <a href="EditPartnerInfo.jsp?action=sua&&id=<%=listPartner.get(i).getId() %>">Sửa</a>
	                        <button onclick="confirmDelete(<%=listPartner.get(i).getId() %>)">Xóa</button>
	                    </td>
	                </tr>
                <%}} %>
            </tbody>
        </table>
        <div class="action-back"><button onclick="openPage('ManagerHome.jsp')">Quay lại</button></div>
    </div>
    <script type="text/javascript">
		 function openPage(pageURL){
		    window.location.href = pageURL;
		 }
		 function confirmDelete(id) {
			if(window.confirm("Bạn có chắc muốn xóa đối tác này")){
				window.location.href = 'PartnerManagement.jsp?action=xoa&&id='+id;
			}
		}
	</script>
</body>
</html>
