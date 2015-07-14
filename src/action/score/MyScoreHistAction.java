package action.score;

import java.util.List;
import java.util.Map;
import action.BaseAction;

public class MyScoreHistAction extends BaseAction{
	
	public String execute(){
		
		String stdNo=(String)getSession().getAttribute("userid");
		
		//證照資訊
		request.setAttribute("skill", df.sqlGet("SELECT l.DeptName, l.Name, l.level, s.SchoolYear, s.SchoolTerm  FROM StdSkill s LEFT "
		+ "OUTER JOIN LicenseCode l ON s.LicenseCode=l.Code WHERE s.StudentNo='"+stdNo+"'"));
		
		//班級資訊
		Map<String,String>myClass=df.sqlGetMap("SELECT c.* FROM stmd s, Class c WHERE s.depart_class=c.ClassNo AND s.student_no='"+stdNo+"'");
		
		//及格標準
		int pa=60;
		try{if(myClass.get("SchNo").equals("M")){pa=70;}}catch(Exception e){}			
		
		//修課年期間含名次
		List<Map>scoreHist=df.sqlGet("SELECT st.rank, SUM(IF(sc.opt=1&&sc.score>=60||(sc.evgr_type='6'&&sc.opt=1),sc.credit,0))as c1," +
		"SUM(IF(sc.opt=2&&sc.score>=60||(sc.evgr_type='6'&&sc.opt=2),sc.credit,0))as c2,SUM(sc.credit)as tc," +
		"SUM(IF(sc.opt=3&&sc.score>=60||(sc.evgr_type='6'&&sc.opt=3),sc.credit,0))as c3,SUM(sc.credit)as ac," +
		"SUM(IF(sc.score>=60||(sc.evgr_type='6'),sc.credit,0))as pc, sc.school_term,sc.school_year FROM " +
		"ScoreHist sc LEFT OUTER JOIN Stavg st ON sc.school_year=st.school_year AND sc.school_term=st.school_term AND " +
		"sc.student_no=st.student_no WHERE sc.student_no='"+stdNo+"'GROUP BY sc.school_year, sc.school_term " +
		"ORDER BY sc.school_year DESC,sc.school_term DESC");
		
		for(int i=0; i<scoreHist.size(); i++){	
			//成績
			scoreHist.get(i).put("hist", df.sqlGet("SELECT cl.ClassName, e.name as evgrName, o.name as OptName, cs.chi_name, " +
			"cs.cscode, sh.opt, sh.credit, sh.score FROM ScoreHist sh LEFT OUTER JOIN Class cl ON sh.stdepart_class=cl.ClassNo, CODE_SCORE_EVGRTYPE e, " +
			"Csno cs, CODE_DTIME_OPT o WHERE sh.evgr_type=e.id AND o.id=sh.opt AND cs.cscode=sh.cscode AND sh.student_no='"+
			stdNo+"' AND sh.school_year='"+scoreHist.get(i).get("school_year")+"' AND sh.school_term='"+scoreHist.get(i).get("school_term")+"' ORDER BY sh.school_term, sh.opt"));
			
			//獎懲
			scoreHist.get(i).put("desd", df.sqlGet("SELECT c.ddate,d.name as name1, c.cnt1, d1.name as name2, c.cnt2 FROM " +
			"(comb2 c LEFT OUTER JOIN CODE_DESD d ON c.kind1=d.id)LEFT OUTER JOIN CODE_DESD d1 ON c.kind2=d1.id " +
			"WHERE c.student_no='"+stdNo+"' AND c.school_year='"+scoreHist.get(i).get("school_year")+"' AND c.school_term='"+scoreHist.get(i).get("school_term")+"'"));
			try{
				scoreHist.get(i).put("noabsent", df.sqlGetStr("SELECT noabsent FROM cond WHERE student_no='"+stdNo+"' AND school_year='"+scoreHist.get(i).get("school_year")+"' AND school_term='"+scoreHist.get(i).get("school_term")+"'"));
			}catch(Exception e){
				scoreHist.get(i).put("noabsent", "");
			}
			
		}
		
		//本學期:扣考status:1
		List<Map>seld=df.sqlGet("SELECT sh.status, sh.score1 as realScore1, sh.score2 as realScore2, sh.score as realScore,IF(sh.status='1', 0,sh.score)as score,c.CampusNo,c.SchoolType,c.ClassNo,c.graduate, d.cscode,d.thour,o.name as OptName," +
		"cs.chi_name,d.opt,d.credit,c.ClassName,IF(sh.status='1', 0,sh.score1)as score1,IF(sh.status='1', 0,sh.score2)as score2,IF(sh.status='1', 0,sh.score3)as score3 " +
		"FROM Class c, Seld sh,Csno cs,CODE_DTIME_OPT o,Dtime d WHERE d.Sterm='"+getContext().getAttribute("school_term")+"'AND c.ClassNo=d.depart_class AND o.id=d.opt AND " +
		"d.Oid=sh.Dtime_oid AND cs.cscode=d.cscode AND sh.student_no='"+stdNo+"'AND d.cscode!='50000'");
		
		//List<Map>sch=df.sqlGet("SELECT * FROM SYS_SCORE_SCHEDULE s");
		
		//String level;
		for(int i=0; i<seld.size();i++){			
			seld.get(i).put("v1", getContext().getAttribute("exam_mid"));
			if(getContext().getAttribute("school_term").equals("2")){				
				if(seld.get(i).get("graduate").equals("1")){
					seld.get(i).put("v2", getContext().getAttribute("exam_grad"));
				}else{
					seld.get(i).put("v2", getContext().getAttribute("exam_fin"));
				}				
			}else{
				seld.get(i).put("v2", getContext().getAttribute("exam_fin"));
			}			
					
		}
		
		
		request.setAttribute("seld", seld);		
		request.setAttribute("pa", pa);
		request.setAttribute("scoreHist", scoreHist);
		//本學期獎懲
		request.setAttribute("desds", df.sqlGet("SELECT c.ddate,d.name as name1, c.cnt1, d1.name as name2, c.cnt2 FROM" +
		"(desd c LEFT OUTER JOIN CODE_DESD d ON c.kind1=d.id)LEFT OUTER JOIN CODE_DESD d1 ON c.kind2=d1.id WHERE c.student_no='"+stdNo+"'"));
		return SUCCESS;
	}
}