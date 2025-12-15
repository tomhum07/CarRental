<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StaffDashboard.aspx.cs" Inherits="CarRental.StaffDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
        .status-active { color: red; font-weight: bold; }
        .status-locked { color: green; font-weight: bold; }
        .btn-lock { padding: 5px 10px; border: 1px solid #ccc; border-radius: 4px; cursor: pointer; background: #fff; }
        .btn-lock:hover { background: #eee; }

        .filter {}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2><i class="fa-solid fa-car-rear"></i> </i>Quản lý thông tin phương tiện</h2>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

            <div class="add-form">
                <h4>Thêm phương tiện mới:</h4>
                <div class="input-place">
                    <asp:TextBox ID="txtNewLicensePlate" runat="server" Placeholder="Biển số"></asp:TextBox>
                    <asp:TextBox ID="txtNewNameVehicle" runat="server" Placeholder="Tên xe"></asp:TextBox>
                    <asp:TextBox ID="txtNewSeating" runat="server" TextMode="Number" Placeholder="Số chỗ"></asp:TextBox>
                    <asp:DropDownList ID="ddlFuelType" runat="server">
                        <asp:ListItem Value="0">-- Loại xe --</asp:ListItem>
                        <asp:ListItem Value="1">Xăng</asp:ListItem>
                        <asp:ListItem Value="2">Dầu </asp:ListItem>
                        <asp:ListItem Value="3">Điện</asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox ID="txtNewPrice" runat="server" Placeholder="Giá" TextMode="Number"></asp:TextBox>
                </div>
                <asp:Button ID="btnAdd" runat="server" Text="Thêm xe" CssClass="btn-add" OnClick="btnAdd_Click" />
            </div>

            <div class="filter">
                Sắp xếp:
                <asp:DropDownList ID="ddlSapXep" runat="server" Width="100px" AutoPostBack="True" OnSelectedIndexChanged="ddlSapXep_SelectedIndexChanged" >
                    <asp:ListItem Value="0">--</asp:ListItem>
                    <asp:ListItem Value="1">Tên xe A-Z</asp:ListItem>
                    <asp:ListItem Value="2">Tên xe Z-A</asp:ListItem>
                </asp:DropDownList>
                <asp:Button ID="btnLoadPage" runat="server" OnClick="btnLoadPage_Click" Text="Load Page" />
            </div>

            <asp:GridView ID="gvStaff" runat="server" AutoGenerateColumns="False"
                CssClass="mydatagrid"
                DataKeyNames="LicensePlate" 
                OnRowCancelingEdit="gvStaff_RowCancelingEdit" 
                OnRowEditing="gvStaff_RowEditing" OnRowUpdating="gvStaff_RowUpdating" OnRowDeleting="gvStaff_RowDeleting">
                

                <Columns>
                    <asp:BoundField DataField="LicensePlate" HeaderText="Biển số" ReadOnly="True" />
                    <asp:BoundField DataField="NameVehicle" HeaderText="Tên xe" />
                    <asp:BoundField DataField="FuelType" HeaderText="Loại xe" />
                    <asp:BoundField DataField="Price" HeaderText="Giá" />

                    <asp:TemplateField HeaderText="Trạng thái">
                        <ItemTemplate>
                            <asp:Label ID="lblStatus" runat="server"
                                Text='<%# (bool)Eval("VehicleStatus") ? "Đã cho thuê" : "Chưa cho thuê" %>'
                                CssClass='<%# (bool)Eval("VehicleStatus") ? "status-active" : "status-locked" %>'>
                            </asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:CheckBox ID="chkTrangThai" runat="server"
                                Checked='<%# Bind("VehicleStatus") %>'
                                Text="Đã cho thuê" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Thao tác">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="btn-action edit-btn"><i class="fa-solid fa-pen-to-square"></i></asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="btn-action delete-btn" OnClientClick="return confirm('Bạn có chắc muốn xóa xe này?');"><i class="fa-solid fa-trash"></i></asp:LinkButton>
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
