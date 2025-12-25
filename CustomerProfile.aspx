<%@ Page ValidateRequest="False" Title="" Language="C#" MasterPageFile="~/SiteCustomer.Master" AutoEventWireup="true" CodeBehind="CustomerProfile.aspx.cs" Inherits="CarRental.CustomerProfile" %>


<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link href="/Content/CustomerProfileStye.css" rel="stylesheet" />
    <style type="text/css">
        * {
            font-family: 'Segoe UI', Tahoma, sans-serif;
        }

        /* Page Container */
        .container {
            background: #ffffff;
            padding: 50px;
            border-radius: 16px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            max-width: 900px;
            margin: 70px auto 80px;
            border: 1px solid #f3f4f6;
        }

            .container h2 {
                font-size: 28px;
                font-weight: 700;
                color: #1f2937;
                margin-bottom: 40px;
                padding-bottom: 20px;
                border-bottom: 2px solid #f3f4f6;
            }

                .container h2 i {
                    color: #ef4444;
                    margin-right: 12px;
                }

        /* Table Layout */
        .update-info table {
            width: 100%;
            border-spacing: 0 10px;
        }

        /* Label Column */
        .auto-style2,
        .auto-style3,
        .auto-style4 {
            width: 200px;
            text-align: right;
            padding-right: 30px;
            font-weight: 600;
            color: #4b5563;
            font-size: 15px;
        }

        /* Username Display */
        #lblUsername {
            font-weight: 600;
            color: #1f2937;
            font-size: 16px;
            padding: 12px 18px;
            background: #f9fafb;
            border-radius: 8px;
            display: inline-block;
            border: 2px solid #e5e7eb;
        }

        /* Input Fields */
        .input-box {
            width: 100% !important;
            max-width: 400px;
            padding: 10px 15px !important;
            background: #f9fafb;
            border-radius: 8px !important;
            border: 2px solid #e5e7eb !important;
            outline: none;
            font-size: 15px !important;
            color: #1f2937;
            font-weight: 500;
            transition: all 0.3s ease;
            font-family: 'Segoe UI', Tahoma, sans-serif !important;
        }

            .input-box:enabled {
                background: #ffffff;
            }

                .input-box:enabled:focus {
                    border-color: #ef4444 !important;
                    box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1);
                    transform: translateY(-1px);
                }

            .input-box:disabled {
                cursor: not-allowed;
                opacity: 0.7;
            }

        /* Textarea */
        #txtAddress {
            height: 100px;
            resize: vertical;
            min-width: 400px
        }

        /* Dropdown */
        #ddlSex {
            width: 200px !important;
            cursor: pointer;
        }

            #ddlSex:enabled {
                cursor: pointer;
            }

        /* Error Message */
        #lblMassage {
            display: block;
            margin-bottom: 15px;
            padding: 12px 18px;
            background: rgba(239, 68, 68, 0.1);
            border-radius: 8px;
            border-left: 4px solid #ef4444;
            font-weight: 600;
            font-size: 14px;
        }

        /* Buttons Container */
        .update-info tr:last-child td:last-child {
            padding-top: 30px;
            display: flex;
            gap: 15px;
            align-items: center;
        }

        /* Save Button */
        .btn-save {
            padding: 14px 35px;
            background: #ef4444;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

            .btn-save:hover:enabled {
                background: #dc2626;
                transform: translateY(-2px);
                box-shadow: 0 6px 16px rgba(239, 68, 68, 0.4);
            }

            .btn-save:disabled {
                background: #9ca3af;
                cursor: not-allowed;
                box-shadow: none;
                opacity: 0.6;
            }

            .btn-save:active:enabled {
                transform: translateY(0);
            }

        /* Update Link Button */
        #lbtnUpdate {
            padding: 14px 35px;
            background: transparent;
            color: #ef4444;
            border: 2px solid #ef4444;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-block;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

            #lbtnUpdate:hover {
                background: #ef4444;
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
            }

        /* Info Row Hover Effect */
        .update-info tr {
            transition: all 0.2s ease;
        }

            .update-info tr:hover {
                background: #f9fafb;
                border-radius: 8px;
            }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 30px 20px;
                margin: 90px 20px 40px;
            }

                .container h2 {
                    font-size: 24px;
                    margin-bottom: 30px;
                }

            .update-info table {
                border-spacing: 0 15px;
            }

            .auto-style2,
            .auto-style3,
            .auto-style4 {
                width: 120px;
                padding-right: 15px;
                font-size: 14px;
            }

            .input-box {
                max-width: 100% !important;
            }

            .update-info tr:last-child td:last-child {
                flex-direction: column;
                align-items: stretch;
            }

            .btn-save,
            #lbtnUpdate {
                width: 100%;
                text-align: center;
            }
        }

        .auto-style1 {
            height: auto;
            min-height: 25px;
        }

        .auto-style3 {
            height: auto;
            min-height: 25px;
        }

        .auto-style4,
        .auto-style5 {
            height: auto;
            min-height: 24px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <h2><i class="fa-solid fa-address-card"></i>Hồ sơ của tôi</h2>
        <div class="update-info">
            <table style="width: 100%;">
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label7" runat="server" Text="Tên đăng nhập "></asp:Label>
                    </td>
                    <td class="auto-style1">
                        <asp:Label ID="lblUsername" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label1" runat="server" Text="Họ &amp; tên"></asp:Label>
                    </td>
                    <td class="auto-style1">
                        <asp:TextBox ID="txtFullname" CssClass="input-box" runat="server" Width="200px" Enabled="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label2" runat="server" Text="CCCD"></asp:Label>
                    </td>
                    <td class="auto-style1">
                        <asp:TextBox ID="txtCustomerCCCD" CssClass="input-box" runat="server" Width="200px" Enabled="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label4" runat="server" Text="Giới tính"></asp:Label>
                    </td>
                    <td class="auto-style1">
                        <asp:DropDownList ID="ddlSex" CssClass="input-box" runat="server" Enabled="False">
                            <asp:ListItem></asp:ListItem>
                            <asp:ListItem Value="1">Nam</asp:ListItem>
                            <asp:ListItem Value="2">Nữ</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label3" runat="server" Text="Số điện thoại"></asp:Label>
                    </td>
                    <td class="auto-style1">
                        <asp:TextBox ID="txtPhone" CssClass="input-box" runat="server" TextMode="Phone" Width="200px" Enabled="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label5" runat="server" Text="Địa chỉ"></asp:Label>
                    </td>
                    <td class="auto-style1">&nbsp;<asp:TextBox ID="txtAddress" CssClass="input-box" runat="server" Enabled="False" TextMode="MultiLine" Width="200px"></asp:TextBox>

                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label6" runat="server" Text="Ngày sinh"></asp:Label>
                    </td>
                    <td class="auto-style1">
                        <asp:TextBox ID="txtBirthDate" CssClass="input-box" runat="server" TextMode="Date" Width="200px" Enabled="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3"></td>
                    <td class="auto-style1">
                        <div>  
                            <asp:Label ID="lblMassage" runat="server" Text="" ForeColor="Red"></asp:Label>
                        </div>
                        <br />
                        <asp:Button ID="btnSave" CssClass="btn-save" runat="server" Text="Lưu" OnClick="btnSave_Click" Enabled="False" />
                        <asp:LinkButton ID="lbtnUpdate" runat="server" OnClick="lbtnUpdate_Click">Cập nhật</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
