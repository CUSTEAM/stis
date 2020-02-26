package action;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.servlet.http.Cookie;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import model.Message;
import model.Wwpass;
import model.Wwpasshist;


public class TalkLogin extends BaseAction{
	public String username, password, ipaddress, remoteaddress;
	public String execute(){
		
		
		return SUCCESS;
	}
	
	public String login() throws IOException{
		

		Message msg=new Message();
		if(username.trim().length()<3||password.length()<3){
			//資料不全			
			msg.setWarning("帳號或密碼未輸入完成!");
			savMessage(msg);
			getSession().invalidate();
			return SUCCESS;
		}
		
		//立即清除Cookie
		Cookie[] cookies = request.getCookies();
		if(cookies!=null)
		for(int i=0;i<cookies.length;i++){
			if(!cookies[i].getName().equals("loginusername")){
				cookies[i].setDomain(".cust.edu.tw");
				cookies[i].setPath("/");
		        cookies[i].setMaxAge(0);
		        cookies[i].setValue(null);
		        response.addCookie(cookies[i]);
			}          
        }		
    	DetachedCriteria c = DetachedCriteria.forClass(Wwpass.class);
		c.add(Restrictions.eq("username", username));
		c.add(Restrictions.eq("password", password));
		List<Wwpass>list=df.getHibernateDAO().getHibernateTemplate().findByCriteria(c);
		if(list.size()<1){
			c = DetachedCriteria.forClass(Wwpass.class);
			c.add(Restrictions.eq("freename", username));
			c.add(Restrictions.eq("password", password));
			list=df.getHibernateDAO().getHibernateTemplate().findByCriteria(c);
		}
		if(list.size()<1){			
			msg.setError("驗證失敗");
			savMessage(msg);
			return SUCCESS;
		}
		Wwpass user=(Wwpass)list.get(0);
		//將自訂帳號對應永久帳號
		username=user.getUsername();
		
		//寫身份cookie
		Cookie cookie = new Cookie("userid", request.getSession().getId()+username.hashCode());	    	
		cookie.setMaxAge(60*60*24*365); // 瀏覽器關閉失效   	
    	cookie.setDomain(".cust.edu.tw");
    	cookie.setPath("/");
    	response.addCookie(cookie);
    	
    	//寫session cookie id	    	
    	dm.exSql("UPDATE wwpass SET sessionid='"+
    	request.getSession().getId()+username.hashCode()+
    	"' WHERE username='"+username+"'");    	
    	
    	Wwpasshist w=new Wwpasshist();
		w.setIpaddress(ipaddress);		
		w.setRemoteaddress(remoteaddress);
		w.setUseragent(request.getHeader("User-Agent"));
		w.setUsername(username);
		w.setUptime(new Timestamp(new Date().getTime()));
    	//學生 (目前為學號驗證)
    	if(user.getPriority().equals("C")){
    		response.sendRedirect("/stis/StdReaction");//轉送至stis
    		return null;
    	}		
		//response.sendRedirect("/stis/TalkLogin");//轉送至stis
		return SUCCESS;
	}

}
