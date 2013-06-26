package test;

import org.json.*;

import java.io.*;
import java.util.*;
import jxl.*;
import jxl.write.*;
import jxl.read.biff.*;

public class GetReceiversTest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
	

		JSONObject res=new JSONObject();
		String upfileURL="E://8月宽带到期续费（城南营销中心）.xls";
		java.io.File xlsFile=new java.io.File(upfileURL);
		Workbook book=null;
		
		try {
			book = Workbook.getWorkbook(xlsFile);
		} catch (BiffException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		Sheet sheet=book.getSheet(0);

		
	
			JSONArray receivers=new JSONArray();
			HashSet hash=new HashSet();
			int index=new Integer("6");
			int row=sheet.getRows();
			for(int i=0;i<row;i++){
				Cell cell=sheet.getCell(index, i);
				hash.add(cell.getContents());
			}
			
			Iterator it=hash.iterator();
			while(it.hasNext()){
				String msg=(String)it.next();
				System.out.println(msg);
			}
			
			
   }
}

