using DataAccess;
using System;
using System.Linq; // Cần thêm thư viện này để dùng LINQ
using System.Web.UI;

namespace CarRental
{
    public partial class PayPage : System.Web.UI.Page
    {
        // Khởi tạo DataContext (Lớp kết nối CSDL LINQ)
        Data_CarRentalDataContext db = new Data_CarRentalDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // 1. Kiểm tra đăng nhập chặt chẽ
                // Nếu chưa đăng nhập -> Đẩy về trang Login ngay
                if (Session["Username"] == null)
                {
                    Response.Redirect("LoginPage.aspx");
                    return;
                }

                // 2. Lấy VehicleID từ URL (do trang CustomerDashboard truyền sang)
                string vehicleId = Request.QueryString["VehicleID"];

                // Nếu không có ID xe, quay lại trang chọn xe
                if (string.IsNullOrEmpty(vehicleId))
                {
                    Response.Redirect("CustomerDashboard.aspx");
                    return;
                }

                // 3. Tải dữ liệu thực
                LoadCustomerInfo();       // Tải thông tin người dùng từ Session
                LoadVehicleInfo(vehicleId); // Tải thông tin xe
                SetDefaultDates();
            }
        }

        private void LoadCustomerInfo()
        {
            // Lấy username từ Session (đã lưu ở Bước 1)
            string currentUsername = Session["Username"].ToString();

            try
            {
                // Tìm khách hàng trong DB dựa vào Username
                //
                var customer = db.Customers.SingleOrDefault(c => c.Username == currentUsername);

                if (customer != null)
                {
                    // Hiển thị Fullname (Tên thật) thay vì Username (Tên đăng nhập)
                    lblCustomerName.Text = customer.Fullname;

                    lblCustomerPhone.Text = customer.Phone;
                    lblCustomerAddress.Text = customer.Address;

                    // Lưu CustomerID vào Session để dùng cho nút Thanh Toán
                    Session["CustomerID"] = customer.CustomerID;
                }
                else
                {
                    // Trường hợp tài khoản Account tồn tại nhưng chưa có thông tin trong bảng Customer
                    ShowMessage("Chưa có thông tin hồ sơ khách hàng.", false);
                }
            }
            catch (Exception ex)
            {
                lblCustomerName.Text = "Lỗi tải dữ liệu";
            }
        }

        private void LoadVehicleInfo(string vehicleIdStr)
        {
            try
            {
                int vId = int.Parse(vehicleIdStr);

                // Tìm xe trong bảng Vehicle bằng LINQ
                var vehicle = db.Vehicles.SingleOrDefault(v => v.VehicleID == vId);

                if (vehicle != null)
                {
                    lblVehicleName.Text = vehicle.NameVehicle;
                    lblSeating.Text = vehicle.SeatingCapacity.ToString();
                    lblFuelType.Text = vehicle.FuelType;
                    lblLicensePlate.Text = vehicle.LicensePlate;

                    // Lưu ý: Kiểu dữ liệu trong LINQ có thể là decimal? (nullable), cần xử lý
                    decimal price = vehicle.Price ?? 0;
                    lblPricePerDay.Text = string.Format("{0:N0} VNĐ/ngày", price);

                    Session["VehiclePrice"] = price;
                    Session["VehicleID"] = vehicle.VehicleID;

                    imgVehicle.ImageUrl = "~/Image/Vehicle/" + vehicle.Image;
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Lỗi: " + ex.Message, false);
            }
        }

        private void SetDefaultDates()
        {
            DateTime today = DateTime.Today;
            txtRentalDate.Text = today.AddDays(0).ToString("yyyy-MM-dd");
            txtReturnDate.Text = today.AddDays(1).ToString("yyyy-MM-dd");
            CalculateTotal(null, null);
        }

        protected void CalculateTotal(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtRentalDate.Text) || string.IsNullOrEmpty(txtReturnDate.Text))
                    return;

                DateTime rentalDate = DateTime.Parse(txtRentalDate.Text);
                DateTime returnDate = DateTime.Parse(txtReturnDate.Text);

                if (returnDate <= rentalDate)
                {
                    ShowMessage("Ngày trả xe phải sau ngày nhận xe!", false);
                    return;
                }

                int days = (returnDate - rentalDate).Days;
                lblDuration.Text = days.ToString();
                lblDays.Text = days.ToString();

                decimal pricePerDay = Session["VehiclePrice"] != null
                    ? Convert.ToDecimal(Session["VehiclePrice"])
                    : 500000;

                decimal subtotal = pricePerDay * days;
                decimal serviceFee = subtotal * 0.05m;
                decimal insuranceFee = subtotal * 0.03m;
                decimal total = subtotal + serviceFee + insuranceFee;

                lblSubTotal.Text = string.Format("{0:N0} VNĐ", subtotal);
                lblServiceFee.Text = string.Format("{0:N0} VNĐ", serviceFee);
                lblInsuranceFee.Text = string.Format("{0:N0} VNĐ", insuranceFee);
                lblTotal.Text = string.Format("{0:N0} VNĐ", total);

                Session["TotalPrice"] = total;
            }
            catch (Exception ex)
            {
                ShowMessage("Lỗi: " + ex.Message, false);
            }
        }

        protected void btnConfirmPayment_Click(object sender, EventArgs e)
        {
            try
            {
                DateTime rentalDate = DateTime.Parse(txtRentalDate.Text);
                DateTime returnDate = DateTime.Parse(txtReturnDate.Text);

                string username = Session["Username"]?.ToString();
                int vehicleId = Convert.ToInt32(Session["VehicleID"]);
                decimal totalPrice = Convert.ToDecimal(Session["TotalPrice"]);

                // Lấy ID khách hàng
                var customer = db.Customers.SingleOrDefault(c => c.Username == username);
                if (customer == null)
                {
                    ShowMessage("Không tìm thấy thông tin khách hàng!", false);
                    return;
                }

                // --- BẮT ĐẦU TRANSACTION ---

                // 1. Tạo đối tượng Order mới
                Order newOrder = new Order
                {
                    CustomerID = customer.CustomerID,
                    VehicleID = vehicleId,
                    StaffID = 5,
                    RentalDate = rentalDate,
                    ReturnDate = returnDate,

                    // SỬA LỖI 1: Ép kiểu decimal về int (vì database cột này là int)
                    TotalPrice = (int)totalPrice,

                    OrderStatus = ""
                };

                db.Orders.InsertOnSubmit(newOrder);

                // 2. Cập nhật trạng thái xe
                var vehicleToUpdate = db.Vehicles.SingleOrDefault(v => v.VehicleID == vehicleId);
                if (vehicleToUpdate != null)
                {
                    // SỬA LỖI 2: Dùng true thay vì 1 (vì database cột này là Bit/Boolean)
                    vehicleToUpdate.VehicleStatus = true;
                }

                db.SubmitChanges();

                ShowMessage($"Đặt xe thành công! Mã đơn: {newOrder.OrderID}", true);
            }
            catch (Exception ex)
            {
                ShowMessage("Lỗi thanh toán: " + ex.Message, false);
            }
        }

        protected void btnChangeAddress_Click(object sender, EventArgs e)
        {
            ShowMessage("Chức năng đang phát triển!", false);
        }

        // Hàm này không còn cần thiết vì ta đã lấy trực tiếp trong btnConfirmPayment
        // Nhưng nếu muốn giữ lại thì viết như sau:
        private int GetCustomerId(string username)
        {
            var user = db.Customers.SingleOrDefault(c => c.Username == username);
            return user != null ? user.CustomerID : 0;
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            lblMessage.Visible = true;
            lblMessage.CssClass = isSuccess ? "message success" : "message error";

            ScriptManager.RegisterStartupScript(this, GetType(), "hideMessage",
                "setTimeout(function(){ var msg = document.querySelector('.message'); if(msg) msg.style.display='none'; }, 5000);", true);
        }
    }
}