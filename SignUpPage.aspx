<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUpPage.aspx.cs" Inherits="CarRental.SignUp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SignUp</title>
    <link href="~/Content/SignUpPageStyle.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>   
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="form-box login">
                <h1>Sign Up</h1>
                
                <div class="input-box">
                    <asp:TextBox ID="txtUsername" runat="server" Placeholder="Username"></asp:TextBox>
                </div>

                <div class="input-box">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Password"></asp:TextBox>
                    <i class="fa-solid fa-eye toggle-icon" onclick="toggleAnyPassword('<%= txtPassword.ClientID %>', this)"></i> 
                </div>

                <div class="input-box">
                    <asp:TextBox ID="txtPasswordRe" runat="server" TextMode="Password" Placeholder="Re-enter password"></asp:TextBox>
                    <i class="fa-solid fa-eye toggle-icon" onclick="toggleAnyPassword('<%= txtPasswordRe.ClientID %>', this)"></i> 
                </div>

                <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>

                <asp:Button ID="btnLogin" runat="server" Text="SIGN UP" OnClick="btnLogin_Click"/>

                Create Account <asp:LinkButton ID="lbtnLogin" runat="server" OnClick="lbtnLogin_Click">Login</asp:LinkButton>
            </div>
        </div>
    </form>

    <script>
        function toggleAnyPassword(inputId, iconElement) {
            // Lấy đúng ô input dựa vào ID được truyền vào
            var passwordInput = document.getElementById(inputId);

            // 'iconElement' chính là cái nút bạn vừa bấm (do truyền 'this' vào)
            // nên không cần dùng document.querySelector nữa -> Không bị nhầm nút

            if (passwordInput.type === "password") {
                passwordInput.type = "text"; // Hiện
                iconElement.classList.remove('fa-eye');
                iconElement.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = "password"; // Ẩn
                iconElement.classList.remove('fa-eye-slash');
                iconElement.classList.add('fa-eye');
            }
        }
    </script>
</body>
</html>