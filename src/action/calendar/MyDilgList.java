package action.calendar;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import action.BaseAction;

public class MyDilgList extends BaseAction{
	
	public String execute() throws Exception {
		List<Map>tmp;
		List<Map>list=df.sqlGet("SELECT da.*, e.cname FROM Dilg_apply da LEFT OUTER JOIN empl e ON " +
		"e.idno=da.auditor WHERE da.student_no='"+(String)getSession().getAttribute("userid")+"' ORDER BY da.Oid DESC");
		
		Date now=new Date();
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
		boolean over;
		
		for(int i=0; i<list.size(); i++){			
			
			over=false;		
			
			tmp=df.sqlGet("SELECT d.* FROM Dilg_apply da, Dilg d WHERE d.Dilg_app_oid=da.Oid AND da.student_no='"+getSession().getAttribute("userid")+"' " +
			"AND da.Oid="+list.get(i).get("Oid"));
			
			list.get(i).put("ds", tmp);
			
			if(!over){
				for(int j=0; j<tmp.size(); j++){					
					if(sf.parse(tmp.get(j).get("date").toString()).getTime()<=now.getTime()){
						over=true;
					}
				}
			}
			
			list.get(i).put("over", over);
		}
		request.setAttribute("dilgs", list);
		return SUCCESS;
	}

}