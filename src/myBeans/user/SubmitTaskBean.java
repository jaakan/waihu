package myBeans.user;
import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;

import org.json.*;
import myBeans.DBPoolUtil;

public class SubmitTaskBean {

	/**
	 * @param args
	 */
	
	/*
	request:
	{
		"name":"taskname",
		"columns":[
		           {"name":"1","type":"text","value":"#N/A"},
		           {"name":"2","type":"input","value":"����Ĭ��ֵ(��ѡ)"},
		           {"name":"3","type":"select","value":"1,2,3,4"},
		           {"name":"4","type":"textarea","value":"����Ĭ��ֵ(��ѡ)"}
		           ],
		"receivers":[{"id":"5"},{"id":"61652"},{"id":"61659"},{"id":"68258"}]
	}
	*/
	
	private Connection con=DBPoolUtil.getInstance().getConnection();
	private String sql=null;
	private String taskName=null;
	private String metaData=null;
	private String receivers=null;
	private String maker=null;
	private String time=null;
	
	
	
	public void setSubmit(String maker,String msg){
		//�õ�ʱ�䣻
				java.util.Date date=new java.util.Date();
				SimpleDateFormat format=new SimpleDateFormat("yyyyMMddHHmmss");
				time=format.format(date);
		try {
			JSONObject task=new JSONObject(msg);
			taskName=task.getString("name")+time;
			metaData=task.getJSONArray("columns").toString();
			JSONArray _receivers=task.getJSONArray("receivers");
			StringBuffer sb=new StringBuffer();
			for(int i=0;i<_receivers.length();i++){
				sb.append(_receivers.getJSONObject(i).getString("id")+",");
			}
			receivers=sb.toString();
			this.maker=maker;
			
			System.out.println(taskName);
			System.out.println(metaData);
			System.out.println(receivers);
			System.out.println(maker);
			
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		//�ύ����ݿ���myweb.tasklist��
		sql="INSERT INTO tasklist (taskName,metaData,receivers,maker) VALUES ('"+
		taskName+"','"+metaData+"','"+receivers+"','"+maker+"')";
		try {
			con.createStatement().executeUpdate(sql);
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
