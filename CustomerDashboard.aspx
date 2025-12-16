<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerDashboard.aspx.cs" Inherits="CarRental.CustomerDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .image-btn {
            width: 100%;
            height: 150px;
            object-fit: contain;
            cursor: pointer;
            border: none;
            background: white;
            padding: 10px;
            margin-bottom: 10px;
        }

        .vehicle-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            padding: 20px;
        }

        .vehicle-item {
            width: 280px;
            background: white;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 15px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: transform 0.2s, box-shadow 0.2s;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .vehicle-item img {
            width: 100%;
            height: 200px;
            object-fit: contain;
            margin-bottom: 10px;
        }

        .vehicle-name {
            font-size: 20px;
            color: #333;
            margin: 10px 0;
            min-height: 40px;
        }

        .vehicle-price {
            font-size: 16px;
            color: #e44d26;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1>Customer Dashboard</h1>
        <div class="vehicle-container">
            <asp:DataList ID="DataList1" runat="server" RepeatColumns="3"><ItemTemplate>
                    <div class="vehicle-item">
                        <asp:ImageButton ID="ImageButton1" CssClass="image-btn" runat="server" 
                            ImageUrl='<%# "~/Image/Vehicle/" + Eval("Image") %>' />
                        <div class="vehicle-name">
                            <asp:HyperLink ID="HyperLink1" runat="server" 
                                Text='<%# Eval("NameVehicle") %>'></asp:HyperLink>
                        </div>
                        <div class="vehicle-price">
                            <asp:Label ID="Label1" runat="server" 
                                Text='<%# Eval("Price") + " VNĐ/Ngày" %>'></asp:Label>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>
        </div>
    </form>
</body>
</html>
