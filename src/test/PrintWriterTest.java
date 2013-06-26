package test;
import java.io.*;
public class PrintWriterTest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		File file=new File("PrintWriterTest.txt");
		String msg="this is a PrintWriterTest:";
		String append="append";
		String print="print";
		String write="write";
		try {
			PrintWriter writer=new PrintWriter(file,"utf-8");
			writer.write(msg);
			writer.flush();
			writer.write(msg);
			writer.flush();
			//writer.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		

	}

}
