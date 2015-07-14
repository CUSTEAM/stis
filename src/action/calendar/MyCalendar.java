package action.calendar;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import model.Message;
import action.BaseAction;

public class MyCalendar extends BaseAction{
	
	public String execute() throws Exception {
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");		
		SimpleDateFormat ssf=new SimpleDateFormat("M月d日");	
		
		Date now=new Date();
		
		//處理日期		
		if(request.getParameter("weekday")!=null){
			now=sf.parse(request.getParameter("weekday"));	
		}
		
		Calendar ca=Calendar.getInstance();		
		ca.setTime(now);
		if(ca.get(Calendar.DAY_OF_WEEK)==1){
			ca.add(Calendar.DAY_OF_YEAR, -1);
		}
		
		ca.set(Calendar.DAY_OF_WEEK, 1);		
		String weekday[]=new String[9];
		String viewday[]=new String[9];
		for(int i=0; i<weekday.length; i++){
			weekday[i]=sf.format(ca.getTime());
			viewday[i]=ssf.format(ca.getTime());
			ca.add(Calendar.DAY_OF_YEAR, 1);
		}		
		request.setAttribute("weekday", weekday);
		request.setAttribute("viewday", viewday);		
		
		//此次作業中不會變動的常態資訊
		if(session.get("allClass")==null){
			session.put("now", sf.parse(sf.format(now)));			
			session.put("allClass", sam.getCsTable(getSession().getAttribute("userid").toString(), 
			getContext().getAttribute("school_term").toString()));
		}
		
		String bs[];		
		List abs=df.sqlGet("SELECT d.*, da.result FROM Dilg d LEFT OUTER JOIN Dilg_apply da ON d.Dilg_app_oid=da.Oid WHERE " +
		"d.student_no='"+getSession().getAttribute("userid")+"' AND " +
		"d.date<='"+weekday[7]+"' AND d.date>='"+weekday[1]+"'");
		
		for(int i=0; i<abs.size(); i++){
			bs=new String[16];
			for(int j=1; j<=15; j++){				
				if(((Map)abs.get(i)).get("abs"+j)!=null){
										
					bs[j]=((Map)abs.get(i)).get("abs"+j).toString();
				}else{
					bs[j]="";
				}
			}			
			((Map)abs.get(i)).put("bs", bs);			
		}
		
		request.setAttribute("abs", abs);
		return "intro";
		
	}
}