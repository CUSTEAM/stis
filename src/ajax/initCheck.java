package ajax;
 
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import action.BaseAction;
 
/**
 * 取登入後卡螢幕的條件
 * @author John
 */
public class initCheck extends BaseAction{
	
	private String coansw;	
	private Map questMap;
	SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");	

	public Map getQuestMap() {
		return questMap;
	}

	public void setQuestMap(Map questMap) {
		this.questMap = questMap;
	}

	public String getCoansw() {
		return coansw;
	}

	public void setCoansw(String coansw) {
		this.coansw = coansw;
	}

	public String execute() {
		//教學評量
		if(request.getParameter("type").equals("coansw")){			
			getCoanswReady();//Teaching evaluation
		}
		//一般問卷
		if(request.getParameter("type").equals("quest")){			
			getQuestReady();
		}
		
		if(request.getParameter("type").equals("both")){
			getCoanswReady();//Teaching evaluation
			getQuestReady();
		}
        return SUCCESS;
    }	
	
	//教學評量期間
	private void getCoanswReady(){		
		setCoansw(df.sqlGetStr("SELECT COUNT(*)as cnt FROM Seld s, Dtime d WHERE d.techid IS NOT NULL AND " +
		"d.Sterm='"+getContext().getAttribute("school_term")+"' AND d.techid IS NOT NULL AND d.cscode!='50000' " +
		"AND s.coansw IS NULL AND d.Sterm='"+getContext().getAttribute("school_term")+
		"'AND s.Dtime_oid=d.Oid AND s.student_no='"+session.get("userid")+"'"));
	}
	
	private void getQuestReady(){	
		//確認該生是否有問卷沒填
		try{
			
			this.setQuestMap(df.sqlGetMap("SELECT reply FROM QUEST_RES q WHERE q.Qid="+
			getContext().getAttribute("QUESTOid")+" AND q.student_no='"+session.get("userid")+"'"));
		}catch(Exception e){
			this.setQuestMap(null);
		}
		
		
		//this.setQuestOid(getContext().getAttribute("QUESTOid").toString());
	}
	
}