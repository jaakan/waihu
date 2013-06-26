<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.*" %>
<%@ page import="java.io.*" %>
<%@page import="java.util.*" %>

<%

response.setHeader("Pragma","No-cache");   
response.setHeader("Cache-Control","no-cache");   
response.setDateHeader("Expires", 0);   

JSONObject res=new JSONObject();
String login=(String)session.getAttribute("login");

if(login!=null&&login.equals("success")){
	String req=(String)request.getParameter("req");
	
	if(req.equals("getUserData")){
		JSONObject user=(JSONObject)session.getAttribute("user");
		res.put("user",user);
		
	}else if(req.equals("updateTask")){
		String taskName=(String)request.getParameter("taskName");
		res.put("doUpdate","success");
		session.setAttribute("taskName",taskName);
	}
	
	
}else{
	login="fail";
	
}

res.put("login",login);
out.write(res.toString());
System.out.println("index:"+res.toString());



%>