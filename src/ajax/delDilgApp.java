package ajax;

import java.util.List;
import java.util.Map;

import service.impl.DataFinder;

import com.opensymphony.xwork2.Action;

import action.BaseAction;

public class delDilgApp extends BaseAction{
	public String execute() {		
		DataFinder df = (DataFinder) get("DataFinder");
		String Oid=request.getParameter("Oid");
		
		//取得受影響Dilg
		List<Map>dilgs=df.sqlGet("SELECT Oid, abs_original, earlier FROM Dilg WHERE Dilg_app_oid="+request.getParameter("Oid"));
		
		//刪除假單
		//Map dilg=df.sqlGetMap("SELECT * FROM Dilg WHERE Oid="+Oid);		
		df.exSql("DELETE FROM Dilg_apply WHERE Oid="+Oid);		
		//處理受影響Dilg
		for(int i=0; i<dilgs.size(); i++){			
			//若有原始記錄刪除假單後還原為原始記錄，若無原始記錄
			if(dilgs.get(i).get("abs_original")!=null){
				df.exSql("UPDATE Dilg SET abs='"+dilgs.get(i).get("abs_original")+"' WHERE Oid="+dilgs.get(i).get("Oid"));
			}else{
				df.exSql("DELETE FROM Dilg WHERE Oid="+dilgs.get(i).get("Oid"));
			}
		}		
		return null;
	}
}
