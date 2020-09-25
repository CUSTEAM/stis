package action.eps;

import java.util.List;
import java.util.Map;

import action.BaseAction;
import model.stmd_info;

public class StdInfoEditorAction extends BaseAction{
	
	public String execute() {
		Map si=df.sqlGetMap("SELECT*FROM stmd_info WHERE student_no='"+getSession().getAttribute("userid")+"'");
		request.setAttribute("si", si);
				
		return SUCCESS;
	}
	
	public String Oid,
	student_no,
	AborigineCode,
	editime,
	AborigineCode_f,
	AborigineCode_m,
	FirstCollegeStd,
	Education_f,
	Education_m;
	
	
	public String save() {
		stmd_info si;
		if(Oid.equals("")) {
			si=new stmd_info();
		}else {
			si=(stmd_info)df.hqlGetListBy("FROM stmd_info WHERE student_no='"+getSession().getAttribute("userid")+"'").get(0);
		}
		si.setStudent_no(getSession().getAttribute("userid").toString());
		si.setAborigineCode(AborigineCode);
		si.setAborigineCode_f(AborigineCode_f);
		si.setAborigineCode_m(AborigineCode_m);
		
		si.setEducation_f(Education_f);
		si.setEducation_m(Education_m);
		si.setFirstCollegeStd(FirstCollegeStd);
		df.update(si);
		
		
		return execute();
	}

}
