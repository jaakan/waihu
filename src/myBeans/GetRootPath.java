package myBeans;

import java.net.URISyntaxException;

public class GetRootPath {

	/**
	 * @param args
	 */
	public String rootPath;
	public GetRootPath(String root){
		try {
			rootPath=this.getClass().getResource("/").toURI().getPath();
		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		rootPath=rootPath.split(root)[0]+root;
		
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		GetRootPath pathtest=new GetRootPath("myweb2.0");
		System.out.println(pathtest.rootPath);

	}

}
