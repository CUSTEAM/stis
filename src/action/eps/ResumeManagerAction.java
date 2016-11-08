package action.eps;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import action.BaseAction;
import model.Message;

public class ResumeManagerAction extends BaseAction{
	
	public String execute(){
		try{
			request.setAttribute("myRes", df.sqlGetStr("SELECT file_name FROM Eps_vitae WHERE student_no='"+getSession().getAttribute("userid")+"'"));		
		}catch(Exception e){
			request.setAttribute("myRes", null);		
		}
		
		return SUCCESS;
	}
	
	private File file;            //文件  
    private String fileFileName;  //文件名   
    private String filePath;      //文件路径  
    private InputStream inputStream;
	
	public String save() throws IOException{

		Message msg=new Message();
		if(file==null){
			msg.setError("請選擇檔案");
			this.savMessage(msg);
			return SUCCESS;
		}
		
		Date now=new Date();	
		String fileName;		
		String filePath;
		String tmp_path=getContext().getRealPath("/tmp");//本機目錄
		String target="host_runtime";
		File dst;
		Map<String, String>ftpinfo;
		File uploadedFile;			
        uploadedFile = this.getFile();  
        fileName=now.getTime()+bio.getExtention(getFileFileName());//置換檔名            
        filePath=getContext().getRealPath("/tmp" )+"/"+fileName;            
        if(!df.testOnlineServer()){//測試的情況
			target="host_debug";
			filePath=filePath.replace("\\", "/");
			tmp_path=tmp_path.replace("\\", "/");
		}
        dst=new File(tmp_path);//暫存資料夾			
		if(!dst.exists())dst.mkdir();
		bio.copyFile(uploadedFile, new File(filePath));
		ftpinfo=df.sqlGetMap("SELECT "+target+" as host, username, password, path FROM SYS_HOST WHERE useid='Resume'");
		bio.putFTPFile(ftpinfo.get("host"), ftpinfo.get("username"), ftpinfo.get("password"), tmp_path+"/", ftpinfo.get("path")+"/", fileName);
		df.exSql("INSERT INTO Eps_vitae(file_name,student_no)VALUES('"+fileName+"','"+getSession().getAttribute("userid")+"')ON DUPLICATE KEY UPDATE file_name='"+fileName+"';");
		
		
		
		return execute();
	
		
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

}
