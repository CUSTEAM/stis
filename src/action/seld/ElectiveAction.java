package action.seld;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import model.Classes;
import model.Message;

import action.BaseAction;

public class ElectiveAction extends BaseAction{
	
	SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm");	
	String stdNo=getSession().getAttribute("userid").toString();
	
	Date now=new Date();	
	public String Dtime_oid;
	
	public String execute(){
		if(stdNo==null)return SUCCESS;
		Date now=new Date();
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm");		
		//重複用資訊,包含學生虛擬或實體年級、選課期間、「歷年」已選課程(本學期需動態取得)...等選課必要之固定資訊，只取一次存放。		
		Map schedule;
		
		if(getSession().getAttribute("schedule")==null){
			
			//一般生比照			
			if(getContext().getAttribute("school_term").equals("2")){
				//取得時間大於今天的所屬部制之日期設定
				schedule=df.sqlGetMap("SELECT s.* FROM Class c, SYS_CALENDAR_ELECTIVE s, stmd st WHERE " +
				"s.grade=c.Grade+1 AND st.depart_class=c.ClassNo AND c.schoolType=s.depart AND " +
				"st.student_no='"+stdNo+"' AND begin<'"+sf.format(now)+"' AND end>'"+sf.format(now)+"'");
				//下學期選下學期的課
				if(schedule!=null){
					if(schedule.get("term").equals("2")){
						schedule=df.sqlGetMap("SELECT s.*, c.ClassNo FROM Class c, SYS_CALENDAR_ELECTIVE s, stmd st WHERE " +
						"s.grade=c.Grade AND st.depart_class=c.ClassNo AND c.schoolType=s.depart AND " +
						"st.student_no='"+stdNo+"' AND begin<'"+sf.format(now)+"' AND end>'"+sf.format(now)+"'");
					}
				}								
			}else{
				schedule=df.sqlGetMap("SELECT s.*, c.ClassNo FROM Class c, SYS_CALENDAR_ELECTIVE s, stmd st WHERE " +
				"s.grade=c.Grade AND st.depart_class=c.ClassNo AND c.schoolType=s.depart AND " +
				"st.student_no='"+stdNo+"' AND begin<'"+sf.format(now)+"' AND end>'"+sf.format(now)+"'");
			}
			
			if(schedule!=null){	
				//取班級
				Classes clazz=(Classes) df.hqlGetListBy("FROM Classes WHERE ClassNo='"+df.sqlGetStr("SELECT depart_class FROM stmd WHERE student_no='"+stdNo+"'")+"'").get(0);
				
				if(clazz.getSchNo().equals("M")){
					//TODO 研究生比照
					schedule.put("max", 15);
					schedule.put("min", 1);
					schedule.put("nor", 10);
					//level=階段
				}
				
				getSession().setAttribute("schedule", schedule);
				
				//當下學期而且不為第3階段時虛擬升級
				if(getContext().getAttribute("school_term").equals("2")&&!schedule.get("level").equals("3")){
					try{
						clazz=(Classes) df.hqlGetListBy("FROM Classes WHERE CampusNo='"+clazz.getCampusNo()+"' AND SchoolNo='"+clazz.getSchoolNo()+"' AND DeptNo='"+clazz.getDeptNo()+"' AND Grade='"+(clazz.getGrade()+1)+"' AND SeqNo='"+clazz.getSeqNo()+"'").get(0);
					}catch(Exception e){
						e.printStackTrace();
						Message msg=new Message();
						msg.setError("沒有班級可供升級");
						this.savMessage(msg);
					}
				}
				getSession().setAttribute("myGrade", clazz);

				//特殊班級改寫通識上限
				List<Map>seldnor=df.sqlGet("SELECT depart_class, max FROM SeldMaxNor");
				for(int i=0; i<seldnor.size(); i++){				
					if(clazz.getClassNo().indexOf(seldnor.get(i).get("depart_class").toString())>=0){
						schedule.put("nor", seldnor.get(i).get("max"));
					}
				}
				
				//擋修課程				
				//getSession().setAttribute("cshist", df.sqlGet("SELECT cscode FROM ScoreHist WHERE student_no='"+stdNo+"' AND score>=60"));//歷年已修課程代碼
				List<Map>cs=df.sqlGet("SELECT cscode FROM ScoreHist WHERE student_no='"+stdNo+"' AND (score>=60||evgr_type='6')");
				List<Map>b=(List)getContext().getAttribute("dtimeBlock");
				List<Map>bc;
				List block=new ArrayList();				
				int cnt;
				for(int i=0; i<b.size();i++){
					bc=(List)b.get(i).get("cscodes");
					cnt=bc.size();			
					for(int j=0;j<bc.size();j++){
						
						for(int k=0; k<cs.size();k++){					
							if(cs.get(k).get("cscode").equals(bc.get(j).get("cscode"))){
								cnt--;						
							}
						}
					}					
					if(cnt>0){
						block.add(b.get(i).get("Dtime_oid"));
					}
				}
				getSession().setAttribute("block", block);//擋修清單
			}
		
		}else{
			//有資訊則重用
			schedule=(Map)getSession().getAttribute("schedule");
		}
		
		//不重複用資訊，需動態更新資訊
		if(schedule!=null){//若有規則給予選課
			//更新已選課程	
			request.setAttribute("myClass", df.sqlGet("SELECT cdo.sname as opt, dc.Oid as dcOid, d.thour, d.credit, " +
			"d.Oid as dtOid, d.techid, e.cname, c.cscode, c.chi_name,dc.*, cl.ClassName, d.nonSeld, d.depart_class as ClassNo FROM stmd st, " +
			"Seld s, (Dtime d LEFT OUTER JOIN empl e ON d.techid=e.idno), Dtime_class dc, CODE_DTIME_OPT cdo," +
			"Csno c, Class cl WHERE cdo.id=d.opt AND d.depart_class=cl.ClassNo AND st.student_no=s.student_no AND s.Dtime_oid=d.Oid AND " +
			"c.cscode=d.cscode AND d.Oid=dc.Dtime_oid AND d.Sterm='"+schedule.get("term")+"' AND s.student_no='"+stdNo+"'"));
			
			//更新已選資訊
			Map map=df.sqlGetMap("SELECT SUM(d.credit)as credit, SUM(d.thour)as thour FROM Dtime d, Seld s WHERE " +
			"d.Oid=s.Dtime_oid AND s.student_no='"+stdNo+"' AND d.Sterm='"+schedule.get("term")+"'");			
			request.setAttribute("mycredit", map.get("credit"));
			request.setAttribute("mythour", map.get("thour"));	
		}
		return SUCCESS;
	}
	
