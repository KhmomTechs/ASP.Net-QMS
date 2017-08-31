using System.Security.Principal;

public class CustomPrincipal : IPrincipal
{
    private readonly CustomIdentity _identity;

    public CustomPrincipal(CustomIdentity identity)
    {
        _identity = identity;
    }

    public IIdentity Identity
    {
        get { return _identity; }
    }

    public bool IsInRole(string role)
    {
        return false;
    }
}