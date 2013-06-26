package myBeans;

import java.io.*;
import java.net.URISyntaxException;
import java.util.*;
import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.*;
import com.oreilly.*;
import com.oreilly.servlet.*;


public class UploadBean {
	
	private HttpServletRequest request;
	private MultipartRequest  mreq;
	private File dir;
	private File uploadfile;
	private String filename;
	
	
	
	public UploadBean(){
		
	}
	
	public void setDir(String name){
		String dirname=null;
		try {
			String url=this.getClass().getResource("/").toURI().getPath();
			dirname=url.split("waihu")[0]+"waihu";
			System.out.println("UploadBean#setDir#url:"+url);
			dir=new File(dirname,name);
			if(!dir.exists()){
				dir.mkdir();
			}
			
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public File getDir(){
		return this.dir;
	}
	
	public void setUploadfile(String dir,String name){
		this.setDir(dir);
		this.filename=name;
		this.uploadfile=new File(this.dir,this.filename);
		
	}
	
	public File getUploadfile(){
		return this.uploadfile;
	}
	
	
	public void setRequest(HttpServletRequest request){
		this.request=request;
	}
	
	public void upload(){
		if(uploadfile.exists()){
			uploadfile.delete();
		}
		try {
			mreq=new MultipartRequest(request,this.getDir().toString(), 1024*1024*10, "utf-8");
			Enumeration ele=mreq.getFileNames();
			while(ele.hasMoreElements()){
				String _filename=(String)ele.nextElement();
				File upFile=mreq.getFile(_filename);
				File re=new File(upFile.getParentFile(),this.filename);
				if(upFile!=null&&upFile.renameTo(re)){
				System.out.println(re.toString());
				}
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		UploadBean upload=new UploadBean();
		upload.setUploadfile("filetmp", "txt.txt");
		String msg=upload.getUploadfile().toString();
		System.out.println(msg);
		System.out.println(upload.getDir().toString());

	}

}
