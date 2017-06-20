package action.coansw;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import action.BaseAction;

public class Coansw extends BaseAction{
	
	public String DtimeOid;
	public String SeldOid;
	public Integer ans[];
	public String bug[];
	public String Oid[];
	
	public String execute(){		
		List<Map>css=df.sqlGet("SELECT s.Oid as SeldOid, d.Oid, c.chi_name, e.cname, d.elearning FROM Dtime d, Seld s, empl e, Csno c WHERE "
		+ "d.techid IS NOT NULL AND d.cscode!='50000'AND c.cscode=d.cscode AND s.coansw IS NULL AND d.Oid=s.Dtime_oid AND d.techid=e.idno AND "
		+ "s.student_no='"+getSession().getAttribute("userid")+"'AND d.Sterm='"+getContext().getAttribute("school_term")+"'");
		if(css.size()<1){
			return SUCCESS;
		}
		Map cs=css.get(0);		
		//questions of step
		Map pec=new HashMap();
		pec.put("total", df.sqlGetStr("SELECT COUNT(*) FROM Seld s, Dtime d WHERE d.techid IS NOT NULL AND d.cscode!='50000'AND s.Dtime_oid=d.Oid AND s.student_no='"+getSession().getAttribute("userid")+"'AND d.Sterm='"+getContext().getAttribute("school_term")+"'"));
		pec.put("edited", css.size());
		request.setAttribute("pec", pec);
		
		if(!cs.get("elearning").equals("0")){//check courses for elearning
			cs.put("question", df.sqlGet("SELECT * FROM Question q WHERE q.topic='2'"));//elearning
		}else{
			cs.put("question", df.sqlGet("SELECT * FROM Question q WHERE q.topic='1'"));//normal
		}			
		request.setAttribute("cs", cs);
		return SUCCESS;
	}
	
	public String save(){	
		if(df.sqlGetStr("SELECT coansw FROM Seld WHERE Oid="+SeldOid)!=null){
			//System.out.println("重複");
			return execute();//重複問卷
		}
		StringBuilder str=new StringBuilder();
		int sum=0, qs=0;
		for(int i=0; i<ans.length; i++){
			if(ans[i]==null){
				request.setAttribute("msg", "填寫不完整");
				return execute();//any field is empty
			}
			if(bug[i].isEmpty()){//非偵錯題
				qs+=1;//題數++
				sum+=ans[i];//總計
			}
			str.append(ans[i]);			
		}
		
		if(check()){//check for valid	
			//樣本數+1,有效問卷+1,總分+=sum/qs
			df.exSql("UPDATE Dtime SET samples=samples+1, effsamples=effsamples+1, coansw=coansw+"+((float)sum/qs)+" WHERE Oid="+DtimeOid);				
		}else{
			request.setAttribute("msg", "問卷無效, 請注意偵錯題");
			df.exSql("UPDATE Dtime SET samples=samples+1 WHERE Oid="+DtimeOid);
			//return execute();//阻擋無效回卷
		}
		
		
		
		
		
		df.exSql("UPDATE Seld SET coansw='"+str+"' WHERE Oid="+SeldOid);
		return execute();
	}
	
	/**
	 * 判斷有效問卷
	 * TODO 變更機制時，需同時修改tis及csis
	 */
	private boolean check(){		
		int abs, tmp;
		StringBuilder sb=new StringBuilder();
		boolean b=true;
		for(int i=0; i<Oid.length; i++){	
			//以偵錯題對應RUN
			if(!bug[i].equals("")){//[i]為偵錯題				
				//判斷偵錯RUN
				for(int j=0; j<Oid.length; j++){					
					if(Oid[j].equals(bug[i])){
						if(ans[i]!=3 && ans[j]!=3){
							abs=Math.abs(ans[i]-ans[j]);
							if(abs<1)b=false;
						}						
					}
				}
			}else{
				sb.append(ans[i]);//非偵錯題累加以再次偵錯1115,2225
			}
		}
		
		//動態建立再次偵錯模版
		String str1=new String(), str2=new String();
		for(int i=0; i<sb.length(); i++){
			str1+="1";//模板內值全部為1
			//str2+="2";//模板內值全部為2
		}
		if(sb.toString().equals(str1)||sb.toString().equals(str2))b=false;
		//System.out.println(b+":"+sb);
		return b;
	}
}