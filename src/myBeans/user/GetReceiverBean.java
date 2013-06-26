package myBeans.user;
import java.io.*;
import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServlet;

import org.json.*;
import myBeans.DBPoolUtil;

public class GetReceiverBean {

	/**
	 * @param args
	 */
	private Connection con=DBPoolUtil.getInstance().getConnection();
	private ArrayList<JSONObject> users=new ArrayList<JSONObject>();
	private JSONArray list=null;
	
	public ArrayList<JSONObject> select(String sql){

		
		try {
			ResultSet rs=con.createStatement().executeQuery(sql);
			ResultSetMetaData rsmd=rs.getMetaData();
			int column=rsmd.getColumnCount();
			list=new JSONArray();
			while(rs.next()){
				JSONObject user=new JSONObject();
				for(int i=1;i<=column;i++){
					user.put(rsmd.getColumnName(i),rs.getString(i));
				}
				users.add(user);
				list.put(user);
			}
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return users;
	}
	public JSONArray getList(){
		return this.list;
	}
	

}
