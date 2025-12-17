<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerDashboard.aspx.cs" Inherits="CarRental.CustomerDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Cho thuê xe - Customer Dashboard</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background: #f5f5f5;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Header */
        .header {
            background: #333;
            color: white;
            padding: 0 20px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.2);
        }

        .header-content {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 70px;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            color: white;
        }

        .logo i {
            margin-right: 10px;
        }

        .nav-menu {
            display: flex;
            gap: 30px;
        }

        .nav-menu a {
            color: #d1d5db;
            text-decoration: none;
            font-size: 16px;
            transition: color 0.3s;
        }

        .nav-menu a:hover {
            color: white;
        }

        .user-section {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .welcome-text {
            color: #d1d5db;
        }

        .btn-logout {
            background: #ef4444;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.3s;
        }

        .btn-logout:hover {
            background: #dc2626;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            max-width: 1400px;
            margin: 0 auto;
            padding: 30px 20px;
            width: 100%;
        }

        .page-title {
            font-size: 32px;
            color: #333;
            margin-bottom: 10px;
        }

        .page-subtitle {
            color: #666;
            margin-bottom: 30px;
            font-size: 16px;
        }

        /* Vehicle Grid - FIXED: Display 3 items per row */
        #DataList1 {
            width: 100%;
            margin-bottom: 30px;
            border-collapse: separate;
            border-spacing: 25px 25px;
        }
        
        #DataList1 td {
            vertical-align: top;
            width: 33.33%;
        }

        .vehicle-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .vehicle-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

        .vehicle-image-wrapper {
            width: 100%;
            height: 200px;
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .vehicle-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .vehicle-info {
            padding: 20px;
        }

        .vehicle-name {
            font-size: 20px;
            font-weight: 600;
            color: #333;
            margin-bottom: 12px;
            min-height: 48px;
        }

        .vehicle-details {
            display: flex;
            gap: 15px;
            margin-bottom: 15px;
            color: #666;
            font-size: 14px;
        }

        .vehicle-details span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .vehicle-price {
            font-size: 20px;
            font-weight: bold;
            color: #ef4444;
            margin-bottom: 15px;
        }

        .btn-rent {
            width: 100%;
            background: #333;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: background 0.3s;
        }

        .btn-rent:hover {
            background: #1f1f1f;
        }

        /* Footer Status Bar */
        .footer {
            background: #333;
            color: white;
            padding: 20px;
            margin-top: auto;
        }

        .footer-content {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .footer-info {
            display: flex;
            gap: 40px;
            flex-wrap: wrap;
        }

        .footer-item {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .footer-item i {
            color: #ef4444;
            font-size: 20px;
        }

        .footer-text {
            display: flex;
            flex-direction: column;
        }

        .footer-label {
            font-size: 12px;
            color: #d1d5db;
        }

        .footer-value {
            font-size: 16px;
            font-weight: 600;
        }

        .copyright {
            color: #d1d5db;
            font-size: 14px;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        .empty-state i {
            font-size: 64px;
            color: #ddd;
            margin-bottom: 20px;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .vehicle-card {
                max-width: 100%;
            }
        }

        @media (max-width: 768px) {
            #DataList1 td {
                display: block;
                width: 100%;
            }
            
            .header-content {
                flex-direction: column;
                height: auto;
                padding: 15px 0;
                gap: 15px;
            }

            .nav-menu {
                gap: 15px;
            }

            .footer-content {
                flex-direction: column;
                text-align: center;
            }

            .footer-info {
                flex-direction: column;
                gap: 15px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Header -->
        <header class="header">
            <div class="header-content">
                <div class="logo">
                    <i class="fas fa-car"></i>
                    Cho thuê xe 3 con cá
                </div>

                <nav class="nav-menu">
                    <a href="CustomerDashboard.aspx">Trang chủ</a>
                    <a href="#xe">Xe</a>
                    <a href="#dat-xe">Đặt xe</a>
                    <a href="#lien-he">Liên hệ</a>
                </nav>

                <div class="user-section">
                    <asp:Label ID="lblUsername" runat="server" CssClass="welcome-text" Text="Xin chào"></asp:Label>
                    <asp:Button ID="btnLogout" runat="server" Text="Đăng xuất" CssClass="btn-logout" OnClick="btnLogout_Click" />
                </div>
            </div>
        </header>

        <!-- Main Content -->
        <div class="main-content">
            <h1 class="page-title">Danh Sách Xe Cho Thuê</h1>
            <p class="page-subtitle">Chọn xe phù hợp với nhu cầu của bạn</p>

            <asp:DataList ID="DataList1" runat="server" RepeatLayout="Table" RepeatColumns="3" RepeatDirection="Horizontal" OnItemCommand="DataList1_ItemCommand" CellPadding="0" CellSpacing="25">
                <ItemTemplate>
                    <div class="vehicle-card">
                        <div class="vehicle-image-wrapper">
                            <asp:Image ID="imgVehicle" runat="server" 
                                ImageUrl='<%# "~/Image/Vehicle/" + Eval("Image") %>' 
                                CssClass="vehicle-image" 
                                AlternateText='<%# Eval("NameVehicle") %>' />
                        </div>
                        <div class="vehicle-info">
                            <div class="vehicle-name">
                                <%# Eval("NameVehicle") %>
                            </div>
                            <div class="vehicle-details">
                                <span>
                                    <i class="fas fa-users"></i>
                                    <%# Eval("SeatingCapacity") %> chỗ
                                </span>
                                <span>
                                    <i class="fas fa-gas-pump"></i>
                                    <%# Eval("FuelType") %>
                                </span>
                            </div>
                            <div class="vehicle-price">
                                <%# Eval("Price", "{0:N0} VNĐ/ngày") %>
                            </div>
                            <asp:Button ID="btnRent" runat="server" 
                                CssClass="btn-rent" 
                                Text="Thuê Xe" 
                                CommandName="Rent" 
                                CommandArgument='<%# Eval("VehicleID") %>' />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>

            <asp:Panel ID="pnlEmpty" runat="server" CssClass="empty-state" Visible="false">
                <i class="fas fa-car-side"></i>
                <h2>Không có xe nào khả dụng</h2>
                <p>Vui lòng quay lại sau</p>
            </asp:Panel>
        </div>

        <!-- Footer Status Bar -->
        <footer class="footer">
            <div class="footer-content">
                <div class="footer-info">
                    <div class="footer-item">
                        <i class="fas fa-car"></i>
                        <div class="footer-text">
                            <span class="footer-label">Tổng số xe</span>
                            <span class="footer-value">
                                <asp:Label ID="lblTotalVehicles" runat="server" Text="0"></asp:Label>
                            </span>
                        </div>
                    </div>
                    <div class="footer-item">
                        <i class="fas fa-check-circle"></i>
                        <div class="footer-text">
                            <span class="footer-label">Xe khả dụng</span>
                            <span class="footer-value">
                                <asp:Label ID="lblAvailableVehicles" runat="server" Text="0"></asp:Label>
                            </span>
                        </div>
                    </div>
                    <div class="footer-item">
                        <i class="fas fa-phone"></i>
                        <div class="footer-text">
                            <span class="footer-label">Hotline</span>
                            <span class="footer-value">1900 xxxx</span>
                        </div>
                    </div>
                </div>
                <div class="copyright">
                    © 2024 Cho thuê xe 3 con cá. All rights reserved.
                </div>
            </div>
        </footer>
    </form>
</body>
</html>