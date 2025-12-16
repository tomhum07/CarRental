using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CarRental
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
            //    // Kiểm tra Session để hiển thị tên
            //    if (Session["Username"] != null)
            //    {
            //        lblUsername.Text = "Xin chào, " + Session["Username"].ToString();
            //    }
            //    else
            //    {
            //        // Nếu chưa đăng nhập thì đẩy về trang Login
            //        Response.Redirect("LoginPage.aspx");
            //    }
            //}
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            //// Xóa Session và đăng xuất
            Session.RemoveAll();
            Response.Redirect("LoginPage.aspx");
        }
    }
}