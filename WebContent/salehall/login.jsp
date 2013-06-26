<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="org.json.*" %> 
<%@page import="myBeans.*" %> 
<%@page import="java.sql.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%

//禁止缓存;
response.setHeader("Pragma","No-cache");   
response.setHeader("Cache-Control","no-cache");   
response.setDateHeader("Expires", 0);   

String req=(String)request.getParameter("req");
JSONObject res=new JSONObject();
Connection con=DBPoolUtil.getInstance().getConnection();
String sql="SELECT * FROM salehall";
ResultSet rs=con.createStatement().executeQuery(sql);

if(req.equals("getSalehallData")){
	JSONArray salehalls=new JSONArray();
	while(rs.next()){
		JSONObject salehall=new JSONObject();
		salehall.put("subcenter",rs.getString("subcenter"));
		salehall.put("name",rs.getString("name"));
		salehalls.put(salehall);
	}
	res.put("salehalls",salehalls);
}else if(req.equals("check")){
	String name=(String)request.getParameter("username");
	String password=(String)request.getParameter("password");
	
	String _sql="SELECT * FROM salehall WHERE name='"+name+"'";
	ResultSet _rs=con.createStatement().executeQuery(_sql);
	while(_rs.next()){
		if(password.equals(_rs.getString("password"))){
			JSONObject user=new JSONObject();
			ResultSetMetaData rsmd=_rs.getMetaData();
			for(int i=1;i<=rsmd.getColumnCount();i++){
				String key=rsmd.getColumnName(i);
				user.put(key,_rs.getString(key));
			}
			user.remove("password");
			res.put("status","success");
			res.put("user",user);
			session.setAttribute("user",user);
		}else{
			res.put("status","fail");
		}
	}
}
con.close();
System.out.println(res.toString());
out.write(res.toString());
%>