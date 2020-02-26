package action.coansw;

import action.BaseAction;

public class QuestONE extends BaseAction{
	
	public String ans[];
	
	public String execute(){
		request.setAttribute("QuestMap", df.sqlGetMap("SELECT reply FROM QUEST_RES q WHERE q.Qid="+
		getContext().getAttribute("QUESTOid")+" AND q.student_no='"+session.get("userid")+"'ORDER BY q.Oid DESC"));
		return SUCCESS;
	}
	
	public String save(){
		StringBuilder sb=new StringBuilder("");
		for(int i=0; i<ans.length; i++){
			sb.append(ans[i]+",");
		}
		sb.delete(sb.length()-1, sb.length());
		df.exSql("UPDATE QUEST_RES SET reply='"+sb.toString()+"'WHERE student_no='"+getSession().getAttribute("userid")+"'AND Qid="+getContext().getAttribute("QUESTOid"));
		return execute();
	}	
}