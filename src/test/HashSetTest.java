package test;
import java.util.HashSet;
import java.util.Iterator;
public class HashSetTest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		HashSet<String> hashset=new HashSet<String>();
		String a="1";
		String b="2";
		String c="2";
		String d="1";
		String e="3";
		String f="4";
		hashset.add(a);
		hashset.add(b);
		hashset.add(c);
		hashset.add(d);
		hashset.add(e);
		hashset.add(f);
		
		String[] arr=new String[hashset.size()];
		hashset.toArray(arr);
		for(int i=0;i<arr.length;i++){
			System.out.println(arr[i]);
		}
		System.out.println("**********************");
		Iterator it=hashset.iterator();
		while(it.hasNext()){
			String str=(String)it.next();
			System.out.println(str);
		}

	}

}
