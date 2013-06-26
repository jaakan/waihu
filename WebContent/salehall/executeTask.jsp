<%@page import="org.json.JSONArray"%>
<%@page import="java.sql.*"%>
<%@page import="myBeans.*"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String req=(String)request.getParameter("req");
JSONObject user=(JSONObject)session.getAttribute("user");
String taskName=(String)session.getAttribute("taskName");
Connection con=DBPoolUtil.getInstance().getConnection();


if(req.equals("init")){

	JSONObject res=new JSONObject();
	JSONObject link=null;
	JSONArray metaData=null;
	String metaSql="SELECT metaData,link FROM tasklist WHERE taskName='"+taskName+"'";
	ResultSet rs=con.createStatement().executeQuery(metaSql);
	while(rs.next()){
		metaData=new JSONArray(rs.getString("metaData"));
		link=new JSONObject(rs.getString("link"));
		session.setAttribute("metaData", metaData);
		session.setAttribute("link", link);
	}
	
	
	res.put("metaData",metaData);
	res.put("taskName",taskName);
	
	con.close();
	rs.close();
	out.write(res.toString());
}


%>
