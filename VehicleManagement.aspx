<%@ Page Title="" Language="C#" MasterPageFile="~/SiteStaff.Master" AutoEventWireup="true" CodeBehind="VehicleManagement.aspx.cs" Inherits="CarRental.StaffDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        /* ===== VEHICLE MANAGEMENT PAGE ===== */

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

        /* Add Form Section */
        .add-form {
            margin-bottom: 30px;
            padding: 30px;
            background: linear-gradient(135deg, #fef2f2 0%, #fee2e2 100%);
            border-radius: 12px;
            border: 2px solid #fecaca;
            box-shadow: 0 2px 8px rgba(239, 68, 68, 0.1);
        }

            .add-form h4 {
                color: #1f2937;
                font-size: 16px;
                font-weight: 700;
                margin-bottom: 20px;
            }

        .input-group {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            align-items: center;
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
            min-width: 150px;
        }

            .form-control:focus {
                border-color: #ef4444;
                outline: none;
                box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1);
            }

        .btn-add {
            background: #10b981;
            color: white;
            border: none;
            padding: 12px 30px;
            cursor: pointer;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
            margin-top: 15px;
        }

            .btn-add:hover {
                background: #059669;
                transform: translateY(-2px);
                box-shadow: 0 6px 16px rgba(16, 185, 129, 0.4);
            }

            .btn-add:active {
                transform: translateY(0);
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

        /* Action Buttons */
        .btn-action {
            margin-right: 8px;
            cursor: pointer;
            border: none;
            background: none;
            font-size: 18px;
            transition: all 0.2s ease;
            padding: 5px;
        }

            .btn-action:hover {
                transform: scale(1.2);
            }

        .edit-btn {
            color: #f59e0b;
        }

            .edit-btn:hover {
                color: #d97706;
            }

        .delete-btn {
            color: #ef4444;
        }

            .delete-btn:hover {
                color: #dc2626;
            }

        .save-btn {
            color: #10b981;
        }

            .save-btn:hover {
                color: #059669;
            }

        .cancel-btn {
            color: #6b7280;
        }

            .cancel-btn:hover {
                color: #4b5563;
            }

        /* Post Button */
        .btn-post {
            color: #3b82f6;
            text-decoration: none;
            font-weight: 700;
            border: 2px solid #3b82f6;
            padding: 8px 16px;
            border-radius: 8px;
            transition: all 0.2s ease;
            display: inline-block;
            font-size: 13px;
        }

            .btn-post:hover {
                background: #3b82f6;
                color: white;
            }

            .btn-post.disabled {
                color: #9ca3af;
                border-color: #e5e7eb;
                pointer-events: none;
                cursor: not-allowed;
                background: #f3f4f6;
            }

        /* Status Labels */
        .status-rented {
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

        .status-available {
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

        /* File Upload Input */
        input[type="file"] {
            padding: 10px 14px;
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            background: #ffffff;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
        }

            input[type="file"]:hover {
                border-color: #ef4444;
            }

            input[type="file"]::file-selector-button {
                padding: 8px 16px;
                border: none;
                background: #ef4444;
                color: white;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 600;
                margin-right: 10px;
                transition: background 0.2s;
            }

                input[type="file"]::file-selector-button:hover {
                    background: #dc2626;
                }

        /* Responsive */
        @media (max-width: 768px) {
            .page-container {
                padding: 30px 20px;
            }

                .page-container h2 {
                    font-size: 24px;
                }

            .add-form,
            .filter-section {
                padding: 20px;
            }

            .input-group {
                flex-direction: column;
                align-items: stretch;
            }

            .form-control {
                min-width: 100%;
            }

            .btn-add,
            .btn-search {
                width: 100%;
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-container">
        <h2><i class="fa-solid fa-car-rear"></i>Quản lý thông tin phương tiện</h2>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

        <div class="add-form">
            <h4>Thêm phương tiện mới:</h4>
            <div class="input-group">
                <asp:TextBox ID="txtNewLicensePlate" runat="server" CssClass="form-control" Placeholder="Biển số"></asp:TextBox>
                <asp:TextBox ID="txtNewNameVehicle" runat="server" CssClass="form-control" Placeholder="Tên xe"></asp:TextBox>
                <asp:TextBox ID="txtNewSeating" runat="server" CssClass="form-control" TextMode="Number" Placeholder="Số chỗ" Width="80px"></asp:TextBox>
                <asp:TextBox ID="txtNewPrice" runat="server" CssClass="form-control" Placeholder="Giá thuê" TextMode="Number"></asp:TextBox>

                <asp:DropDownList ID="ddlFuelType" runat="server" CssClass="form-control">
                    <asp:ListItem Value="0">-- Loại nhiên liệu --</asp:ListItem>
                    <asp:ListItem Value="Xăng">Xăng</asp:ListItem>
                    <asp:ListItem Value="Dầu">Dầu</asp:ListItem>
                    <asp:ListItem Value="Điện">Điện</asp:ListItem>
                </asp:DropDownList>

                <asp:FileUpload ID="fuNewImage" runat="server" CssClass="form-control" />
            </div>
            <asp:Button ID="btnAdd" runat="server" Text="Thêm xe" CssClass="btn-add" OnClick="btnAdd_Click" />
        </div>

        <div class="filter-section">
            <strong><i class="fa-solid fa-filter"></i>Tìm kiếm & Lọc:</strong>
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Tìm biển số hoặc tên xe..."></asp:TextBox>
            <asp:DropDownList ID="ddlFilterFuel" runat="server" CssClass="form-control">
                <asp:ListItem Value="All">-- Tất cả nhiên liệu --</asp:ListItem>
                <asp:ListItem Value="Xăng">Xăng</asp:ListItem>
                <asp:ListItem Value="Dầu">Dầu</asp:ListItem>
                <asp:ListItem Value="Điện">Điện</asp:ListItem>
            </asp:DropDownList>
            <asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="form-control">
                <asp:ListItem Value="-1">-- Tất cả trạng thái --</asp:ListItem>
                <asp:ListItem Value="0">Chưa cho thuê</asp:ListItem>
                <asp:ListItem Value="1">Đã cho thuê</asp:ListItem>
            </asp:DropDownList>
            <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" CssClass="btn-search" OnClick="btnSearch_Click" />
        </div>

        <asp:GridView ID="gvStaff" runat="server" AutoGenerateColumns="False"
            CssClass="mydatagrid"
            DataKeyNames="LicensePlate"
            AllowPaging="True" PageSize="10"
            OnPageIndexChanging="gvStaff_PageIndexChanging"
            OnRowCancelingEdit="gvStaff_RowCancelingEdit"
            OnRowEditing="gvStaff_RowEditing"
            OnRowUpdating="gvStaff_RowUpdating"
            OnRowDeleting="gvStaff_RowDeleting"
            OnRowCommand="gvStaff_RowCommand">

            <PagerStyle CssClass="paging" HorizontalAlign="Center" />

            <Columns>
                <%-- Cột Ảnh Xe --%>
                <asp:TemplateField HeaderText="Ảnh">
                    <ItemTemplate>
                        <asp:Image ID="imgCar" runat="server" CssClass="car-img" ImageUrl='<%# "~/Image/Vehicle/" + Eval("Image") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Image ID="imgCarEdit" runat="server" CssClass="car-img" ImageUrl='<%# Eval("Image") %>' />
                        <br />
                        <asp:FileUpload ID="fuEditImage" runat="server" Width="180px" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="LicensePlate" HeaderText="Biển số" ReadOnly="True" />
                <asp:BoundField DataField="NameVehicle" HeaderText="Tên xe" />
                <asp:BoundField DataField="SeatingCapacity" HeaderText="Số chỗ" />
                <asp:BoundField DataField="FuelType" HeaderText="Nhiên liệu" />
                <asp:BoundField DataField="Price" HeaderText="Giá/Ngày" DataFormatString="{0:0,000}" />

                <asp:TemplateField HeaderText="Trạng thái">
                    <ItemTemplate>
                        <asp:Label ID="lblStatus" runat="server"
                            Text='<%# (bool)Eval("VehicleStatus") ? "Đã cho thuê" : "Chưa cho thuê" %>'
                            CssClass='<%# (bool)Eval("VehicleStatus") ? "status-rented" : "status-available" %>'>
                        </asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <!--
                        <asp:CheckBox ID="chkTrangThai" runat="server"
                            Checked='<%# Bind("VehicleStatus") %>' Text="Đã thuê" />
                        -->
                    </EditItemTemplate>
                </asp:TemplateField>



                <asp:TemplateField HeaderText="Thao tác" ItemStyle-Width="100px">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="btn-action edit-btn"><i class="fa-solid fa-pen-to-square"></i></asp:LinkButton>
                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="btn-action delete-btn" OnClientClick="return confirm('Bạn có chắc muốn xóa?');"><i class="fa-solid fa-trash"></i></asp:LinkButton>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="btn-action save-btn"><i class="fa-solid fa-check"></i></asp:LinkButton>
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="btn-action cancel-btn"><i class="fa-solid fa-xmark"></i></asp:LinkButton>
                    </EditItemTemplate>

                    <ItemStyle Width="100px"></ItemStyle>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
