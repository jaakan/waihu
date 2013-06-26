<%@page import="java.sql.*"%>
<%@page import="myBeans.*"%>
<%@page import="org.json.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
Connection con=DBPoolUtil.getInstance().getConnection();

String username=request.getParameter("username");
String password=request.getParameter("password");
String sql="SELECT * FROM user WHERE id='"+username+"'";

JSONObject res=new JSONObject();
ResultSet rs=con.createStatement().executeQuery(sql);
JSONObject user=new JSONObject();
while(rs.next()){
	java.sql.ResultSetMetaData rsmd=rs.getMetaData();
	for(int i=1;i<rsmd.getColumnCount();i++){
		String key=rsmd.getColumnName(i);
		user.put(key,rs.getString(key));
	}
}
con.close();
System.out.println(user.toString());
if((!user.isNull("password"))&&(user.getString("password").equals(password))){
	user.remove("password");
	res.put("user",user);
	session.setAttribute("user",user);
	session.setAttribute("login","success");
}else{
	session.setAttribute("login","fail");
	res.put("user","null");
}
out.write(res.toString());
System.out.println("login:"+res.toString());
%>