using System;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Administration
{
    public partial class Administration_ManageRoles : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
                DisplayRolesInGrid();
        }

        private void DisplayRolesInGrid()
        {
            RoleList.DataSource = Roles.GetAllRoles();
            RoleList.DataBind();
        }

        protected void CreateRoleButton_Click(object sender, EventArgs e)
        {
            var newRoleName = RoleName.Text.Trim();

            if (!Roles.RoleExists(newRoleName))
            {
                // Create the role
                Roles.CreateRole(newRoleName);

                // Refresh the RoleList Grid
                DisplayRolesInGrid();
            }

            RoleName.Text = string.Empty;
        }

        protected void RoleList_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Get the RoleNameLabel
            var RoleNameLabel = RoleList.Rows[e.RowIndex].FindControl("RoleNameLabel") as Label;

            // Delete the role
            Roles.DeleteRole(RoleNameLabel.Text, false);

            // Rebind the data to the RoleList grid
            DisplayRolesInGrid();
        }
    }
}