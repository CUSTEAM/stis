package action.reaction;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import action.BaseAction;
import model.Mail;
import model.MailReceiver;
import model.Message;
import model.Task;
import model.Task_hist;

public class StdReactionAction extends BaseAction{
	
	private File[] fileUpload;
    private String[] fileUploadFileName;
    private String[] fileUploadContentType;
    public String title, note, email;
	
	public String execute(){
		String stdNo=String.valueOf(getSession().getAttribute("userid"));
		request.setAttribute("myReaction", df.sqlGet("SELECT * FROM Task WHERE userid='"+stdNo+"'"));		
		request.setAttribute("Email", df.sqlGetStr("SELECT Email FROM stmd WHERE student_no='"+stdNo+"'"));		
		return SUCCESS;
	}
	
	/**
	 * 儲存
	 * @return
	 */
	public String save(){
		Message msg=new Message();
		Date now=new Date();
		if(getSession().getAttribute("userid")==null){
			msg.setError("請勿匿名申請");
			this.savMessage(msg);
			return execute();//匿名彈出
		}
		
		if(title.trim().equals("")||note.trim().equals("")||email.trim().equals("")){
			msg.setError("請檢查內容");
			this.savMessage(msg);
			return execute();//匿名彈出
		}		
		
		String stdNo=getSession().getAttribute("userid").toString();		
		
		if(df.sqlGetInt("SELECT COUNT(*)FROM Task WHERE userid='"+stdNo+"' AND edate IS NULL")>2){
			msg.setError("請勿重覆申請");
			this.savMessage(msg);
			return execute();//申請中彈出
		}
		
		Map<String, String>leader=new HashMap();		
		//尋找院長
		leader=df.sqlGetMap("SELECT e.cname, e.idno, e.Email FROM stmd s, Class c, CODE_COLLEGE cc, empl e WHERE "
		+ "e.idno=cc.leader AND cc.id=c.InstNo AND s.depart_class=c.ClassNo AND s.student_no='"+getSession().getAttribute("userid")+"'");
		
		//TODO 測試期給我
		/*leader.put("idno", "E122713583");
		leader.put("cname", "蕭國裕");
		leader.put("Email", "hsiao@cc.cust.edu.tw");*/	
		
		if(leader.isEmpty()){
			//TODO 沒人給誰？
			//msg.setError("...");
			//this.savMessage(msg);
			leader.put("idno", "E122713583");
			leader.put("cname", "蕭國裕");
			leader.put("Email", "hsiao@cc.cust.edu.tw");
			return execute();
		}
		
		Mail m=new Mail();
		String stdName=df.sqlGetStr("SELECT student_name FROM stmd WHERE student_no='"+stdNo+"'");
		m.setSubject("學生 "+stdName+"的意見反應");		
		m.setContent("<style>blockquote{background:#f9f9f9;border-left:10px solid #ccc; margin:1.5em 10px; padding:0.5em 10px;} blockquote:before{color:#ccc;content:open-quote;font-size:4em;line-height:0.1em;margin-right:0.25em;vertical-align:-0.4em;}blockquote p{display:inline;}</style>"+"各位主管好<br><br>以下內容由資訊系統自動轉發<br><br><blockquote><b>"+title+"</b><br><br>"+note.substring(0, note.length()/2)+"...</blockquote><br><br>更多內容及附件檔案請登入<a href='http://ap.cust.edu.tw/ssos'>資訊系統</a>選單右側的【意見反應單】讀取");
		//m.setSender(stdName);
		m.setSender("中華科技大學資訊系統");
		m.setSend("0");
		m.setFrom_addr("CIS@cc.cust.edu.tw");//....
		df.update(m);
		MailReceiver r=new MailReceiver();
		r.setMail_oid(m.getOid());
		r.setAddr(leader.get("Email"));
		r.setName(leader.get("cname"));
		r.setType("to");
		df.update(r);
		
		Task t=new Task();
		t.setUserid(stdNo);
		t.setSdate(now);
		t.setTitle(title);
		t.setNote(note);
		t.setEmail(email);
		df.update(t);
		
		Task_hist th=new Task_hist();
		th.setEmpl(leader.get("idno").toString());
		th.setSdate(now);
		th.setTask_oid(t.getOid());
		th.setOpen("1");
		df.update(th);
		
		//處理附加檔案
		if(fileUpload!=null){
			
			String fileName;		
			String filePath;
			String tmp_path=getContext().getRealPath("/tmp");//本機目錄
			String target="host_runtime";
			File dst;
			Map<String, String>ftpinfo;
			File uploadedFile;
			for (int i = 0; i < fileUpload.length; i++) {			
	            uploadedFile = fileUpload[i];            
	            fileName=now.getTime()+"-"+i+bio.getExtention(fileUploadFileName[i]);//置換檔名            
	            filePath=getContext().getRealPath("/tmp" )+"/"+fileName;            
	            if(getContext().getAttribute("isServer").equals("0")){//測試的情況
	    			target="host_debug";
	    			filePath=filePath.replace("\\", "/");
	    			tmp_path=tmp_path.replace("\\", "/");
	    		}
	            dst=new File(tmp_path);//暫存資料夾			
				if(!dst.exists())dst.mkdir();
				bio.copyFile(fileUpload[i], new File(filePath));
				ftpinfo=df.sqlGetMap("SELECT "+target+" as host, username, password, path FROM SYS_HOST WHERE useid='TaskFile'");
				bio.putFTPFile(ftpinfo.get("host"), ftpinfo.get("username"), ftpinfo.get("password"), tmp_path+"/", ftpinfo.get("path")+"/"+t.getOid()+"/", fileName);
				df.exSql("INSERT INTO Task_file(Task_oid, path, file_name)VALUES("+t.getOid()+",'task/"+t.getOid()+"/', '"+fileName+"');");		            
	        }
			
		}
		
		return execute();
	}
	
	/**
	 * 結案
	 * @return
	 */
	public String finish(){
		
		
		
		
		return execute();
	}

	public File[] getFileUpload() {
		return fileUpload;
	}

	public void setFileUpload(File[] fileUpload) {
		this.fileUpload = fileUpload;
	}

	public String[] getFileUploadFileName() {
		return fileUploadFileName;
	}

	public void setFileUploadFileName(String[] fileUploadFileName) {
		this.fileUploadFileName = fileUploadFileName;
	}

	public String[] getFileUploadContentType() {
		return fileUploadContentType;
	}

	public void setFileUploadContentType(String[] fileUploadContentType) {
		this.fileUploadContentType = fileUploadContentType;
	}

}
