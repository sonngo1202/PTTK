<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 75vh;
        }

        .login-container {
            text-align: center;
            width: 600px; /* Đặt chiều rộng của container */
            margin: auto; /* Để căn giữa container */
        }

        h2 {
            color: #333;
            font-size: 40px;
        }

        form {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .login-info {
            margin-left: 10px;
            margin-bottom: 30px;
            text-align: left;
        }

        label {
            display: block;
            color: #555;
            font-weight: bold;
        }

        input {
            width: calc(100% - 16px);
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        
        p{
        	color: red;
        	margin-bottom: 25px;
        }
        
        .action-login{
            margin-right: 5px;
        }

        input[type="submit"] {
            background-color: #4caf50;
            color: #fff;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<%
String err = request.getParameter("err");

%>>
<body>
    <div class="login-container">
        <h2>Đăng nhập</h2>
        <form action="doLogin.jsp" method="post">
            <div class="login-info">
                <label for="username">Tên đăng nhập:</label> <br />
                <input type="text" name="txtUsername" id="username" required />
            </div>
            <div class="login-info">
                <label for="password">Mật khẩu:</label><br />
                <input type="password" name="txtPassword" id="password" required />
            </div>
            <p <%if(err == null || !err.equalsIgnoreCase("fail")) {%> hidden=""<%}%>>Sai tên đăng nhập hoặc mật khẩu!</p>
            <p<%if(err == null || !err.equalsIgnoreCase("timeout")) {%> hidden=""<%}%>>Đã hết phiên làm việc. Vui lòng đăng nhập lại!</p>
            <div class="action-login">
                <input type="submit" value="Đăng nhập" />
            </div>
        </form>
    </div>
</body>
</html>
