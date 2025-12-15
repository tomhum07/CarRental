<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="CarRental.AdminDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard - Quản lý tài khoản</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4f4f4; padding: 20px; }
        .container { background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); max-width: 1000px; margin: 0 auto; }
        h2 { color: #333; border-bottom: 2px solid #7494ec; padding-bottom: 10px; }
        
        /* Form thêm mới */
        .add-form { margin-bottom: 30px; padding: 15px; background: #eef2ff; border-radius: 8px; display: flex; gap: 10px; align-items: center; flex-wrap: wrap; }
        .add-form input, .add-form select { padding: 8px; border: 1px solid #ccc; border-radius: 4px; }
        .btn-add { background: #28a745; color: white; border: none; padding: 8px 15px; cursor: pointer; border-radius: 4px; }
        
        /* GridView Table */
        .mydatagrid { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .mydatagrid th { background-color: #7494ec; color: white; padding: 10px; text-align: left; }
        .mydatagrid td { padding: 10px; border-bottom: 1px solid #ddd; }
        .mydatagrid tr:hover { background-color: #f1f1f1; }
        
        /* Action Buttons */
        .btn-action { margin-right: 5px; cursor: pointer; border: none; background: none; font-size: 16px; }
        .edit-btn { color: #ffc107; }
        .delete-btn { color: #dc3545; }
        .save-btn { color: #28a745; }
        .cancel-btn { color: #6c757d; }
        
        /* Nút Khóa/Mở */
        .status-active { color: green; font-weight: bold; }
        .status-locked { color: red; font-weight: bold; }
        .btn-lock { padding: 5px 10px; border: 1px solid #ccc; border-radius: 4px; cursor: pointer; background: #fff; }
        .btn-lock:hover { background: #eee; }

        .filter {}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2><i class="fa-solid fa-users-gear"></i> Quản lý tài khoản</h2>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

            <div class="add-form">
                <h4>Thêm mới:</h4>
                <asp:TextBox ID="txtNewUser" runat="server" Placeholder="Username"></asp:TextBox>
                <asp:TextBox ID="txtNewPass" runat="server" Placeholder="Password" TextMode="Password"></asp:TextBox>
                <asp:DropDownList ID="ddlNewPerm" runat="server">
                    <asp:ListItem Value="1">Admin</asp:ListItem>
                    <asp:ListItem Value="2">Staff</asp:ListItem>
                    <asp:ListItem Value="3" Selected="True">Customer</asp:ListItem>
                </asp:DropDownList>
                <asp:Button ID="btnAdd" runat="server" Text="Thêm User" CssClass="btn-add" OnClick="btnAdd_Click" />
            </div>

            <div class="filter">
                Sắp xếp: <asp:DropDownList ID="ddlSapXep" runat="server" Width="100px" AutoPostBack="True" OnSelectedIndexChanged="ddlSapXep_SelectedIndexChanged">
                    <asp:ListItem Value="0">--</asp:ListItem>
                    <asp:ListItem Value="1">A-Z</asp:ListItem>
                    <asp:ListItem Value="2">Z-A</asp:ListItem>
                </asp:DropDownList>
            </div>

            <asp:GridView ID="gvAccounts" runat="server" AutoGenerateColumns="False" 
                CssClass="mydatagrid" 
                DataKeyNames="Username"
                OnRowEditing="gvAccounts_RowEditing"
                OnRowCancelingEdit="gvAccounts_RowCancelingEdit"
                OnRowUpdating="gvAccounts_RowUpdating"
                OnRowDeleting="gvAccounts_RowDeleting"
                OnRowDataBound="gvAccounts_RowDataBound"
                OnRowCommand="gvAccounts_RowCommand">
               
                <Columns>
                    <%-- Cột Username (Không được sửa vì là Khóa chính) --%>
                    <asp:BoundField DataField="Username" HeaderText="Username" ReadOnly="True" />

                    <%-- Cột Password --%>
                    <asp:TemplateField HeaderText="Password">
                        <ItemTemplate>******</ItemTemplate> 
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditPass" runat="server" Placeholder="Nhập pass mới nếu muốn đổi"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <%-- Cột Permission (Dùng DropDownList khi sửa) --%>
                    <asp:TemplateField HeaderText="Quyền hạn">
                        <ItemTemplate>
                            <%# GetRoleName(Eval("Permission")) %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlEditPerm" runat="server" SelectedValue='<%# Bind("Permission") %>'>
                                <asp:ListItem Value="1">Admin</asp:ListItem>
                                <asp:ListItem Value="2">Staff</asp:ListItem>
                                <asp:ListItem Value="3">Customer</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <%-- Cột Trạng thái (Nút Khóa/Mở nhanh) --%>
                    <asp:TemplateField HeaderText="Trạng thái">
                        <ItemTemplate>
                            <asp:Label ID="lblStatus" runat="server" 
                                Text='<%# (bool)Eval("AccountStatus") ? "Hoạt động" : "Đã khóa" %>'
                                CssClass='<%# (bool)Eval("AccountStatus") ? "status-active" : "status-locked" %>'>
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <%-- Cột Chức năng Khóa/Mở --%>
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

                    <%-- Cột Sửa/Xóa --%>
                    <asp:TemplateField HeaderText="Thao tác">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="btn-action edit-btn"><i class="fa-solid fa-pen-to-square"></i></asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="btn-action delete-btn" OnClientClick="return confirm('Bạn có chắc muốn xóa user này?');"><i class="fa-solid fa-trash"></i></asp:LinkButton>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" CssClass="btn-action save-btn"><i class="fa-solid fa-check"></i></asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CssClass="btn-action cancel-btn"><i class="fa-solid fa-xmark"></i></asp:LinkButton>
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>