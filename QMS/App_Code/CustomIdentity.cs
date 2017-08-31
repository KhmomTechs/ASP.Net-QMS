using System.Security.Principal;
using System.Web.Security;

public class CustomIdentity : IIdentity
{
    private readonly FormsAuthenticationTicket _ticket;

    public CustomIdentity(FormsAuthenticationTicket ticket)
    {
        _ticket = ticket;
    }

    public FormsAuthenticationTicket Ticket
    {
        get { return _ticket; }
    }

    public string CompanyName
    {
        get
        {
            var userDataPieces = Ticket.UserData.Split("|".ToCharArray());
            return userDataPieces[0];
        }
    }

    public string Title
    {
        get
        {
            var userDataPieces = Ticket.UserData.Split("|".ToCharArray());
            return userDataPieces[1];
        }
    }


    public string AuthenticationType
    {
        get { return "Custom"; }
    }

    public bool IsAuthenticated
    {
        get { return true; }
    }

    public string Name
    {
        get { return Ticket.Name; }
    }
}