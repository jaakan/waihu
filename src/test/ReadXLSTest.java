package test;
import jxl.*;
import jxl.read.biff.BiffException;
import jxl.write.WritableWorkbook;

import java.io.*;
public class ReadXLSTest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
			Workbook book=Workbook.getWorkbook(new File("测试.xls"));
			Sheet sheet=book.getSheet(0);
			int x=sheet.getRows();
			int y=sheet.getColumns();
			System.out.println("表格的列数为："+x);
			System.out.println("表格的行数为："+y);
			
		} catch (BiffException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
