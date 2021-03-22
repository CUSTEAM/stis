package action.calendar;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;

import model.Dilg;
import model.DilgApply;
import model.Message;
import action.BaseAction;

public class MyDilg extends BaseAction{
	
	public String execute() throws Exception {
		
		Cookie c[]=request.getCookies();		
		List list=new ArrayList();
		Map map;
		String daycls[];
		for(int i=0; i<c.length; i++){
			if(c[i].getName().indexOf("20")>=0){				
				map=new HashMap();
				daycls=new String[2];
				daycls=c[i].getName().split("&");
				map.put("date", daycls[0]);
				map.put("cls", daycls[1]);
				map.put("Oid", c[i].getValue());
				list.add(map);
			}
		}
		if(list.size()<1){
			Message m=new Message();
			m.setError("未選擇節次");
			this.savMessage(m);
			//response.sendRedirect("MyCalendar");
			//return null;
			//return "introCalendar";
			response.sendRedirect("MyCalendar");
		}
		
		request.setAttribute("dilgs", list);
		return "intro";
	}
	
	/**
	 * 新增假單
	 * @return
	 * @throws IOException
	 * @throws ParseException
	 */
	public String addDilg() throws IOException, ParseException{		
		Date now=new Date();
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
		
		//2020/12/29生理假28天內不得重複
		//2021/3/22生輔組通知取消生理假限制
		if(abs.equals("0")) {
			
			if(df.sqlGetStr("SELECT sex FROM stmd WHERE student_no='"+getSession().getAttribute("userid")+"'").equals("1")) {
				Message msg=new Message();
				msg.setError("依校方規定男同學不可申請");
				this.savMessage(msg);
				//response.sendRedirect(request.getContextPath() + "/MyDilg");
	            return SUCCESS;
			}
			
			/*Calendar c=Calendar.getInstance();
			c.setTime(sf.parse(date[0]));
			c.add(Calendar.DAY_OF_YEAR, -28);
			List<Map>lastDays=df.sqlGet("SELECT date FROM Dilg WHERE student_no='"+getSession().getAttribute("userid")+"'AND abs='0' AND date>='"+sf.format(c.getTime())+"'");
			if(lastDays.size()>0) {
				Message msg=new Message();
				msg.setError("依校方規定於前次請假日期 "+lastDays.get(0).get("date")+"的 28天內不可重複申請");
				this.savMessage(msg);
				//response.sendRedirect(request.getContextPath() + "/MyDilg");
	            return SUCCESS;
			}*/
			
		}
		
		
		
		
		
		
		
		String tutor=df.sqlGetStr("SELECT tutor FROM Class c, stmd s WHERE c.ClassNo=s.depart_class AND s.student_no='"+getSession().getAttribute("userid")+"'");
		
		DilgApply da=new DilgApply();
		try{
			//save假單			
			da.setAbs(abs);
			da.setAuditor(tutor);
			da.setNote(note);
			da.setReason(reason);
			da.setStudent_no((String)getSession().getAttribute("userid"));
			da.setCr_date(new Date());
			int days=0;
			Map tmp=new HashMap();
			for(int i=0; i<date.length; i++){
				tmp.put(date[i], i);
			}
			for (Iterator i = tmp.values().iterator(); i.hasNext();) {
				Object obj = i.next();
				days++;
			}
			//舊dilg rule6,7,8,9不論天數都必需送學務長審核
			//2018/9/27, <=3天內導師>3<5系主任>5部學務主任
			/*if(days>3||Integer.parseInt(abs)>=6){
				da.setDefaultLevel("3");//預設層級最大為3
			}else{
				da.setDefaultLevel(String.valueOf(days));
			}*/
			//2018-9-27, <=3天內導師>3<5系副主任>5部學務主任
			
			//2019-9-27
			
			if(days<3)da.setDefaultLevel("1");
			if(days==3 || days==4)da.setDefaultLevel("2");
			if(days>4)da.setDefaultLevel("3");
			da.setRealLevel("1");//預設層級1:導師
			df.update(da);
		}catch(Exception e){
			Message m=new Message();
			m.setError("未選擇節次");
			this.savMessage(m);
			response.sendRedirect("MyCalendar");
			return null;
		}
		
		Date someday;
		//Dilg d;
		for(int i=0; i<cls.length; i++){
			someday=sf.parse(date[i]);
			/*d=new Dilg();
			d.setAbs(abs);
			d.setCls(cls[i]);
			someday=sf.parse(date[i]);
			d.setDate(someday);
			d.setDtime_oid(Integer.parseInt(Oid[i]));
			d.setStudent_no((String)getSession().getAttribute("userid"));
			d.setDilg_app_oid(da.getOid());
			if(someday.getTime()>now.getTime()){
				d.setEarlier("1");
			}
			d.setAbs_original(abs_original);
			//刪除舊有記錄(點名)
			df.exSql("DELETE FROM Dilg WHERE student_no='"+d.getStudent_no()+"' AND date='"+date[i]+"' AND cls='"+cls[i]+"'");
			//建立dilg
			df.update(d);	
			*/
			
			if(someday.getTime()>now.getTime()){//事先
				df.exSql("INSERT INTO Dilg(earlier, student_no,date,cls,abs,Dtime_oid,Dilg_app_oid)VALUES('1','"+getSession().getAttribute("userid")+"','"+date[i]+"','"+cls[i]+"','"+abs+"',"+Oid[i]+","+da.getOid()+")"
						+ "ON DUPLICATE KEY UPDATE Dilg_app_oid="+da.getOid()+", abs_original=abs, abs='"+abs+"';");
			}else{
				df.exSql("INSERT INTO Dilg(student_no,date,cls,abs,Dtime_oid,Dilg_app_oid)VALUES('"+getSession().getAttribute("userid")+"','"+date[i]+"','"+cls[i]+"','"+abs+"',"+Oid[i]+","+da.getOid()+")"
						+ "ON DUPLICATE KEY UPDATE Dilg_app_oid="+da.getOid()+", abs_original=abs, abs='"+abs+"';");
			}		
		}		
		
		Cookie c[]=request.getCookies();
		for(int i=0; i<c.length; i++){
			if(c[i].getName().indexOf("20")>=0){				
				c[i].setMaxAge(0);
				c[i].setPath("/");
				response.addCookie(c[i]);
			}
		}
		
		//處理附加檔案
		//String fullpath=getContext().getRealPath("/tmp" )+"/";
		//file_name = now.getTime() + extent;		
		if(fileFileName!=null){
			
			String file_name=now.getTime()+bio.getExtention(fileFileName);//置換檔名			
			String file_path=getContext().getRealPath("/tmp" )+"/"+file_name;
			String tmp_path=getContext().getRealPath("/tmp");//本機目錄
			
			//ftp主機確認
			String target="host_runtime";
			if(!df.testOnlineServer()){
				target="host_debug";
				file_path=file_path.replace("\\", "/");
				tmp_path=tmp_path.replace("\\", "/");
			}
			
			
			
			
			
			File dst=new File(tmp_path);//暫存資料夾			
			if(!dst.exists())dst.mkdir();			
			bio.copyFile(file, new File(file_path));
			
			
			Map<String, String>ftpinfo=df.sqlGetMap("SELECT "+target+" as host, username, password, path FROM SYS_HOST WHERE useid='DilgImage'");
			
			
			
			bio.putFTPFile(ftpinfo.get("host"), ftpinfo.get("username"), ftpinfo.get("password"), tmp_path+"/", ftpinfo.get("path")+"/", file_name);
			df.exSql("UPDATE Dilg_apply SET file='"+file_name+"' WHERE Oid="+da.getOid());
		}
		
		
		
		
		
		
		response.sendRedirect("MyDilgAdd");
		return null;
	}
	
	public String resetCookie() throws IOException{		
		//清除
		Cookie c[]=request.getCookies();
		for(int i=0; i<c.length; i++){
			if(c[i].getName().indexOf("20")>=0){				
				c[i].setMaxAge(0);
				c[i].setPath("/");
				response.addCookie(c[i]);
			}
		}
		response.sendRedirect("MyCalendar");
		return null;
	}
	
	public String Oid[];
	public String cls[];
	public String date[];
	public String abs;
	public String reason;
	public String note;
	
	private File file;
	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	private String fileContentType;
	private String fileFileName;
	

}
