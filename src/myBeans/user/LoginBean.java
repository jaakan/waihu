package myBeans.user;
import java.io.*;
import java.sql.*;

import javax.servlet.http.HttpServlet;

import org.json.*;

import myBeans.*;

public class LoginBean {
	/**
	 * @param args
	 */
	private JSONObject user=null;
	private Connection con=DBPoolUtil.getInstance().getConnection();
	private String sql=null;
	
	public JSONObject check(String id){
		user=new JSONObject();
		sql="SELECT * FROM user WHERE user.id='"+id+"'";
		
		try {
			ResultSet rs=con.createStatement().executeQuery(sql);
			ResultSetMetaData rsmd=rs.getMetaData();
			int column=rsmd.getColumnCount();
			while(rs.next()){
				for(int i=1;i<=column;i++){
					user.put(rsmd.getColumnName(i),rs.getString(i));
				}
			}
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		LoginBean log=new LoginBean();
		System.out.print(log.check("616").isNull("name"));

	}

}
