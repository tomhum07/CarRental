﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="CarRental.AdminDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard - Quản lý tài khoản</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background: linear-gradient(135deg, #f3f4f6 0%, #e5e7eb 100%);
            padding: 40px 20px;
            min-height: 100vh;
        }

        /* Container */
        .container {
            background: #ffffff;
            padding: 50px;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            max-width: 1400px;
            margin: 0 auto;
            border: 1px solid #f3f4f6;
        }

            .container h2 {
                color: #1f2937;
                border-bottom: 2px solid #f3f4f6;
                padding-bottom: 20px;
                margin-bottom: 30px;
                font-size: 28px;
                font-weight: 700;
            }

                .container h2 i {
                    color: #ef4444;
                    margin-right: 12px;
                }

        /* Message Label */
        #lblMessage {
            display: block;
            margin-bottom: 20px;
            padding: 12px 18px;
            font-weight: 600;
            font-size: 14px;
        }

        /* Add Form Section */
        .add-form {
            margin-bottom: 30px;
            padding: 30px;
            background: linear-gradient(135deg, #fef2f2 0%, #fee2e2 100%);
            border-radius: 12px;
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
            border: 2px solid #fecaca;
            box-shadow: 0 2px 8px rgba(239, 68, 68, 0.1);
        }

            .add-form h4 {
                color: #1f2937;
                font-size: 16px;
                font-weight: 700;
                margin: 0;
                width: 100%;
                margin-bottom: 10px;
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
            min-width: 180px;
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
        }

            .btn-add:hover {
                background: #059669;
                transform: translateY(-2px);
                box-shadow: 0 6px 16px rgba(16, 185, 129, 0.4);
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
                color: #4b5563;
                font-size: 14px;
                vertical-align: middle;
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

                /* Pagination */
                .mydatagrid tr.paging td {
                    text-align: center;
                    padding-top: 20px;
                }

                    .mydatagrid tr.paging td table {
                        margin: 0 auto;
                    }

                    .mydatagrid tr.paging td span {
                        background: #ef4444;
                        color: #fff;
                        padding: 10px 16px;
                        border-radius: 8px;
                        margin: 0 3px;
                        font-weight: 600;
                        display: inline-block;
                    }

                    .mydatagrid tr.paging td a {
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

                        .mydatagrid tr.paging td a:hover {
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

        /* Status Labels */
        .status-active {
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

        .status-locked {
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

        /* Lock/Unlock Button */
        .btn-lock {
            padding: 8px 16px;
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            cursor: pointer;
            background: #fff;
            text-decoration: none;
            color: #4b5563;
            font-weight: 600;
            transition: all 0.2s ease;
            display: inline-block;
        }

            .btn-lock:hover {
                background: #f9fafb;
                border-color: #ef4444;
                color: #ef4444;
            }

            .btn-lock i {
                margin-right: 6px;
            }

        /* Password Wrapper */
        .password-wrapper {
            position: relative;
            display: inline-block;
            width: 100%;
            max-width: 250px;
        }

            .password-wrapper input {
                padding-right: 40px !important;
                width: 100%;
            }

        .toggle-password {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #9ca3af;
            font-size: 16px;
            transition: color 0.2s;
        }

            .toggle-password:hover {
                color: #ef4444;
            }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 30px 20px;
            }

                .container h2 {
                    font-size: 24px;
                }

            .add-form,
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

            .form-control {
                min-width: 150px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2><i class="fa-solid fa-users-gear"></i>Quản lý tài khoản</h2>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

            <div class="add-form">
                <h4>Thêm nhanh:</h4>
                <asp:TextBox ID="txtNewUser" runat="server" CssClass="form-control" Placeholder="Username"></asp:TextBox>

                <div class="password-wrapper">
                    <asp:TextBox ID="txtNewPass" runat="server" CssClass="form-control" Placeholder="Password" TextMode="Password"></asp:TextBox>
                    <i class="fa-solid fa-eye toggle-password" onclick="togglePassword('<%= txtNewPass.ClientID %>', this)"></i>
                </div>

                <asp:DropDownList ID="ddlNewPerm" runat="server" CssClass="form-control">
                    <asp:ListItem Value="1">Admin</asp:ListItem>
                    <asp:ListItem Value="2">Staff</asp:ListItem>
                    <asp:ListItem Value="3" Selected="True">Customer</asp:ListItem>
                </asp:DropDownList>
                <asp:Button ID="btnAdd" runat="server" Text="Thêm User" CssClass="btn-add" OnClick="btnAdd_Click" />
            </div>

            <div class="filter-section">
                <strong><i class="fa-solid fa-filter"></i>Bộ lọc:</strong>

                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Tìm theo Username..."></asp:TextBox>

                <asp:DropDownList ID="ddlFilterRole" runat="server" CssClass="form-control">
                    <asp:ListItem Value="-1">-- Tất cả Quyền --</asp:ListItem>
                    <asp:ListItem Value="1">Admin</asp:ListItem>
                    <asp:ListItem Value="2">Staff</asp:ListItem>
                    <asp:ListItem Value="3">Customer</asp:ListItem>
                </asp:DropDownList>

                <asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="form-control">
                    <asp:ListItem Value="-1">-- Tất cả Trạng thái --</asp:ListItem>
                    <asp:ListItem Value="1">Hoạt động (1)</asp:ListItem>
                    <asp:ListItem Value="0">Đã khóa (0)</asp:ListItem>
                </asp:DropDownList>

                <asp:DropDownList ID="ddlSapXep" runat="server" CssClass="form-control">
                    <asp:ListItem Value="0">-- Sắp xếp --</asp:ListItem>
                    <asp:ListItem Value="1">A-Z</asp:ListItem>
                    <asp:ListItem Value="2">Z-A</asp:ListItem>
                </asp:DropDownList>

                <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" CssClass="btn-search" OnClick="btnSearch_Click" />
            </div>

            <asp:GridView ID="gvAccounts" runat="server" AutoGenerateColumns="False"
                CssClass="mydatagrid"
                DataKeyNames="Username"
                AllowPaging="True" PageSize="10"
                OnPageIndexChanging="gvAccounts_PageIndexChanging"
                OnRowEditing="gvAccounts_RowEditing"
                OnRowCancelingEdit="gvAccounts_RowCancelingEdit"
                OnRowUpdating="gvAccounts_RowUpdating"
                OnRowDeleting="gvAccounts_RowDeleting"
                OnRowDataBound="gvAccounts_RowDataBound"
                OnRowCommand="gvAccounts_RowCommand">

                <PagerStyle CssClass="paging" HorizontalAlign="Center" />

                <Columns>
                    <asp:BoundField DataField="Username" HeaderText="Username" ReadOnly="True" />

                    <%-- Cột Password có ẩn hiện khi Edit --%>
                    <asp:TemplateField HeaderText="Password">
                        <ItemTemplate>******</ItemTemplate>
                        <EditItemTemplate>
                            <div class="password-wrapper">
                                <asp:TextBox ID="txtEditPass" runat="server" CssClass="form-control" Placeholder="Nhập pass mới" TextMode="Password"></asp:TextBox>
                                <i class="fa-solid fa-eye toggle-password" onclick="togglePasswordRow(this)"></i>
                            </div>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Quyền hạn">
                        <ItemTemplate>
                            <%# GetRoleName(Eval("Permission")) %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlEditPerm" runat="server" CssClass="form-control" SelectedValue='<%# Bind("Permission") %>'>
                                <asp:ListItem Value="1">Admin</asp:ListItem>
                                <asp:ListItem Value="2">Staff</asp:ListItem>
                                <asp:ListItem Value="3">Customer</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Trạng thái">
                        <ItemTemplate>
                            <asp:Label ID="lblStatus" runat="server"
                                Text='<%# (bool)Eval("AccountStatus") ? "Hoạt động" : "Đã khóa" %>'
                                CssClass='<%# (bool)Eval("AccountStatus") ? "status-active" : "status-locked" %>'>
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Khóa/Mở">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnToggleLock" runat="server"
                                CommandName="ToggleLock"
                                CommandArgument='<%# Eval("Username") %>'
                                CssClass="btn-lock">
                                <i class='<%# (bool)Eval("AccountStatus") ? "fa-solid fa-lock" : "fa-solid fa-lock-open" %>'></i>
                                <%# (bool)Eval("AccountStatus") ? "Khóa" : "Mở" %>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Thao tác" ItemStyle-Width="100px">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="btn-action edit-btn" ToolTip="Sửa"><i class="fa-solid fa-pen-to-square"></i></asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="btn-action delete-btn" OnClientClick="return confirm('Bạn có chắc muốn xóa user này?');" ToolTip="Xóa"><i class="fa-solid fa-trash"></i></asp:LinkButton>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="btn-action save-btn" ToolTip="Lưu"><i class="fa-solid fa-check"></i></asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="btn-action cancel-btn" ToolTip="Hủy"><i class="fa-solid fa-xmark"></i></asp:LinkButton>
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:Button ID="btnLogout" runat="server" Text="Đăng xuất" />
        </div>
        
    </form>

    <script>
        // Hàm ẩn hiện password cho ô Thêm mới
        function togglePassword(inputId, icon) {
            var input = document.getElementById(inputId);
            if (input.type === "password") {
                input.type = "text";
                icon.classList.remove("fa-eye");
                icon.classList.add("fa-eye-slash");
            } else {
                input.type = "password";
                icon.classList.remove("fa-eye-slash");
                icon.classList.add("fa-eye");
            }
        }

        // Hàm ẩn hiện password cho ô Sửa (trong GridView)
        function togglePasswordRow(icon) {
            // Tìm ô input nằm ngay trước icon trong cùng thẻ div
            var wrapper = icon.parentElement;
            var input = wrapper.querySelector('input');

            if (input.type === "password") {
                input.type = "text";
                icon.classList.remove("fa-eye");
                icon.classList.add("fa-eye-slash");
            } else {
                input.type = "password";
                icon.classList.remove("fa-eye-slash");
                icon.classList.add("fa-eye");
            }
        }
    </script>
</body>
</html>
