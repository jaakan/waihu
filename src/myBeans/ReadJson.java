package myBeans;

import org.json.*;
import java.io.*;
import java.util.*;

public class ReadJson {

	/**
	 * @param args
	 */
	private StringBuffer sb=null;
	private String jsonData;
	private FileInputStream in=null;
	private InputStreamReader reader=null;
	private BufferedReader buffReader=null;
	private File jsonFile=null;
	
	
	public File setFile(String url){
		jsonFile=new File(url);
		return jsonFile;
	}
	
	public File setFile(File file){
		jsonFile=file;
		return jsonFile;
	}
	
	public String getJsonData(){
		if(jsonFile.exists()){
			try {
				sb=new StringBuffer();
				in=new FileInputStream(jsonFile);
				reader=new InputStreamReader(in,"utf-8");
				buffReader=new BufferedReader(reader);
				String lineStr=null;
				while((lineStr=buffReader.readLine())!=null){
					sb.append(lineStr);
				}
				buffReader.close();
				reader.close();
				in.close();
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			jsonData=sb.toString();
			
		}
		return jsonData;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ReadJson read=new ReadJson();
		read.setFile("E:/Documents and Settings/Administrator/workspace/myweb2.0/WebContent/admin/indexMenu.json");
		System.out.print(read.getJsonData());

	}

}
