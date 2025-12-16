﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="CarRental.AdminDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard - Quản lý tài khoản</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4f4f4; padding: 20px; }
        .container { background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); max-width: 1100px; margin: 0 auto; }
        h2 { color: #333; border-bottom: 2px solid #7494ec; padding-bottom: 10px; }
        
        /* Form thêm mới */
        .add-form { margin-bottom: 20px; padding: 15px; background: #eef2ff; border-radius: 8px; display: flex; gap: 10px; align-items: center; flex-wrap: wrap; }
        .form-control { padding: 8px; border: 1px solid #ccc; border-radius: 4px; }
        .btn-add { background: #28a745; color: white; border: none; padding: 8px 15px; cursor: pointer; border-radius: 4px; }
        
        /* Phần Tìm kiếm & Lọc */
        .filter-section {
            display: flex; gap: 10px; margin-bottom: 20px; padding: 15px; background: #f8f9fa; border-radius: 8px; align-items: center; flex-wrap: wrap;
        }
        .btn-search { background: #007bff; color: white; border: none; padding: 8px 15px; cursor: pointer; border-radius: 4px; }
        
        /* GridView Table */
        .mydatagrid { width: 100%; border-collapse: collapse; margin-top: 10px; }
        .mydatagrid th { background-color: #7494ec; color: white; padding: 10px; text-align: left; }
        .mydatagrid td { padding: 10px; border-bottom: 1px solid #ddd; }
        .mydatagrid tr:hover { background-color: #f1f1f1; }

        /* Phân trang GridView */
        .mydatagrid tr.paging td table { margin: 10px auto; } 
        .mydatagrid tr.paging td span { background: #7494ec; color: #fff; padding: 5px 10px; border-radius: 4px; margin: 2px; }
        .mydatagrid tr.paging td a { background: #fff; color: #333; padding: 5px 10px; border: 1px solid #ddd; border-radius: 4px; margin: 2px; text-decoration: none; }
        .mydatagrid tr.paging td a:hover { background: #eee; }
        
        /* Action Buttons */
        .btn-action { margin-right: 5px; cursor: pointer; border: none; background: none; font-size: 16px; }
        .edit-btn { color: #ffc107; }
        .delete-btn { color: #dc3545; }
        .save-btn { color: #28a745; }
        .cancel-btn { color: #6c757d; }
        
        /* Trạng thái */
        .status-active { color: green; font-weight: bold; }
        .status-locked { color: red; font-weight: bold; }
        .btn-lock { padding: 5px 10px; border: 1px solid #ccc; border-radius: 4px; cursor: pointer; background: #fff; text-decoration: none; color: #333;}
        .btn-lock:hover { background: #eee; }

        /* Password Wrapper để chứa icon mắt */
        .password-wrapper { position: relative; display: inline-block; }
        .password-wrapper input { padding-right: 30px; }
        .toggle-password { position: absolute; right: 8px; top: 50%; transform: translateY(-50%); cursor: pointer; color: #666; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2><i class="fa-solid fa-users-gear"></i> Quản lý tài khoản</h2>
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
                <strong><i class="fa-solid fa-filter"></i> Bộ lọc:</strong>
                
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