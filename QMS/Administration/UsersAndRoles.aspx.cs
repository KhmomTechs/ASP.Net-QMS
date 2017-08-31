using System;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Administration
{
    public partial class Administration_UsersAndRoles : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var name = Request.QueryString["NAME"];
            lblUserName.Text = name;
            //UserList.SelectedValue = name;

            var resulting = Request.QueryString["STATUS"];
            if (resulting == "ok")
            {
                ClientScript.RegisterStartupScript(GetType(),
                    "startup", "<script type=\"text/javascript\">CheckTruck();</script>");
            }

            if (!Page.IsPostBack)
            {
                // Bind the users and roles
                //BindUsersToUserList();
                BindRolesToList();

                // Check the selected user's roles
                CheckRolesForSelectedUser();
            }
        }

        private void BindRolesToList()
        {
            var UsersRoleList = (Repeater) FormProfile.FindControl("UsersRoleList");
            // Get all of the roles
            var roles = Roles.GetAllRoles();
            UsersRoleList.DataSource = roles;
            UsersRoleList.DataBind();
        }


        protected void FormProfile_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            var name = Request.QueryString["NAME"];
            var id = Request.QueryString["ID"];
            Response.Redirect("UsersAndRoles.aspx?name=" + name + "&id=" + id + "&status=ok");
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("EnhancedCreateUserWizard.aspx");
        }

        #region 'By User' Interface-Specific Methods

        private void CheckRolesForSelectedUser()
        {
            var name = Request.QueryString["NAME"];
            var UsersRoleList = (Repeater) FormProfile.FindControl("UsersRoleList");
            // Determine what roles the selected user belongs to
            var selectedUserName = name;
            var selectedUsersRoles = Roles.GetRolesForUser(selectedUserName);

            // Loop through the Repeater's Items and check or uncheck the checkbox as needed
            foreach (RepeaterItem ri in UsersRoleList.Items)
            {
                // Programmatically reference the CheckBox
                var RoleCheckBox = ri.FindControl("RoleCheckBox") as CheckBox;

                // See if RoleCheckBox.Text is in selectedUsersRoles
                if (selectedUsersRoles.Contains(RoleCheckBox.Text))
                    RoleCheckBox.Checked = true;
                else
                    RoleCheckBox.Checked = false;
            }
        }

        protected void RoleCheckBox_CheckChanged(object sender, EventArgs e)
        {
            var name = Request.QueryString["NAME"];
            // Reference the CheckBox that raised this event
            var RoleCheckBox = sender as CheckBox;

            // Get the currently selected user and role
            var selectedUserName = name;
            var roleName = RoleCheckBox.Text;

            // Determine if we need to add or remove the user from this role
            if (RoleCheckBox.Checked)
            {
                // Add the user to the role
                Roles.AddUserToRole(selectedUserName, roleName);

                // Display a status message
                ActionStatus.Text = string.Format("User {0} was added to role {1}.", selectedUserName, roleName);
            }
            else
            {
                // Remove the user from the role
                Roles.RemoveUserFromRole(selectedUserName, roleName);

                // Display a status message
                ActionStatus.Text = string.Format("User {0} was removed from role {1}.", selectedUserName, roleName);
            }
        }

        #endregion
    }
}