package action;

public class Logout extends BaseAction{
	
	//sso logout
	public String execute() throws Exception {		
		getSession().invalidate();
		response.sendRedirect("/ssos/Logout");//轉送至eis
		return null;
	}
}