	/**
	 * 加選
	 * @return
	 */
	public String add(){
		
		Message msg=new Message();		
		Map dtime=df.sqlGetMap("SELECT cscode, credit, opt, depart_class FROM Dtime WHERE Oid="+Dtime_oid);
		
		//第1階段後要檢查人數上限「多人同時搶選、已在頁面上「亂數延遲」解決
		if(!((Map)getSession().getAttribute("schedule")).get("level").equals("1")){			
			if(df.sqlGetInt("SELECT COUNT(*)FROM Seld WHERE Dtime_oid='"+Dtime_oid+"'")>=
				df.sqlGetInt("SELECT Select_Limit FROM Dtime WHERE Oid='"+Dtime_oid+"'")){
				msg.setError("選課人數已滿");
				savMessage(msg);
				return execute();
			}			
		}
		
		//上限
		float credit=Float.parseFloat(dtime.get("credit").toString());	//Float.parseFloat(	

		//通識上限
		if(dtime.get("opt").equals("3"))
		try{
			
			float max=Float.parseFloat(((Map)getSession().getAttribute("schedule")).get("nor").toString());				
			if((Float.parseFloat(df.sqlGetStr("SELECT SUM(d.credit)FROM Seld s, Dtime d WHERE " +
				"s.student_no='"+stdNo+"' AND d.opt='3' AND "+
				"d.Oid=s.Dtime_oid AND d.Sterm='"+((Map)getSession().getAttribute("schedule")).get("term")+"'"))+credit)>max){
				msg.setError("通識課程學分數超過上限");
				savMessage(msg);
				return execute();
			}
		}catch(Exception e){
			//TODO 預選課程為0者
		}
		
		try{
			float max=Float.parseFloat(((Map)getSession().getAttribute("schedule")).get("max").toString());				
			if((Float.parseFloat(df.sqlGetStr("SELECT SUM(d.credit)FROM Seld s, Dtime d WHERE s.student_no='"+stdNo+"' AND "+
				"d.Oid=s.Dtime_oid AND d.Sterm='"+((Map)getSession().getAttribute("schedule")).get("term")+"'"))+credit)>max){
				msg.setError("學分數超過上限");
				savMessage(msg);
				return execute();
			}
		}catch(Exception e){
			//TODO 預選課程為0者
		}

		//重複選課
		if(df.sqlGetInt("SELECT COUNT(*) FROM Dtime d, Seld s WHERE d.cscode='"+
		dtime.get("cscode")+"' AND s.student_no='"+stdNo+"'"+
		" AND d.Oid=s.Dtime_oid AND d.Sterm='"+((Map)getSession().getAttribute("schedule")).get("term")+"'")>0){
			msg.setError("本學期已選相同課程");
			savMessage(msg);
			return execute();
		}

		//重複修課、擋修
		//List<Map>cshist=(List)getSession().getAttribute("cshist");
		//List<Map>block=(List)getContext().getAttribute("dtimeBlock");
		//List<Map>dclass;
		/*歷年可選課程已過濾
		for(int i=0; i<cshist.size(); i++){
			if((cshist.get(i)).get("cscode").equals(dtime.get("cscode"))){
				msg.setError("歷年成績已存在相同課程");
				savMessage(msg);
				return SUCCESS;
			}
		}
		*/
		List block=(List)getSession().getAttribute("block");
		for(int i=0; i<block.size(); i++){
			if(Dtime_oid.equals(block.get(i).toString())){
				msg.setError("未取得先修課程");
				savMessage(msg);
				return execute();
			}
		}
		
		//衝堂
		List<Map>dclass=df.sqlGet("SELECT week, begin, end FROM Dtime_class WHERE Dtime_oid='"+Dtime_oid+"'");
		for(int i=0; i<dclass.size(); i++){
			if(df.sqlGetInt("SELECT COUNT(*) "+
				"FROM Seld s, Dtime_class ds, Dtime d, Csno c, Class cs1, Class cs2, stmd st "+
				"WHERE s.Dtime_oid=d.Oid AND ds.Dtime_oid=s.Dtime_oid AND s.student_no='"+stdNo+"' AND sterm='"+((Map)getSession().getAttribute("schedule")).get("term")+"' AND "+
				"c.cscode=d.cscode AND d.depart_class=cs1.ClassNo AND st.depart_class=cs2.ClassNo AND st.student_no=s.student_no AND " +
				"d.Oid<>"+Dtime_oid+" AND ds.week='"+dclass.get(i).get("week")+"' AND (ds.begin <="+dclass.get(i).get("end")+" AND ds.end >="+dclass.get(i).get("begin")+"" +")")>0){
				msg.setError("上課時段重複");
				savMessage(msg);
				return execute();
			}
		}
		
		//儲存
		try{
			df.exSql("INSERT INTO Seld(Dtime_oid, student_no)VALUES('"+Dtime_oid+"', '"+stdNo+"')");
			df.exSql("INSERT INTO SeldHist(type,StudentNo,depart_class,cscode)SELECT 'A','"+stdNo+"', depart_class, cscode FROM Dtime WHERE Oid="+Dtime_oid);
		}catch(Exception e){
			msg.setError("選課不成功");
			savMessage(msg);
			return execute();
		}
		msg.setSuccess("加選課程編號"+Dtime_oid);
		savMessage(msg);
		return execute();
	}
	
