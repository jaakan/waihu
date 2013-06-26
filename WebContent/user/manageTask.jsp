<%@page import="org.json.JSONObject"%>
<%@page import="myBeans.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String req=(String)request.getParameter("req");
JSONObject res=new JSONObject();
JSONObject user=(JSONObject)session.getAttribute("user");


if(user!=null){
	Connection con=DBPoolUtil.getInstance().getConnection();
	if(req.equals("deleteTask")){
		String taskName=(String)request.getParameter("taskName");
		String deleteList="DELETE FROM tasklist WHERE taskName='"+taskName+"'";
		Statement stmt=con.createStatement();
	    int l=stmt.executeUpdate(deleteList);
	    System.out.println("l:"+l);
		if(l==1){
			res.put("isDelete","yes");
		}else{
			res.put("isDelete","no");
		}
	}else if(req.equals("lookupTask")){
		String taskName=(String)request.getParameter("taskName");
		res.put("isLookup","yes");
		session.setAttribute("taskName", taskName);
	}
	
	con.close();
}else{
	res.put("login","fail");
}

//System.out.println(res.toString());
out.write(res.toString());

%>