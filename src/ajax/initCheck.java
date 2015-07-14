package ajax;
 
import java.util.Date;
import java.util.List;
import java.util.Map;
import action.BaseAction;
 
/**
 * 取教學評量
 * @author John
 */
public class initCheck extends BaseAction{
	
	private String coansw;
	
	

	public String getCoansw() {
		return coansw;
	}



	public void setCoansw(String coansw) {
		this.coansw = coansw;
	}



	public String execute() {
		
		getCoanswReady();//Teaching evaluation
			
		
		
        return SUCCESS;
    } 
	
	//教學評量期間
	private void getCoanswReady(){		
		Date coansw_begin=(Date)getContext().getAttribute("date_coansw_begin");
		Date coansw_end=(Date)getContext().getAttribute("date_coansw_end");		
		Date now=new Date();
		//only for normal courses
		if(now.getTime()>=coansw_begin.getTime() && now.getTime()<coansw_end.getTime()){			
			setCoansw(df.sqlGetStr("SELECT COUNT(*)as cnt FROM Seld s, Dtime d WHERE d.techid IS NOT NULL AND " +
			"d.Sterm='"+getContext().getAttribute("school_term")+"' AND d.techid IS NOT NULL AND d.cscode!='50000' " +
			"AND s.coansw IS NULL AND d.Sterm='"+getContext().getAttribute("school_term")+"'AND s.Dtime_oid=d.Oid AND s.student_no='"+session.get("userid")+"'"));
		}
	}
	
	
}