<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestAPI.aspx.cs" Inherits="CarRental.TestAPI" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Image ID="imgQR" runat="server" Width="300" />
            <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date" Height="22px"></asp:TextBox>
            <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
            <asp:Label ID="lblMassage" runat="server" Text="Label"></asp:Label>
            <asp:Chart ID="Chart1" runat="server">
                <Series>
                    <asp:Series Name="DoanhThu"
                        ChartType="Column"
                        ChartArea="MainArea">
                    </asp:Series>
                </Series>

                <ChartAreas>
                    <asp:ChartArea Name="MainArea"></asp:ChartArea>
                </ChartAreas>
            </asp:Chart>    
        </div>
        <div>

            <asp:GridView ID="GridView1" runat="server">
            </asp:GridView>

        </div>
    </form>
</body>
</html>
