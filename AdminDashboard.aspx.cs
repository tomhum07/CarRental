using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;
using DataAccess; // Đảm bảo namespace đúng với project của bạn

namespace CarRental
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        Data_CarRentalDataContext db = new Data_CarRentalDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        // --- CẬP NHẬT HÀM LOAD DATA ĐỂ HỖ TRỢ TÌM KIẾM & LỌC ---
        void LoadData()
        {
            // 1. Lấy dữ liệu ban đầu
            var query = from a in db.Accounts select a;

            // 2. Lọc theo từ khóa tìm kiếm (Username)
            if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
            {
                string keyword = txtSearch.Text.Trim();
                query = query.Where(a => a.Username.Contains(keyword));
            }

            // 3. Lọc theo Quyền hạn (nếu khác -1)
            int roleFilter = int.Parse(ddlFilterRole.SelectedValue);
            if (roleFilter != -1)
            {
                query = query.Where(a => a.Permission == (byte)roleFilter);
            }

            // 4. Lọc theo Trạng thái (0 hoặc 1)
            // Value "-1" là tất cả. "1" là Active (true), "0" là Locked (false)
            string statusFilter = ddlFilterStatus.SelectedValue;
            if (statusFilter != "-1")
            {
                bool isActive = (statusFilter == "1");
                query = query.Where(a => a.AccountStatus == isActive);
            }

            // 5. Xử lý Sắp xếp
            int sortVal = int.Parse(ddlSapXep.SelectedValue);
            if (sortVal == 1) // A-Z
            {
                query = query.OrderBy(a => a.Username);
            }
            else if (sortVal == 2) // Z-A
            {
                query = query.OrderByDescending(a => a.Username);
            }
            else
            {
                // Mặc định sắp xếp theo Username để phân trang ổn định
                query = query.OrderBy(a => a.Username);
            }

            // 6. Gán vào GridView
            gvAccounts.DataSource = query.ToList();
            gvAccounts.DataBind();
        }

        // --- SỰ KIỆN NÚT TÌM KIẾM ---
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // Khi ấn tìm kiếm, reset về trang 1
            gvAccounts.PageIndex = 0;
            LoadData();
        }

        // --- SỰ KIỆN PHÂN TRANG (MỚI) ---
        protected void gvAccounts_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvAccounts.PageIndex = e.NewPageIndex;
            LoadData();
        }

        // --- GIỮ NGUYÊN CÁC HÀM CŨ NHƯNG KIỂM TRA LẠI LOGIC ---

        public string MD5(string str)
        {
            Byte[] pass = Encoding.UTF8.GetBytes(str);
            MD5 md5 = new MD5CryptoServiceProvider();
            string strPassword = Encoding.UTF8.GetString(md5.ComputeHash(pass));
            return strPassword;
        }

        protected string GetRoleName(object permission)
        {
            if (permission == null) return "";
            byte p = Convert.ToByte(permission);
            if (p == 1) return "Admin";
            if (p == 2) return "Staff";
            return "Customer";
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                var check = db.Accounts.FirstOrDefault(x => x.Username == txtNewUser.Text.Trim());
                if (check != null)
                {
                    lblMessage.Text = "Username này đã tồn tại!";
                    return;
                }

                Account acc = new Account();
                acc.Username = txtNewUser.Text.Trim();
                acc.Password = MD5(txtNewPass.Text.Trim());
                acc.Permission = byte.Parse(ddlNewPerm.SelectedValue);
                acc.AccountStatus = true; // Mặc định hoạt động

                db.Accounts.InsertOnSubmit(acc);
                db.SubmitChanges();

                txtNewUser.Text = "";
                txtNewPass.Text = "";
                lblMessage.Text = "Thêm thành công!";
                LoadData();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi: " + ex.Message;
            }
        }

        protected void gvAccounts_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAccounts.EditIndex = e.NewEditIndex;
            LoadData();
        }

        protected void gvAccounts_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAccounts.EditIndex = -1;
            LoadData();
        }

        protected void gvAccounts_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                string username = gvAccounts.DataKeys[e.RowIndex].Value.ToString();
                TextBox txtPass = (TextBox)gvAccounts.Rows[e.RowIndex].FindControl("txtEditPass");
                DropDownList ddlPerm = (DropDownList)gvAccounts.Rows[e.RowIndex].FindControl("ddlEditPerm");

                var acc = db.Accounts.SingleOrDefault(x => x.Username == username);
                if (acc != null)
                {
                    acc.Permission = byte.Parse(ddlPerm.SelectedValue);
                    if (!string.IsNullOrEmpty(txtPass.Text.Trim()))
                    {
                        acc.Password = MD5(txtPass.Text.Trim());
                    }
                    db.SubmitChanges();
                    lblMessage.Text = "Cập nhật thành công user " + username;
                }
                gvAccounts.EditIndex = -1;
                LoadData();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi cập nhật: " + ex.Message;
            }
        }

        protected void gvAccounts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleLock")
            {
                string username = e.CommandArgument.ToString();
                var acc = db.Accounts.SingleOrDefault(x => x.Username == username);
                if (acc != null)
                {
                    acc.AccountStatus = !acc.AccountStatus;
                    db.SubmitChanges();
                    LoadData();
                }
            }
        }

        protected void gvAccounts_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // Để trống hoặc xử lý thêm nếu cần
        }

        protected void gvAccounts_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                string username = gvAccounts.DataKeys[e.RowIndex].Value.ToString();
                var acc = db.Accounts.SingleOrDefault(x => x.Username == username);

                if (acc != null)
                {
                    // Logic xóa liên hoàn (Customer -> Orders, Staff -> Orders, Account)
                    // (Giữ nguyên logic bạn đã viết trước đó ở đây)
                    var customer = db.Customers.SingleOrDefault(c => c.Username == username);
                    if (customer != null)
                    {
                        var customerOrders = db.Orders.Where(o => o.CustomerID == customer.CustomerID).ToList();
                        if (customerOrders.Any()) db.Orders.DeleteAllOnSubmit(customerOrders);
                        db.Customers.DeleteOnSubmit(customer);
                    }

                    var staff = db.Staffs.SingleOrDefault(s => s.Username == username);
                    if (staff != null)
                    {
                        var staffOrders = db.Orders.Where(o => o.StaffID == staff.StaffID).ToList();
                        if (staffOrders.Any()) db.Orders.DeleteAllOnSubmit(staffOrders);
                        db.Staffs.DeleteOnSubmit(staff);
                    }

                    db.Accounts.DeleteOnSubmit(acc);
                    db.SubmitChanges();
                    lblMessage.Text = "Đã xóa user: " + username;
                    LoadData();
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi khi xóa: " + ex.Message;
            }
        }

        // Sự kiện dropdown sắp xếp cũ (vẫn giữ để dùng chung logic)
        protected void ddlSapXep_SelectedIndexChanged(object sender, EventArgs e)
        {
            gvAccounts.PageIndex = 0; // Reset về trang 1 khi đổi sắp xếp
            LoadData();
        }
    }
}