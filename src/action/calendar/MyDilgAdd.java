package action.calendar;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import model.Message;
import action.BaseAction;

public class MyDilgAdd extends BaseAction{
	
	public String execute() throws ParseException{
		String student_no=(String)getSession().getAttribute("userid");
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
		Calendar c=Calendar.getInstance();
		c.setTime(new Date());
		c.add(Calendar.DAY_OF_YEAR, -8);
		
		request.setAttribute("abs", df.sqlGet("SELECT c.chi_name, d.* FROM " +
				"Dilg d LEFT OUTER JOIN Dilg_apply da ON d.Dilg_app_oid=da.Oid, " +
				"Dtime dt, Csno c WHERE d.abs='2' AND dt.cscode=c.cscode AND " +
				"d.Dtime_oid=dt.Oid AND d.date>='"+sf.format(c.getTime())+"' AND " +
				"d.student_no='"+student_no+"' ORDER BY date, cls DESC"));
		
		request.setAttribute("noabs", df.sqlGet("SELECT c.chi_name, d.* FROM " +
				"Dilg d LEFT OUTER JOIN Dilg_apply da ON d.Dilg_app_oid=da.Oid, " +
				"Dtime dt, Csno c WHERE d.abs='2' AND dt.cscode=c.cscode AND " +
				"d.Dtime_oid=dt.Oid AND d.date<'"+sf.format(c.getTime())+"' AND " +
				"d.student_no='"+student_no+"' ORDER BY date, cls DESC"));
		
		request.setAttribute("apps", getApp(student_no));
		
		
		return "intro";
	}
	
	
	
	/**
	 * 取假單
	 * @return
	 * @throws ParseException 
	 */
	private List getApp(String student_no) throws ParseException{
		
		List<Map>tmp;
		List<Map>list=df.sqlGet("SELECT dr.name as absName, da.*, e.cname FROM Dilg_rules dr, Dilg_apply da LEFT OUTER JOIN empl e ON " +
		"e.idno=da.auditor WHERE dr.id=da.abs AND da.student_no='"+student_no+"' ORDER BY da.Oid DESC");
		
		Date now=new Date();
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
		boolean over;
		
		for(int i=0; i<list.size(); i++){
			over=false;
			tmp=df.sqlGet("SELECT d.* FROM Dilg_apply da, Dilg d WHERE d.Dilg_app_oid=da.Oid AND da.student_no='"+student_no+"' AND da.Oid="+list.get(i).get("Oid"));
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
		return list;
	}
	
	
	
	public String date[];
	public String Oid[];
	public String cls[];
	
	public String addDilg() throws ParseException{
		
		List list=new ArrayList();
		Map map;
		
		if(Oid==null){
			Message m=new Message();
			m.setError("未選擇節次");
			this.savMessage(m);
			return execute();
		}
		
		for(int i=0; i<Oid.length; i++){
			if(!Oid[i].equals("")){
				map=new HashMap();			
				map.put("date", date[i]);
				map.put("cls", cls[i]);
				map.put("Oid", Oid[i]);
				list.add(map);
			}
			
		}
		if(list.size()<1){
			Message m=new Message();
			m.setError("未選擇節次");
			this.savMessage(m);
			return execute();
		}
		
		request.setAttribute("dilgs", list);
		
		return "add";
	}
	
}
