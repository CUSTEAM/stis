package action.calendar;

import java.util.List;
import java.util.Map;
import action.BaseAction;

public class MyDilgDetail extends BaseAction{
	
	public String execute(){
		
		
		List list=df.sqlGet("SELECT e.cname, d.Oid, c.chi_name, d.opt, d.credit, d.thour, s.status, IFNULL(s.elearn_dilg, 0)as elearn_dilg," +
		"(SELECT COUNT(*)FROM Dilg WHERE Dilg.student_no='"+getSession().getAttribute("userid")+"' AND Dilg.Dtime_oid=d.Oid AND abs NOT IN" +
		"(SELECT id FROM Dilg_rules WHERE exam='0'))as dilg_period FROM Dtime d LEFT OUTER JOIN empl e ON d.techid=e.idno, Csno c, Seld s WHERE " +
		"d.cscode=c.cscode AND s.Dtime_oid=d.Oid AND s.student_no='"+getSession().getAttribute("userid")+"' AND d.Sterm='"+getContext().getAttribute("school_term")+"'");		
		for(int i=0; i<list.size(); i++){			
			((Map)list.get(i)).put("dilgs", df.sqlGet("SELECT da.result, d.*, dr.name FROM Dilg d LEFT OUTER JOIN Dilg_apply da ON d.Dilg_app_oid=da.Oid, Dilg_rules dr WHERE d.student_no='"+
			getSession().getAttribute("userid")+"'AND dr.id=d.abs AND d.Dtime_oid="+((Map)list.get(i)).get("Oid")));			
		}		
		
		//個人缺曠資料
		request.setAttribute("info", sam.StudentDilg((String)getSession().getAttribute("userid")));
		
		
		list=sam.getDilgDetail(getSession().getAttribute("userid").toString(), getContext().getAttribute("school_term").toString());
		request.setAttribute("cs", list);		
		return this.SUCCESS;
	}

}
