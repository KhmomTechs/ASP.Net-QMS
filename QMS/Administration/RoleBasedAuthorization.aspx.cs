using System;
using System.Security.Permissions;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Administration
{
    public partial class Administration_RoleBasedAuthorization : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
                BindUserGrid();
        }


        private void BindUserGrid()
        {
            var allUsers = Membership.GetAllUsers();
            UserGrid.DataSource = allUsers;
            UserGrid.DataBind();
        }

        #region RowCreated Event Handler

        protected void UserGrid_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != UserGrid.EditIndex)
            {
                // Programmatically reference the Edit and Delete LinkButtons
                var EditButton = e.Row.FindControl("EditButton") as LinkButton;
                var DeleteButton = e.Row.FindControl("DeleteButton") as LinkButton;

                EditButton.Visible = User.IsInRole("Administrators") || User.IsInRole("Supervisors");
                DeleteButton.Visible = User.IsInRole("Administrators");
            }
        }

        #endregion

        #region RowDeleting Event Handler

        [PrincipalPermission(SecurityAction.Demand, Role = "Administrators")]
        protected void UserGrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Determine the username of the user we are editing
            var UserName = UserGrid.DataKeys[e.RowIndex].Value.ToString();

            // Delete the user
            Membership.DeleteUser(UserName);

            // Revert the grid's EditIndex to -1 and rebind the data
            UserGrid.EditIndex = -1;
            BindUserGrid();
        }

        #endregion

        protected void UserGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            BindUserGrid();

            UserGrid.PageIndex = e.NewPageIndex;
            UserGrid.DataBind();
        }

        #region Editing-related Event Handlers

        protected void UserGrid_RowEditing(object sender, GridViewEditEventArgs e)
        {
            // Set the grid's EditIndex and rebind the data
            UserGrid.EditIndex = e.NewEditIndex;
            BindUserGrid();
        }

        protected void UserGrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            // Revert the grid's EditIndex to -1 and rebind the data
            UserGrid.EditIndex = -1;
            BindUserGrid();
        }

        [PrincipalPermission(SecurityAction.Demand, Role = "Administrators")]
        [PrincipalPermission(SecurityAction.Demand, Role = "Supervisors")]
        protected void UserGrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Exit if the page is not valid
            if (!Page.IsValid)
                return;

            // Determine the username of the user we are editing
            var UserName = UserGrid.DataKeys[e.RowIndex].Value.ToString();

            // Read in the entered information and update the user
            //TextBox EmailTextBox = UserGrid.Rows[e.RowIndex].FindControl("Email") as TextBox;
            var CommentTextBox = UserGrid.Rows[e.RowIndex].FindControl("Comment") as TextBox;
            //CheckBox IsApproved = UserGrid.Rows[e.RowIndex].FindControl("CheckApp") as CheckBox;
            var IsLocked = UserGrid.Rows[e.RowIndex].FindControl("CheckLock") as CheckBox;
            var IsOnline = UserGrid.Rows[e.RowIndex].FindControl("CheckOnline") as CheckBox;

            // Return information about the user
            var UserInfo = Membership.GetUser(UserName);

            // Update the User account information
            //UserInfo.Email = EmailTextBox.Text.Trim();
            UserInfo.Comment = CommentTextBox.Text.Trim();
            //UserInfo.IsLockedOut = IsLocked.Checked;
            //UserInfo.IsApproved = IsApproved.Checked;
            if (UserInfo.IsOnline)
            {
                //show if user is online
                IsOnline.Checked = true;
            }
            if (UserInfo.IsLockedOut)
            {
                //unloack locked account
                UserInfo.UnlockUser();
            }
            Membership.UpdateUser(UserInfo);

            // Revert the grid's EditIndex to -1 and rebind the data
            UserGrid.EditIndex = -1;
            BindUserGrid();
        }

        #endregion
    }
}