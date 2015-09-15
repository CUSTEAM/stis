package ajax.seld;

import java.util.List;
import java.util.Map;

import model.Classes;
import action.BaseAction;

public class getCourse extends BaseAction{
	
	private List result;
	
	public List getResult() {
		return result;
	}

	public void setResult(List result) {
		this.result = result;
	}

	public String execute(){
		
		Classes c=(Classes) getSession().getAttribute("myGrade");//初入時已計算的實體或虛擬年級資訊		
		List list=df.sqlGet("SELECT Select_Limit, (SELECT COUNT(*)FROM Seld WHERE Dtime_oid=d.Oid) as seled, " +
		"cl.ClassName, cd.name as optName, d.credit, d.thour, d.elearning, d.nonSeld," +
		"d.Oid, c.chi_name, dc.week, dc.begin, dc.end, e.cname FROM CODE_DTIME_OPT cd," +
		"Dtime d, empl e, Dtime_class dc, Dtime_cross o, Csno c, Class cl " +
		"WHERE cd.id=d.opt AND cl.ClassNo=d.depart_class AND c.cscode=d.cscode AND e.idno=d.techid AND d.Select_Limit>0 AND " +
		"d.Oid=dc.Dtime_oid AND o.Dtime_oid=d.Oid AND " +
		"d.Sterm='"+request.getParameter("term")+"' AND " +
		"(o.Cidno='"+c.getCampusNo()+"' OR o.Cidno='*') AND " +
		"(o.Sidno='"+c.getSchoolNo()+"' OR o.Sidno='*') AND " +
		"(o.Didno='"+c.getDeptNo()+"' OR o.Didno='*') AND " +
		"(o.Grade<="+c.getGrade()+" OR o.Grade='*')AND " +
		"d.cscode NOT IN(SELECT cscode FROM ScoreHist WHERE student_no='" +getSession().getAttribute("userid")+"' AND score>=60) AND "+
		"dc.week='"+request.getParameter("week")+"' AND " +
		"(dc.end>="+request.getParameter("begin")+ " AND dc.begin<="+request.getParameter("begin")+") AND d.cscode!='50000' GROUP BY d.Oid");
		
		//重修低年級課程	
		list.addAll(df.sqlGet("SELECT Select_Limit, (SELECT COUNT(*)FROM Seld WHERE Dtime_oid=d.Oid) as seled, " +
		"cl.ClassName, cd.name as optName, d.credit, d.thour, d.elearning, d.nonSeld," +
		"d.Oid, c.chi_name, dc.week, dc.begin, dc.end, e.cname FROM CODE_DTIME_OPT cd, Dtime d, empl e, " +
		"Dtime_class dc, Csno c, Class cl WHERE cd.id=d.opt AND d.Sterm='"+request.getParameter("term")+"' AND cl.ClassNo=d.depart_class AND " +
		"c.cscode=d.cscode AND e.idno=d.techid AND d.Oid=dc.Dtime_oid AND d.Select_Limit>0 AND " +
		"(cl.CampusNo='"+c.getCampusNo()+"')AND " +
		"(cl.SchoolNo='"+c.getSchoolNo()+"')AND " +
		"(cl.DeptNo='"+c.getDeptNo()+"')AND " +
		"(cl.Grade<="+c.getGrade()+")AND " +
		"d.cscode NOT IN(SELECT cscode FROM ScoreHist WHERE student_no='" +getSession().getAttribute("userid")+"' AND score>=60) AND "+
		"dc.week='"+request.getParameter("week")+"' AND " +
		"(dc.end>="+request.getParameter("begin")+ " AND dc.begin<="+request.getParameter("begin")+") AND d.cscode!='50000' GROUP BY d.Oid"));
		
		setResult(list);
		return SUCCESS;
	}

}
