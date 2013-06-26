package myBeans.user;
import java.sql.*;
import java.io.*;
import java.util.*;

import javax.servlet.http.HttpServlet;

import org.json.*;

import myBeans.*;

public class InitMenuBean {

	/**
	 * @param args
	 */
	private Connection con=DBPoolUtil.getInstance().getConnection();
	private JSONArray taskList=new JSONArray();
	
	public void select(){
		String sql="SELECT taskName,maker,receivers FROM taskList";
		try {
			ResultSet rs=con.createStatement().executeQuery(sql);
			ResultSetMetaData rsmd=null;
			rsmd=rs.getMetaData();
			int column=rsmd.getColumnCount();
			while(rs.next()){
				JSONObject task=new JSONObject();
				for(int i=1;i<=column;i++){
					task.put(rsmd.getColumnName(i), rs.getString(i));
				}
				taskList.put(task);
			}
			con.close();

		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public JSONArray getList(){
		return this.taskList;
	}

}
