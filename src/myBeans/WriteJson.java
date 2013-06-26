package myBeans;

import java.io.*;

import org.json.*;
import java.util.*;

public class WriteJson {

	/**
	 * @param args
	 */
	private File jsonFile=null;
	private PrintWriter writer=null;
	
	public boolean writeJsonData(String data){
		boolean success=false;
		try {
			writer=new PrintWriter(jsonFile,"utf-8");
			writer.write(data);
			writer.flush();
			if(!writer.checkError()){
				success=true;
			}
			writer.close();
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return success;
	}
	
	public File setFile(String filePath){
		this.setFile(new File(filePath));
		return this.jsonFile;
	}
	
	public File setFile(File file){
		this.jsonFile=file;
		return this.jsonFile;
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		WriteJson jsonW=new WriteJson();
		jsonW.setFile("test.txt");
		if(jsonW.writeJsonData("输出数据")){
			System.out.println("输出成功");
		}

	}

}
