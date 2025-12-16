using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CarRental
{
    public partial class StaffDashboard : System.Web.UI.Page
    {
        Data_CarRentalDataContext db = new Data_CarRentalDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }
        void LoadData()
        {
            int getValueDrop = int.Parse(ddlSapXep.SelectedValue);
            if (getValueDrop == 1)
            {
                var list = from a in db.Vehicles orderby a.NameVehicle ascending select a;
                gvStaff.DataSource = list;
                gvStaff.DataBind();
            }
            else if (getValueDrop == 2)
            {
                var list = from a in db.Vehicles orderby a.NameVehicle descending select a;
                gvStaff.DataSource = list;
                gvStaff.DataBind();
            }
            else
            {
                var list = from v in db.Vehicles select v;
                gvStaff.DataSource = list;
                gvStaff.DataBind();
            }
        }

        protected void gvStaff_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvStaff.EditIndex = e.NewEditIndex;
            LoadData();
        }

        protected void gvStaff_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvStaff.EditIndex = -1;
            LoadData();
        }

        protected void gvStaff_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                string bienSo = gvStaff.DataKeys[e.RowIndex].Value.ToString();

                TextBox txtTenXe = (TextBox)gvStaff.Rows[e.RowIndex].Cells[1].Controls[0];
                TextBox txtLoaiXe = (TextBox)gvStaff.Rows[e.RowIndex].Cells[2].Controls[0];
                TextBox txtGia = (TextBox)gvStaff.Rows[e.RowIndex].Cells[3].Controls[0];
                CheckBox ckbTrangThai = (CheckBox)gvStaff.Rows[e.RowIndex].Cells[4].FindControl("chkTrangThai");
                var vehicle = db.Vehicles.SingleOrDefault(v => v.LicensePlate == bienSo);

                if (vehicle != null)
                {
                    vehicle.NameVehicle = txtTenXe.Text;
                    vehicle.FuelType = txtLoaiXe.Text;
                    vehicle.Price = int.Parse(txtGia.Text);
                    if (ckbTrangThai.Checked)
                    {
                        vehicle.VehicleStatus = true;
                    }
                    else
                    {
                        vehicle.VehicleStatus = false;
                    }
                    db.SubmitChanges();
                    lblMessage.Text = "Cập nhật thành công xe có biển số: " + bienSo;
                }

                gvStaff.EditIndex = -1;
                LoadData();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi cập nhật: " + ex.Message;
            }
        }

        protected void gvStaff_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                string bienSo = gvStaff.DataKeys[e.RowIndex].Value.ToString();
                var vehicle = db.Vehicles.SingleOrDefault(v => v.LicensePlate == bienSo);
                if (vehicle != null)
                {
                    db.Vehicles.DeleteOnSubmit(vehicle);
                    db.SubmitChanges();
                    lblMessage.Text = "Xóa thành công xe có biển số: " + bienSo;
                    LoadData();
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi xóa: " + ex.Message;
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                var check = db.Vehicles.FirstOrDefault(v => v.LicensePlate == txtNewLicensePlate.Text.Trim());
                if (check != null)
                {
                    lblMessage.Text = "Xe có biển số " + txtNewLicensePlate.Text + " này đã tồn tại!";
                    txtNewLicensePlate.Text = "";
                    return;
                }

                Vehicle vehicle = new Vehicle();
                vehicle.VehicleID = db.Vehicles.Max(v => v.VehicleID) + 1;
                vehicle.LicensePlate = txtNewLicensePlate.Text;
                vehicle.NameVehicle = txtNewNameVehicle.Text;
                vehicle.Price = int.Parse(txtNewPrice.Text);
                vehicle.SeatingCapacity = int.Parse(txtNewSeating.Text);
                vehicle.VehicleStatus = true;
                vehicle.FuelType = ddlFuelType.SelectedItem.Text;
                db.Vehicles.InsertOnSubmit(vehicle);
                db.SubmitChanges();

                txtNewLicensePlate.Text = "";
                txtNewNameVehicle.Text = "";
                txtNewLicensePlate.Text = "";
                txtNewPrice.Text = "";
                txtNewSeating.Text = "";
                ddlFuelType.ClearSelection();
                lblMessage.Text = "Thêm xe thành công!";
                LoadData();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Lỗi: " + ex.Message;
            }
        }

        protected void btnLoadPage_Click(object sender, EventArgs e)
        {
            LoadData();
        }

        protected void ddlSapXep_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadData();
        }
    }
}