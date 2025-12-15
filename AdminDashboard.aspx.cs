using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;
using DataAccess;

namespace CarRental
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        // Khởi tạo connection context
        Data_CarRentalDataContext db = new Data_CarRentalDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        // Hàm load dữ liệu lên GridView
        void LoadData()
        {
            var list = from a in db.Accounts select a;
            gvAccounts.DataSource = list;
            gvAccounts.DataBind();
        }

        // Hàm mã hóa MD5
        public string MD5(string str)
        {
            if (string.IsNullOrEmpty(str)) return "";
            Byte[] inputBytes = Encoding.UTF8.GetBytes(str);
            MD5 md5 = new MD5CryptoServiceProvider();
            Byte[] hashBytes = md5.ComputeHash(inputBytes);
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < hashBytes.Length; i++)
                sb.Append(hashBytes[i].ToString("x2"));
            return sb.ToString();
        }

        // --- SỬA LỖI 1: Thêm hàm này để bên giao diện (.aspx) gọi được ---
        protected string GetRoleName(object permission)
        {
            if (permission == null) return "";
            byte p = Convert.ToByte(permission);
            if (p == 1) return "Admin";
            if (p == 2) return "Staff";
            return "Customer";
        }

        // Thêm mới User
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

                // --- SỬA LỖI 2: Dùng byte.Parse thay vì int.Parse ---
                acc.Permission = byte.Parse(ddlNewPerm.SelectedValue);

                acc.AccountStatus = true;

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

        // Chế độ sửa
        protected void gvAccounts_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvAccounts.EditIndex = e.NewEditIndex;
            LoadData();
        }

        // Hủy sửa
        protected void gvAccounts_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvAccounts.EditIndex = -1;
            LoadData();
        }

        // Cập nhật (Lưu sửa)
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
                    // --- SỬA LỖI 2: Dùng byte.Parse ---
                    acc.Permission = byte.Parse(ddlPerm.SelectedValue);

                    // Chỉ đổi pass nếu có nhập
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

        // Xóa
        //protected void gvAccounts_RowDeleting(object sender, GridViewDeleteEventArgs e)
        //{
        //    try
        //    {
        //        string username = gvAccounts.DataKeys[e.RowIndex].Value.ToString();
        //        var acc = db.Accounts.SingleOrDefault(x => x.Username == username);

        //        if (acc != null)
        //        {
        //            db.Accounts.DeleteOnSubmit(acc);
        //            db.SubmitChanges();
        //            lblMessage.Text = "Đã xóa user " + username;
        //        }
        //        LoadData();
        //    }
        //    catch (Exception ex)
        //    {
        //        lblMessage.Text = "Không thể xóa: " + ex.Message;
        //    }
        //}

        // Khóa / Mở khóa
        protected void gvAccounts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleLock")
            {
                string username = e.CommandArgument.ToString();
                var acc = db.Accounts.SingleOrDefault(x => x.Username == username);

                if (acc != null)
                {
                    // --- SỬA LỖI 3: Bỏ '?? false' vì cột này không Null ---
                    bool currentStatus = acc.AccountStatus;

                    acc.AccountStatus = !currentStatus;
                    db.SubmitChanges();
                    LoadData();
                }
            }
        }

        protected void gvAccounts_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // Hàm này có thể để trống, chưa cần viết gì
        }

        // Đổi tên hàm thành RowDeleting và kiểu tham số thành GridViewDeleteEventArgs
        protected void gvAccounts_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                string username = gvAccounts.DataKeys[e.RowIndex].Value.ToString();
                var acc = db.Accounts.SingleOrDefault(x => x.Username == username);

                if (acc != null)
                {
                    // ---------------------------------------------------------
                    // 1. XỬ LÝ KHÁCH HÀNG (CUSTOMER)
                    // ---------------------------------------------------------
                    var customer = db.Customers.SingleOrDefault(c => c.Username == username);
                    if (customer != null)
                    {
                        // A. Xóa Đơn hàng (Bảng Con) trước
                        // ---> SỬA Ở ĐÂY: Thay 'customer.ID' bằng tên cột khóa chính thật (ví dụ: CustomerID, MaKH...)
                        var customerOrders = db.Orders.Where(o => o.CustomerID == customer.CustomerID).ToList(); // <--- Kiểm tra tên cột này

                        if (customerOrders.Count > 0)
                        {
                            db.Orders.DeleteAllOnSubmit(customerOrders);
                        }

                        // B. Sau đó xóa Customer (Bảng Cha)
                        db.Customers.DeleteOnSubmit(customer);
                    }

                    // ---------------------------------------------------------
                    // 2. XỬ LÝ NHÂN VIÊN (STAFF)
                    // ---------------------------------------------------------
                    var staff = db.Staffs.SingleOrDefault(s => s.Username == username);
                    if (staff != null)
                    {
                        // A. Xóa Đơn hàng do nhân viên này phụ trách
                        // ---> SỬA Ở ĐÂY: Thay 'staff.ID' bằng tên cột khóa chính thật (ví dụ: StaffID, MaNV...)
                        var staffOrders = db.Orders.Where(o => o.StaffID == staff.StaffID).ToList(); // <--- Kiểm tra tên cột này

                        if (staffOrders.Count > 0)
                        {
                            db.Orders.DeleteAllOnSubmit(staffOrders);
                        }

                        // B. Sau đó xóa Staff
                        db.Staffs.DeleteOnSubmit(staff);
                    }

                    // ---------------------------------------------------------
                    // 3. CUỐI CÙNG XÓA TÀI KHOẢN (ACCOUNT)
                    // ---------------------------------------------------------
                    db.Accounts.DeleteOnSubmit(acc);
                    db.SubmitChanges();

                    lblMessage.Text = "Đã xóa thành công user: " + username;
                    LoadData();
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi khi xóa: " + ex.Message;
            }
        }
    }
}