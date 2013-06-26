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
if(req.equals("getRow")){
	JSONObject res=new JSONObject();
	String taskName=(String)request.getParameter("taskName");
	String id=(String)request.getParameter("id");
	String value=(String)request.getParameter("value");
	String sql="SELECT * FROM taskdata_"+taskName+" WHERE "+id+"='"+value+"'";
	ResultSet rs=con.createStatement().executeQuery(sql);
	while(rs.next()){
		for(int i=0;i<metaData.length();i++){
			String key=metaData.getJSONObject(i).getString("name");
			res.put(key,rs.getString(key));
		}
	}
	out.write(res.toString());
con.close();
}


%>