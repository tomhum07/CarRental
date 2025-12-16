<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerDashboard.aspx.cs" Inherits="CarRental.CustomerDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <style>
        body {
            margin: 0;
            padding: 0;
        }
        .image-btn {
            width: 100%;
            height: 150px;
            object-fit: contain;
            cursor: pointer;
            border: none;
            background: white;
            padding: 10px;
            margin-bottom: 10px;
        }

        .vehicle-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            padding: 20px;
            align-items: center;
            justify-content: center;
        }

        .vehicle-item {
            width: 280px;
            background: white;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 15px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: transform 0.2s, box-shadow 0.2s;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .vehicle-item img {
            width: 100%;
            height: 200px;
            object-fit: contain;
            margin-bottom: 10px;
        }

        .vehicle-name {
            font-size: 20px;
            color: #333;
            margin: -10px 0 -10px;
            min-height: 40px;
        }

        .vehicle-seating {
            margin: 0 0 10px

        }

        .vehicle-price {
            font-size: 16px;
            color: #ef4444;
            font-weight: bold;
        }

        /* Header */
        .site-header {
            background-color: #333;
            height: 70px;
            display: flex;
            align-items: center;
            box-shadow: 0 2px 6px rgba(0,0,0,0.2);
        }

        .header-container {
            width: 90%;
            margin: auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* Logo */
        .logo a {
            font-size: 24px;
            font-weight: bold;
            color: #ffffff;
            text-decoration: none;
        }

        /* Menu */
        .nav-menu a {
            margin: 0 15px;
            color: #d1d5db;
            text-decoration: none;
            font-size: 16px;
        }

        .nav-menu a:hover {
            color: #ffffff;
        }

        /* Account */
        .account {
            display: flex;
            align-items: center;
            gap: 12px;
            color: #ffffff;
        }

        .btn-logout {
            background-color: #ef4444;
            border: none;
            padding: 6px 12px;
            color: white;
            cursor: pointer;
            border-radius: 4px;
        }

        .btn-logout:hover {
            background-color: #dc2626;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header class="site-header">
            <div class="header-container">
                <!-- Logo -->
                <div class="logo">
                    <a href="Home.aspx">Cho thuê xe 3 con cá</a>
                </div>

                <!-- Menu -->
                <nav class="nav-menu">
                    <a href="Home.aspx">Trang chủ</a>
                    <a href="Cars.aspx">Xe</a>
                    <a href="Booking.aspx">Đặt xe</a>
                    <a href="Contact.aspx">Liên hệ</a>
                </nav>

                <!-- Account -->
                <div class="account">
                    <asp:Label ID="lblUsername" runat="server" Text="Xin chào"></asp:Label>
                    <asp:Button ID="btnLogout" runat="server" Text="Đăng xuất" CssClass="btn-logout" />
                </div>
            </div>
        </header>
        <h1>Customer Dashboard</h1>
        <div class="vehicle-container">
            <asp:DataList ID="DataList1" runat="server" RepeatColumns="4"><ItemTemplate>
                    <div class="vehicle-item">
                        <asp:ImageButton ID="ImageButton1" CssClass="image-btn" runat="server" 
                            ImageUrl='<%# "~/Image/Vehicle/" + Eval("Image") %>' />
                        <div class="vehicle-name">
                            <asp:HyperLink ID="HyperLink1" runat="server" 
                                Text='<%# Eval("NameVehicle") %>'></asp:HyperLink>
                        </div>
                        <div class="vehicle-seating">
                            <asp:Label ID="lblSoCho" runat="server" Text='<%# "Số chỗ ngồi: " + Eval("SeatingCapacity") %>'></asp:Label>
                        </div>
                        <div class="vehicle-price">
                            <asp:Label ID="lblGia" runat="server" DataFormatString="{0:0,000}"
                                Text='<%#  Eval("Price", "{0:N0} VNĐ/ngày")  %>'></asp:Label>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>
        </div>
    </form>
</body>
</html>
