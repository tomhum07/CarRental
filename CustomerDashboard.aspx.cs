using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CarRental
{
    public partial class CustomerDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ShowPage();
        }

        public void ShowPage()
        {
            Data_CarRentalDataContext db = new Data_CarRentalDataContext();
            var vehicle = from p in db.Vehicles.Where(v => v.VehicleStatus == false).OrderBy(v => v.NameVehicle)
                           select p;
            DataList1.DataSource = vehicle; 
            DataList1.DataBind();
        }
    }
}