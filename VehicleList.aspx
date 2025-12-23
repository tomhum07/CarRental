<%@ Page Title="Customer Dashboard" Language="C#" MasterPageFile="~/SiteCustomer.Master" AutoEventWireup="true" CodeBehind="VehicleList.aspx.cs" Inherits="CarRental.VehicleList" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        body {
        }
        /* Main Content */
        .main-content {
            flex: 1;
            max-width: 1400px;
            margin: 10px auto;
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

        /* Vehicle Grid - FIXED: Display 4 items per row */
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

        /* Thêm vào VehicleListStyle.css */
        .btn-rent {
            display: block;
            width: 100%;
            background: #333;
            color: #fff;
            padding: 12px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            text-align: center;
            margin-top: auto;
        }

            .btn-rent:hover {
                transform: translateY(-2px);
                text-decoration: none;
                color: white;
            }

        .filter-section {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
            padding: 15px 10px;
            background: #f9fafb;
            border-radius: 12px;
            align-items: center;
            flex-wrap: wrap;
            border: 1px solid #e5e7eb;
        }

            .filter-section strong {
                color: #4b5563;
                font-size: 15px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

                .filter-section strong i {
                    color: #ef4444;
                }

        .input-filter {
            padding: 5px 10px;
            font-size: 15px;
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            outline: none;
            transition: all 0.3s ease;
            background: #ffffff;
            color: #1f2937;
            font-weight: 500;
            min-width: 100px;
        }
    </style>
</asp:Content>


<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <!-- Main Content -->
    <div class="main-content">
        <h1 class="page-title">Danh Sách Xe Cho Thuê</h1>
        <p class="page-subtitle">Chọn xe phù hợp với nhu cầu của bạn</p>
        <div class="filter-section">
            <i class="fa-solid fa-filter"></i>
            <span>
                <asp:DropDownList ID="ddlSeat" CssClass="input-filter" runat="server" AutoPostBack="True">
                    <asp:ListItem>Số chỗ</asp:ListItem>
                    <asp:ListItem Value="4">4 chỗ</asp:ListItem>
                    <asp:ListItem Value="7">7 chỗ</asp:ListItem>
                    <asp:ListItem Value="16">16 chỗ</asp:ListItem>
            </asp:DropDownList> 
                <asp:DropDownList ID="ddlFuel" CssClass="input-filter" runat="server" AutoPostBack="True">
                    <asp:ListItem>Nhiên liệu</asp:ListItem>
                    <asp:ListItem>Xăng</asp:ListItem>
                    <asp:ListItem>Dầu</asp:ListItem>
                    <asp:ListItem>Điện</asp:ListItem>
            </asp:DropDownList>
            </span>
        </div>
        <asp:DataList ID="DataList1" runat="server" RepeatLayout="Table" RepeatColumns="4" RepeatDirection="Horizontal" CellPadding="0" CellSpacing="25" OnItemCommand="DataList1_ItemCommand">
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
                                <i class="fa-solid fa-gas-pump"></i>
                                <%# Eval("FuelType") %>
                            </span>
                        </div>
                        <div class="vehicle-price">
                            <%# Eval("Price", "{0:N0} VNĐ/ngày") %>
                        </div>
                        <asp:LinkButton ID="lbtnRent" runat="server"
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
</asp:Content>
