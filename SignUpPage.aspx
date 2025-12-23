<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUpPage.aspx.cs" Inherits="CarRental.SignUp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SignUp</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, sans-serif;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(135deg, rgba(31, 41, 55, 0.7)), url('https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=1920&q=80') center/cover;
            background-attachment: fixed;
            position: relative;
        }

        .container {
            position: relative;
            width: 480px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            margin: 20px;
            box-shadow: 0 25px 70px rgba(0, 0, 0, 0.4);
            overflow: visible;
            z-index: 1;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

            .container h1 {
                font-size: 35px;
                font-weight: 700;
                color: #1f2937;
                margin-bottom: 8px;
            }

                .container h1::after {
                    content: '';
                    display: block;
                    width: 100px;
                    height: 3px;
                    background: #ef4444;
                    margin: 15px auto 0;
                    border-radius: 2px;
                }

        .form-box {
            width: 100%;
            text-align: center;
            padding: 20px 45px;
            background: transparent;
        }

        /* Input styling */
        .input-box {
            position: relative;
            margin: 22px 0;
            text-align: left;
        }

            .input-box label {
                display: block;
                font-size: 13px;
                font-weight: 600;
                color: #4b5563;
                margin-bottom: 8px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .input-box input {
                width: 100%;
                padding: 15px 50px 15px 18px;
                background: #ffffff;
                border-radius: 10px;
                border: 2px solid #e5e7eb;
                outline: none;
                font-size: 15px;
                color: #1f2937;
                font-weight: 500;
                transition: all 0.3s ease;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.04);
            }

                .input-box input:focus {
                    border-color: #ef4444;
                    box-shadow: 0 0 0 4px rgba(239, 68, 68, 0.1), 0 4px 8px rgba(0, 0, 0, 0.08);
                    transform: translateY(-1px);
                }

                .input-box input::placeholder {
                    color: #9ca3af;
                    font-weight: 400;
                }

        #btnLogin {
            width: 100%;
            height: 54px;
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(239, 68, 68, 0.35);
            border: none;
            cursor: pointer;
            color: #fff;
            font-weight: 700;
            font-size: 16px;
            letter-spacing: 1px;
            text-transform: uppercase;
            margin: 30px 0 20px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

            #btnLogin::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
                transition: left 0.5s;
            }

            #btnLogin:hover::before {
                left: 100%;
            }

            #btnLogin:hover {
                background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
                transform: translateY(-3px);
                box-shadow: 0 12px 28px rgba(239, 68, 68, 0.45);
            }

            #btnLogin:active {
                transform: translateY(-1px);

            }

        #lblMessage {
            color: #ef4444;
            font-size: 15px;
            display: block;
            font-weight: 600;
        }

        /* Link Login */

        #lbtnLogin {
            color: #ef4444;
            text-decoration: none;
            font-weight: 700;
            margin-left: 5px;
            transition: all 0.2s;
            position: relative;
        }

        /* Toggle password icon */
        .toggle-icon {
            position: absolute;
            right: 18px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #9ca3af;
            font-size: 18px;
            z-index: 10;
            transition: all 0.2s;
        }

        /* Responsive */
        @media (max-width: 560px) {
            .container {
                width: 95%;
                margin: 70px 20px 20px;
            }

            .form-box {
                padding: 20px 30px 35px;
            }

            .container h1 {
                font-size: 24px;
                margin-top: 50px;
            }

            .input-box {
                margin: 18px 0;
            }

            body::before,
            body::after {
                display: none;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="form-box signup">
                <h1>Đăng ký</h1>

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

                <asp:Button ID="btnLogin" runat="server" Text="ĐĂNG KÝ" OnClick="btnLogin_Click" />

                Đã có tài khoản?<asp:LinkButton ID="lbtnLogin" runat="server" OnClick="lbtnLogin_Click">Đăng nhập</asp:LinkButton>
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
