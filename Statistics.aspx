<%@ Page Title="" Language="C#" MasterPageFile="~/SiteStaff.Master" AutoEventWireup="true" CodeBehind="Statistics.aspx.cs" Inherits="CarRental.Statistics" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        /* Page Container */
        .container {
            background: #ffffff;
            padding: 50px;
            border-radius: 16px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            border: 1px solid #f3f4f6;
            width: 1500px
        }

            .container h2 {
                color: #1f2937;
                border-bottom: 2px solid #f3f4f6;
                padding-bottom: 20px;
                margin-top: 0;
                margin-bottom: 30px;
                font-size: 28px;
                font-weight: 700;
            }

                .container h2 i {
                    color: #ef4444;
                    margin-right: 12px;
                }

        .month-input {
            padding: 12px 16px;
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
            background: #ffffff;
            color: #1f2937;
            font-weight: 500;
            min-width: 150px;
        }

    .form-control:focus {
        border-color: #ef4444;
        outline: none;
        box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1);
    }
        /* ===== STAT CARDS ===== */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 35px;
        }

        .stat-card {
            display: flex;
            align-items: center;
            gap: 18px;
            padding: 24px;
            border-radius: 14px;
            color: white;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

            .stat-card i {
                font-size: 34px;
                opacity: 0.9;
            }

            .stat-card span {
                font-size: 14px;
                opacity: 0.9;
            }

            .stat-card p {
                margin: 0px 0 0;
                font-size: 22px;
                font-weight: 700;
            }

            /* Màu từng thẻ */
            .stat-card.revenue {
                background: linear-gradient(135deg,#ef4444,#dc2626);
            }

            .stat-card.orders {
                background: linear-gradient(135deg,#3b82f6,#2563eb);
            }

            .stat-card.completed {
                background: linear-gradient(135deg,#10b981,#059669);
            }

            .stat-card.cancelled {
                background: linear-gradient(135deg,#6b7280,#4b5563);
            }

        .chart  {
            margin-top: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <h2><i class="fa-solid fa-chart-simple"></i>Thống kê doanh thu</h2>
        <div class="stats-grid">
            <div class="stat-card revenue">
                <i class="fa-solid fa-sack-dollar"></i>
                <div>
                    <span>Tổng doanh thu</span>
                    <p><asp:Label ID="lblTotalRevenue" runat="server" Font-Bold="True"></asp:Label></p>
                </div>
            </div>

            <div class="stat-card orders">
                <i class="fa-solid fa-file-invoice"></i>
                <div>
                    <span>Số đơn</span>
                    <p><asp:Label ID="lblTotalOrders" runat="server" Text="" Font-Bold="True"></asp:Label></p>
                </div>
            </div>

            <div class="stat-card completed">
                <i class="fa-solid fa-check-circle"></i>
                <div>
                    <span>Đơn hoàn tất</span>
                    <p><asp:Label ID="lblOrdersComplete" runat="server" Text=""></asp:Label></p>
                </div>
            </div>

            <div class="stat-card cancelled">
                <i class="fa-solid fa-xmark-circle"></i>
                <div>
                    <span>Đơn hủy</span>
                    <p><asp:Label ID="lblOrdersCancelled" runat="server" Text="" Font-Bold="True"></asp:Label></p>
                </div>
            </div>
        </div>

        <div class="filter-section">
            <asp:DropDownList ID="ddlMonth" CssClass="month-input" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlMonth_SelectedIndexChanged">
                <asp:ListItem>Chọn tháng</asp:ListItem>
                <asp:ListItem Value="1">Tháng 1</asp:ListItem>
                <asp:ListItem Value="2">Tháng 2</asp:ListItem>
                <asp:ListItem Value="3">Tháng 3</asp:ListItem>
                <asp:ListItem Value="4">Tháng 4</asp:ListItem>
                <asp:ListItem Value="5">Tháng 5</asp:ListItem>
                <asp:ListItem Value="6">Tháng 6</asp:ListItem>
                <asp:ListItem Value="7">Tháng 7</asp:ListItem>
                <asp:ListItem Value="8">Tháng 8</asp:ListItem>
                <asp:ListItem Value="9">Tháng 9</asp:ListItem>
                <asp:ListItem Value="10">Tháng 10</asp:ListItem>
                <asp:ListItem Value="11">Tháng 11</asp:ListItem>
                <asp:ListItem Value="12">Tháng 12</asp:ListItem>
            </asp:DropDownList>
        </div>
        <asp:Label ID="lblMassage" runat="server" Text=""></asp:Label>
        <div class="chart">
            <asp:Chart ID="Chart1" runat="server">
                <Series>
                    <asp:Series Name="DoanhThu"
                        ChartType="Column"
                        ChartArea="ChartArea1">
                    </asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                </ChartAreas>
            </asp:Chart>
        </div>
    </div>
</asp:Content>
