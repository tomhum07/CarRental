<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="CarRental.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link href="~/Content/LoginPageStyle.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>   
    <%-- Thêm Font Awesome để sử dụng icon mắt --%>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="form-box login">
                <h1>Login</h1>
                <div class="input-box">
                    <asp:TextBox ID="txtUsername" runat="server" Placeholder="Username"></asp:TextBox>
                </div>

                <div class="input-box">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Password"></asp:TextBox>
                    <i class="fa-solid fa-eye toggle-icon" onclick="togglePassword()"></i>
                    <%-- mã định danh để gọi hình "con mắt" --%>
                </div>

                <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
                
                <asp:Button ID="btnLogin" runat="server" Text="LOGIN" OnClick="btnLogin_Click"/>
                
                Already have an account? <asp:LinkButton ID="lbtnSignUp" runat="server" OnClick="lbtnSignUp_Click">SignUp</asp:LinkButton>
            </div>
        </div>
    </form>

    <script>
        function togglePassword() {
            // Trong ASP.NET WebForms, phải dùng ClientID để lấy ID thật của input
            var passwordInput = document.getElementById('<%= txtPassword.ClientID %>');
            var icon = document.querySelector('.toggle-icon');

            if (passwordInput.type === "password") {
                passwordInput.type = "text"; // Hiện mật khẩu
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash'); // Đổi icon thành mắt gạch chéo
            } else {
                passwordInput.type = "password"; // Ẩn mật khẩu
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye'); // Đổi lại icon mắt thường
            }
        }
    </script>
</body>
</html>