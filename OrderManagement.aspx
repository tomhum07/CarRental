<%@ Page Title="" Language="C#" MasterPageFile="~/SiteStaff.Master" AutoEventWireup="true" CodeBehind="OrderManagement.aspx.cs" Inherits="CarRental.OrderManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        /* ===== ORDER MANAGEMENT PAGE ===== */

        /* Page Container */
        .page-container {
            background: #ffffff;
            padding: 50px;
            border-radius: 16px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            border: 1px solid #f3f4f6;
            width: 1500px
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

        /* Filter Section */
        .filter-section {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
            padding: 25px;
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

        .form-control {
            padding: 12px 16px;
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
            background: #ffffff;
            color: #1f2937;
            font-weight: 500;
            min-width: 200px;
        }

            .form-control:focus {
                border-color: #ef4444;
                outline: none;
                box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1);
            }

        .btn-search {
            background: #3b82f6;
            color: white;
            border: none;
            padding: 12px 30px;
            cursor: pointer;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }

            .btn-search:hover {
                background: #2563eb;
                transform: translateY(-2px);
                box-shadow: 0 6px 16px rgba(59, 130, 246, 0.4);
            }

            .btn-search:active {
                transform: translateY(0);
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

        /* Action Buttons Group */
        .action-group {
            display: flex;
            gap: 8px;
            justify-content: flex-start;
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

            .btn-icon:active {
                transform: translateY(0);
            }

        /* Button Colors */
        .btn-approve {
            background: #10b981;
        }

            .btn-approve:hover {
                background: #059669;
            }

        .btn-complete {
            background: #3b82f6;
        }

            .btn-complete:hover {
                background: #2563eb;
            }

        .btn-cancel {
            background: #ef4444;
        }

            .btn-cancel:hover {
                background: #dc2626;
            }

        .btn-delete {
            background: #6b7280;
        }

            .btn-delete:hover {
                background: #4b5563;
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
            }

                .page-container h2 {
                    font-size: 24px;
                }

            .filter-section {
                padding: 20px;
            }

            .form-control {
                min-width: 150px;
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

            .action-group {
                flex-wrap: wrap;
            }

            .btn-icon {
                width: 32px;
                height: 32px;
                font-size: 12px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-container">
        <h2><i class="fa-solid fa-file-invoice-dollar"></i>Quản lý đơn thuê xe</h2>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

        <div class="filter-section">
            <strong><i class="fa-solid fa-filter"></i>Tìm kiếm & Lọc:</strong>
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Tìm theo khách hoặc biển số..."></asp:TextBox>

            <asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="form-control">
                <asp:ListItem Value="All">-- Tất cả trạng thái --</asp:ListItem>
                <asp:ListItem Value="Pending">Chờ duyệt</asp:ListItem>
                <asp:ListItem Value="Approved">Đã duyệt (Đang thuê)</asp:ListItem>
                <asp:ListItem Value="Completed">Hoàn thành</asp:ListItem>
                <asp:ListItem Value="Cancelled">Đã hủy</asp:ListItem>
            </asp:DropDownList>

            <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" CssClass="btn-search" OnClick="btnSearch_Click" />
        </div>

        <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False"
            CssClass="mydatagrid"
            DataKeyNames="OrderID"
            AllowPaging="True" PageSize="10"
            OnPageIndexChanging="gvOrders_PageIndexChanging"
            OnRowCommand="gvOrders_RowCommand"
            OnRowDeleting="gvOrders_RowDeleting">

            <PagerStyle CssClass="paging" HorizontalAlign="Center" />

            <Columns>
                <asp:TemplateField HeaderText="Ảnh">
                    <ItemTemplate>
                        <asp:Image ID="imgCar" runat="server" CssClass="car-img" ImageUrl='<%#"~/Image/Vehicle/" + Eval("CarImage") %>' />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="LicensePlate" HeaderText="Biển số" />
                <asp:BoundField DataField="VehicleName" HeaderText="Tên xe" />
                <asp:BoundField DataField="CustomerName" HeaderText="Khách hàng" />

                <asp:BoundField DataField="RentalDate" HeaderText="Ngày thuê" DataFormatString="{0:dd/MM/yyyy}" />
                <asp:BoundField DataField="ReturnDate" HeaderText="Ngày trả" DataFormatString="{0:dd/MM/yyyy}" />
                <asp:BoundField DataField="TotalPrice" HeaderText="Tổng tiền" DataFormatString="{0:0,000} VNĐ" />

                <%-- CỘT TRẠNG THÁI HIỂN THỊ TIẾNG VIỆT --%>
                <asp:TemplateField HeaderText="Trạng thái">
                    <ItemTemplate>
                        <asp:Label ID="lblStatus" runat="server"
                            Text='<%# GetStatusText(Eval("OrderStatus")) %>'
                            CssClass='<%# GetStatusClass(Eval("OrderStatus")) %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <%-- CỘT THAO TÁC VỚI CÁC NÚT MÀU --%>
                <asp:TemplateField HeaderText="Thao tác" ItemStyle-Width="140px">
                    <ItemTemplate>
                        <div class="action-group">
                            <asp:LinkButton ID="btnApprove" runat="server" CommandName="ApproveOrder" CommandArgument='<%# Eval("OrderID") %>'
                                CssClass="btn-icon btn-approve" ToolTip="Duyệt đơn (Xe -> Đã thuê)"
                                Visible='<%# IsStatus(Eval("OrderStatus"), "Pending") %>'>
                                <i class="fa-solid fa-check"></i>
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnComplete" runat="server" CommandName="CompleteOrder" CommandArgument='<%# Eval("OrderID") %>'
                                CssClass="btn-icon btn-complete" ToolTip="Hoàn tất & Trả xe (Xe -> Trống)"
                                Visible='<%# IsStatus(Eval("OrderStatus"), "Approved") %>'>
                                <i class="fa-solid fa-flag-checkered"></i>
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelOrder" CommandArgument='<%# Eval("OrderID") %>'
                                CssClass="btn-icon btn-cancel" ToolTip="Hủy đơn" OnClientClick="return confirm('Bạn chắc chắn muốn hủy đơn này?');"
                                Visible='<%# IsStatus(Eval("OrderStatus"), "Pending") %>'>
                                <i class="fa-solid fa-xmark"></i>
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="btn-icon btn-delete"
                                OnClientClick="return confirm('Xóa vĩnh viễn dòng lịch sử này?');"
                                Visible='<%# IsStatus(Eval("OrderStatus"), "Cancelled") || IsStatus(Eval("OrderStatus"), "Completed") %>'>
                                <i class="fa-solid fa-trash"></i>
                            </asp:LinkButton>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
