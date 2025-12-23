<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCustomer.Master" AutoEventWireup="true" CodeBehind="CarRentalHistory.aspx.cs" Inherits="CarRental.CarRentalHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Page Container */
        .page-container {
            background: #ffffff;
            padding: 50px;
            border-radius: 16px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            max-width: 1400px;
            margin: 100px auto 80px;
            border: 1px solid #f3f4f6;
        }

            .page-container h2 {
                color: #1f2937;
                border-bottom: 2px solid #f3f4f6;
                padding-bottom: 20px;
                margin-top: 0;
                margin-bottom: 30px;
                font-size: 28px;
                font-weight: 700;
            }

                .page-container h2 i {
                    color: #ef4444;
                    margin-right: 12px;
                }

        /* Filter Section */
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

        .date-input {
            padding: 12px 16px;
            font-size: 15px;
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            outline: none;
            transition: all 0.3s ease;
            background: #ffffff;
            color: #1f2937;
            font-weight: 500;
            min-width: 180px;
        }

            .date-input:focus {
                border-color: #ef4444;
                box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1);
                transform: translateY(-1px);
            }

        .form-control {
            padding: 12px 16px;
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s ease;
        }

            .form-control:focus {
                border-color: #ef4444;
                outline: none;
                box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1);
            }

        .btn-search {
            background: #ef4444;
            color: white;
            border: none;
            padding: 12px 30px;
            cursor: pointer;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

            .btn-search:hover {
                background: #dc2626;
                transform: translateY(-2px);
                box-shadow: 0 6px 16px rgba(239, 68, 68, 0.4);
            }

            .btn-search:active {
                transform: translateY(0);
            }

        /* Message Label */
        #lblMessage {
            display: block;
            margin-bottom: 20px;
            padding: 12px 18px;
            background: rgba(239, 68, 68, 0.1);
            border-radius: 8px;
            border-left: 4px solid #ef4444;
            font-weight: 600;
            font-size: 14px;
        }

        /* GridView Table */
        .mydatagrid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 1px 4px rgba(0,0,0,0.04);
        }

            .mydatagrid th {
                background: #1f2937;
                color: white;
                padding: 16px 20px;
                text-align: left;
                font-weight: 600;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .mydatagrid td {
                padding: 16px 20px;
                border-bottom: 1px solid #f3f4f6;
                vertical-align: middle;
                color: #4b5563;
                font-size: 14px;
            }

            .mydatagrid tr:last-child td {
                border-bottom: none;
            }

            .mydatagrid tr {
                transition: all 0.2s ease;
            }

                .mydatagrid tr:hover {
                    background-color: #f9fafb;
                }

        /* Car Image */
        .car-img {
            width: 100px;
            height: 70px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        /* Pagination */
        .paging {
            margin-top: 30px;
        }

            .paging td {
                text-align: center;
            }

                .paging td table {
                    margin: 0 auto;
                }

                .paging td span {
                    background: #ef4444;
                    color: #fff;
                    padding: 10px 16px;
                    border-radius: 8px;
                    margin: 0 3px;
                    font-weight: 600;
                    display: inline-block;
                }

                .paging td a {
                    background: #fff;
                    color: #4b5563;
                    padding: 10px 16px;
                    border: 2px solid #e5e7eb;
                    border-radius: 8px;
                    margin: 0 3px;
                    text-decoration: none;
                    font-weight: 600;
                    display: inline-block;
                    transition: all 0.2s ease;
                }

                    .paging td a:hover {
                        background: #f9fafb;
                        border-color: #ef4444;
                        color: #ef4444;
                    }

        /* Action Buttons */
        .action-group {
            display: flex;
            gap: 8px;
        }

        .btn-icon {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            width: 36px;
            height: 36px;
            border-radius: 8px;
            color: white;
            border: none;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s ease;
            font-size: 14px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.15);
        }

            .btn-icon:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            }

        .btn-approve {
            background: #10b981;
        }

            .btn-approve:hover {
                background: #059669;
            }

        /* Status Styles */
        .status-pending {
            color: #f59e0b;
            font-weight: 700;
            background: rgba(245, 158, 11, 0.1);
            padding: 6px 14px;
            border-radius: 6px;
            display: inline-block;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-approved {
            color: #10b981;
            font-weight: 700;
            background: rgba(16, 185, 129, 0.1);
            padding: 6px 14px;
            border-radius: 6px;
            display: inline-block;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-completed {
            color: #3b82f6;
            font-weight: 700;
            background: rgba(59, 130, 246, 0.1);
            padding: 6px 14px;
            border-radius: 6px;
            display: inline-block;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-cancelled {
            color: #ef4444;
            font-weight: 700;
            background: rgba(239, 68, 68, 0.1);
            padding: 6px 14px;
            border-radius: 6px;
            display: inline-block;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-container {
                padding: 30px 20px;
                margin: 90px 20px 40px;
            }

                .page-container h2 {
                    font-size: 24px;
                }

            .filter-section {
                padding: 20px;
            }

            .mydatagrid {
                font-size: 13px;
            }

                .mydatagrid th,
                .mydatagrid td {
                    padding: 12px 10px;
                }

            .car-img {
                width: 80px;
                height: 60px;
            }
        }

        /* Empty State */
        .mydatagrid tr td[colspan] {
            text-align: center;
            padding: 40px;
            color: #9ca3af;
            font-style: italic;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-container">
        <h2><i class="fa-solid fa-clock-rotate-left"></i>Lịch sử thuê xe</h2>

        <div class="filter-section">
            <strong><i class="fa-solid fa-filter"></i>Lọc:</strong>
            <asp:TextBox ID="txtDateFind" CssClass="date-input" runat="server" TextMode="Date"></asp:TextBox>

            <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" CssClass="btn-search" />
        </div>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False"
            CssClass="mydatagrid"
            DataKeyNames="OrderID"
            AllowPaging="True" PageSize="10"
            OnPageIndexChanging="gvOrders_PageIndexChanging">

            <PagerStyle CssClass="paging" HorizontalAlign="Center" />

            <Columns>
                <asp:TemplateField HeaderText="Ảnh">
                    <ItemTemplate>
                        <asp:Image ID="imgCar" runat="server" CssClass="car-img" ImageUrl='<%#"~/Image/Vehicle/" + Eval("CarImage") %>' />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="LicensePlate" HeaderText="Biển số" />
                <asp:BoundField DataField="VehicleName" HeaderText="Tên xe" />

                <asp:BoundField DataField="RentalDate" HeaderText="Ngày thuê" DataFormatString="{0:dd/MM/yyyy}" />
                <asp:BoundField DataField="ReturnDate" HeaderText="Ngày trả" DataFormatString="{0:dd/MM/yyyy}" />
                <asp:BoundField DataField="TotalPrice" HeaderText="Tổng tiền" DataFormatString="{0:0,000} VNĐ" />

                <asp:TemplateField HeaderText="Trạng thái">
                    <ItemTemplate>
                        <asp:Label ID="lblStatus" runat="server"
                            Text='<%# GetStatusText(Eval("OrderStatus")) %>'
                            CssClass='<%# GetStatusClass(Eval("OrderStatus")) %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
