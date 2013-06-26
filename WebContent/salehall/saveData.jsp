<%@page import="org.json.JSONArray"%>
<%@page import="java.sql.*"%>
<%@page import="myBeans.*"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String req=(String)request.getParameter("req");
String _metaData=(String)request.getParameter("metaData");
JSONArray metaData=new JSONArray(_metaData);


Connection con=DBPoolUtil.getInstance().getConnection();

if(req.equals("saveData")){
	JSONObject res=new JSONObject();
	String taskName=(String)request.getParameter("taskName");
	String id=(String)request.getParameter("id");
	String value=(String)request.getParameter("value");
	String _saveData=(String)request.getParameter("saveData");
	JSONObject saveData=new JSONObject(_saveData);
	StringBuffer sb_sql=new StringBuffer("UPDATE taskdata_"+taskName+" SET ");
	for(int j=0;j<metaData.length();j++){
		String _key=metaData.getJSONObject(j).getString("name");
		String _value=saveData.getString(_key);
		if(j==metaData.length()-1){
			sb_sql.append(_key+"=");
			sb_sql.append("'"+_value+"' WHERE "+id+"='"+value+"'");
		}else{
			sb_sql.append(_key+"=");
			sb_sql.append("'"+_value+"',");
		}
	}
	System.out.println(sb_sql.toString());
	
	int status=con.createStatement().executeUpdate(sb_sql.toString());
	if(status==1){
		res.put("status","success");
	}else{
		res.put("status","fail");
	}
	out.write(res.toString());
	con.close();
}


%>