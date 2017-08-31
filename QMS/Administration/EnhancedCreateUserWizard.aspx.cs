using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Administration
{
    public partial class Administration_EnhancedCreateUserWizard : Page
    {
        private string[] rolesArray;

        protected void Page_Load(object sender, EventArgs e)
        {
            var resulting = Request.QueryString["STATUS"];
            var userNumber = Request.QueryString["USER"];
            var UserNamed = NewUserWizard.CreateUserStep.ContentTemplateContainer.FindControl("UserName") as TextBox;

            if (resulting == "ok")
            {
                ClientScript.RegisterStartupScript(GetType(),
                    "startup", "<script type=\"text/javascript\">CheckTruck();</script>");

                lblPopUp.Text = "Account " + userNumber + " was created successfully.";
            }


            if (!IsPostBack)
            {
                Validate();

                var RolesListBox =
                    NewUserWizard.CreateUserStep.ContentTemplateContainer.FindControl("RolesListBox") as ListBox;

                rolesArray = Roles.GetAllRoles();
                RolesListBox.DataSource = rolesArray;
                RolesListBox.DataBind();
            }
        }

        protected void NewUserWizard_CreatedUser(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            // Get the UserId of the just-added user
            var newUser = Membership.GetUser(NewUserWizard.UserName);
            var newUserId = (Guid) newUser.ProviderUserKey;

            var First_Name = NewUserWizard.CreateUserStep.ContentTemplateContainer.FindControl("First_Name") as TextBox;
            var Last_Name = NewUserWizard.CreateUserStep.ContentTemplateContainer.FindControl("Last_Name") as TextBox;
            var Position = NewUserWizard.CreateUserStep.ContentTemplateContainer.FindControl("Position") as TextBox;
            var RolesListBox =
                NewUserWizard.CreateUserStep.ContentTemplateContainer.FindControl("RolesListBox") as ListBox;
            var ErrorMessage =
                NewUserWizard.CreateUserStep.ContentTemplateContainer.FindControl("ErrorMessage") as Literal;

            // Insert a new record into UserProfiles
            var connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;
            var insertSql =
                "INSERT INTO UserProfiles(UserId, First_Name, Last_Name, Position) VALUES(@UserId, @First_Name, @Last_Name, @Position)";


            using (var myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();

                var myCommand = new SqlCommand(insertSql, myConnection);
                myCommand.Parameters.AddWithValue("@UserId", newUserId);
                myCommand.Parameters.AddWithValue("@First_Name", First_Name.Text);
                myCommand.Parameters.AddWithValue("@Last_Name", Last_Name.Text);
                myCommand.Parameters.AddWithValue("@Position", Position.Text);

                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }

            //Adding the roles
            var role_indices = RolesListBox.GetSelectedIndices();

            if (role_indices.Length == 0)
            {
                ErrorMessage.Text = "Please select one or more roles.";
                return;
            }


            // Create list of roles to be add the selected users to.

            var rolesList = new string[role_indices.Length];

            for (var i = 0; i < rolesList.Length; i++)
            {
                rolesList[i] = RolesListBox.Items[role_indices[i]].Value;
            }

            // Add the users to the selected role.
            try
            {
                Roles.AddUserToRoles(newUser.UserName, rolesList);
                ErrorMessage.Text = "User added to Role(s).";
            }
            catch (HttpException ex)
            {
                ErrorMessage.Text = ex.Message;
            }

            Response.Redirect("EnhancedCreateUserWizard.aspx?status=ok&user=" + newUser.UserName);
        }

        protected void NewUserWizard_CreatingUser(object sender, LoginCancelEventArgs e)
        {
            if (!Page.IsValid) return;

            var ErrorMessage =
                NewUserWizard.CreateUserStep.ContentTemplateContainer.FindControl("ErrorMessage") as Literal;
            var LabelDetails =
                NewUserWizard.CreateUserStep.ContentTemplateContainer.FindControl("LabelDetails") as Label;
            var trimmedUserName = NewUserWizard.UserName.Trim();
            if (NewUserWizard.UserName.Length != trimmedUserName.Length)
            {
                //ErrorMessage.Text = "The company number cannot contain spaces";

                //Response.Redirect("EnhancedCreateUserWizard.aspx?status=done1&user="+ trimmedUserName);
                //string prompt = "<script>$(document).ready(function(){{$.prompt('{0}');}});</script>";
                //string message = string.Format(prompt, "The company number cannot contain spaces");
                //ClientScript.RegisterStartupScript(typeof(Page), "message", message);
                e.Cancel = true;
                LabelDetails.Text = "The company number cannot contain spaces";
            }
            else if (NewUserWizard.Password.IndexOf(NewUserWizard.UserName, StringComparison.OrdinalIgnoreCase) >= 0)
            {
                //ErrorMessage.Text = "The company number cannot be part of the password";

                //Response.Redirect("EnhancedCreateUserWizard.aspx?status=done2&user="+ trimmedUserName);
                //string prompt = "<script>$(document).ready(function(){{$.prompt('{0}');}});</script>";
                //string message = string.Format(prompt, "The company number cannot be part of the password");
                //ClientScript.RegisterStartupScript(typeof(Page), "message", message);
                e.Cancel = true;
                LabelDetails.Text = "The company number cannot be part of the password";
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("EnhancedCreateUserWizard.aspx");
        }
    }
}