<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="org.json.*" %> 
<%@page import="myBeans.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

//禁止缓存;
response.setHeader("Pragma","No-cache");   
response.setHeader("Cache-Control","no-cache");   
response.setDateHeader("Expires", 0);   


JSONObject user=(JSONObject)session.getAttribute("user");
JSONObject res=new JSONObject();


String req=(String)request.getParameter("req"); 
System.out.println(user!=null);



if(user!=null){
	System.out.println("sucess");
	res.put("login","success");
	if(req.equals("initMenu")){
		Connection con=DBPoolUtil.getInstance().getConnection();
		JSONArray menu=new JSONArray();
		JSONArray children0=new JSONArray();
		String sql="SELECT taskName,receivers FROM tasklist";
		java.sql.ResultSet rs=con.createStatement().executeQuery(sql);
		int it=0;
		while(rs.next()){
			String _receivers=rs.getString("receivers");
			String taskname=rs.getString("taskName");
			JSONArray receivers=new JSONArray(_receivers);
			for(int i=0;i<receivers.length();i++){
				String receiver=receivers.getJSONObject(i).getString("name");
				if(user.getString("name").equals(receiver)){
					JSONObject node=new JSONObject();
					node.put("id",taskname);
					node.put("text",taskname);
					children0.put(it,node);
					it++;
					break;
				}
			}
	    }  //   while end;
	    
		menu.put(0,children0);
		res.put("menu",menu);
		con.close();
	}else if(req.equals("executeTask")){
		String taskName=(String)request.getParameter("taskName");
		session.setAttribute("taskName",taskName);
	}
	
}else{
	System.out.println("fail");
	res.put("login","fail");
}

out.write(res.toString());



%>