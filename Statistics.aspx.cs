using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CarRental
{
    public partial class Statistics : System.Web.UI.Page
    {
        Data_CarRentalDataContext db = new Data_CarRentalDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStatCard();
            }
        }

        private void LoadChart()
        {
            int month = int.Parse(ddlMonth.SelectedValue);
            try
            {
                var result = db.Orders
                                .Where(x => x.ReturnDate.Value.Month == month && x.OrderStatus == "Completed")
                                .GroupBy(x => x.ReturnDate.Value.Day)
                                .Select(g => new
                                {
                                    Ngay = g.Key,
                                    TotalDay = g.Sum(o => o.TotalPrice)
                                })
                                .OrderBy(x => x.Ngay);
                
                
                if (result.Count() != 0)
                {
                    lblMassage.Text = "";
                    Chart1.Series["DoanhThu"].XValueMember = "Ngay";
                    Chart1.Series["DoanhThu"].YValueMembers = "TotalDay";
                    Chart1.DataSource = result;
                    Chart1.DataBind();
                }
                else
                {
                    lblMassage.Text = "Không có dữ liệu trong tháng " + month.ToString();
                }
            }
            catch (Exception ex)
            {
                lblMassage.Text = "Lỗi: " + ex.Message;
            }
            
        }
        private void LoadStatCard()
        {
            int totalRevenue = db.Orders.Select(x => (int?)x.TotalPrice).Sum() ?? 0;
            int countOrders = db.Orders.Count();
            int completeOrders = db.Orders.Where(x => x.OrderStatus == "Completed").Count();
            int cancelledOrders = db.Orders.Where(x => x.OrderStatus == "Cancelled").Count();

            lblTotalRevenue.Text = totalRevenue.ToString("N0") + " VNĐ";
            lblTotalOrders.Text = countOrders.ToString();
            lblOrdersComplete.Text = completeOrders.ToString();
            lblOrdersCancelled.Text = cancelledOrders.ToString();
        }
        protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadChart();
        }
    }
}