	/**
	 * 退選
	 * @return
	 */
	public String del(){
		Map dtime;
		dtime=df.sqlGetMap("SELECT d.nonSeld, d.credit, d.opt, d.depart_class, s.sel_min FROM Dtime d, Class c, "
		+ "SYS_CALENDAR_ELECTIVE s WHERE c.ClassNo=d.depart_class AND s.grade=c.Grade AND c.SchoolType=s.depart AND d.Oid="+Dtime_oid);
		
		float min=Float.parseFloat(((Map) getSession().getAttribute("schedule")).get("min").toString());
		float credit=Float.parseFloat(dtime.get("credit").toString());		
		int StdSelect = df.sqlGetInt("Select COUNT(e.`Oid`) From Seld e Where e.`Dtime_oid`='"+Dtime_oid+"' ");//取選課人數
		
		Message msg = new Message();
		
		//退本班必修在頁面已預做處理
		if(dtime.get("opt").equals("1")){
			if(((Classes)getSession().getAttribute("myGrade")).getClassNo().equals(dtime.get("depart_class"))){
				msg.setError("退選本班必修課程需經各系認可後由課務單位處理, ");
				savMessage(msg);
				return execute();
			}				
		}
		
		//退併班在頁面已預做處理
		if(dtime.get("nonSeld").equals("1")){			
			msg.setError("退選本課程需經各系認可後由課務單位處理, ");
			savMessage(msg);
			return execute();							
		}
		
		if(((df.sqlGetInt("SELECT SUM(d.credit)FROM Seld s, Dtime d WHERE s.student_no='"+stdNo+"' AND "+
			"d.Oid=s.Dtime_oid AND d.Sterm='"+((Map) getSession().getAttribute("schedule")).get("term")+"'")-credit)<min)){//退下限		
			msg.setError("學分數需符合下限規定, ");				
			savMessage(msg);
			return execute();
		}
		
		//第1階段不卡下限
		if(!((Map)getSession().getAttribute("schedule")).get("level").equals("1")){
			if(!dtime.get("depart_class").toString().substring(2, 3).equals("G")){//碩班
				
				if(StdSelect<=Integer.parseInt(dtime.get("sel_min").toString())){
					msg.setError("選課人數低於下限, ");
					savMessage(msg);
					return execute();
				}				
			}else{
				if(StdSelect<=5){
					msg.setError("選課人數低於下限, ");
					savMessage(msg);
					return execute();
				}				
			}
		}
		
		df.exSql("DELETE FROM Seld WHERE Dtime_oid='"+Dtime_oid+"' AND student_no='"+stdNo+"'");
		df.exSql("INSERT INTO SeldHist(type,StudentNo,depart_class,cscode)SELECT 'D','"+stdNo+"', depart_class, cscode FROM Dtime WHERE Oid="+Dtime_oid);
		msg.setSuccess("退選課程編號"+Dtime_oid);
		savMessage(msg);
		return execute();
	}

}
