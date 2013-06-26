<%@page import="java.sql.*"%>
<%@page import="myBeans.*"%>
<%@page import="myBeans.user.InitMenuBean"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.*" %>   
 

<%
InitMenuBean menu=new InitMenuBean();
JSONObject user=(JSONObject)session.getAttribute("user");
JSONArray menuData=new JSONArray();
JSONArray makeTask_children=new JSONArray();
JSONObject addTask=new JSONObject();
addTask.put("id","addTask");
addTask.put("text","发布新任务");
makeTask_children.put(0,addTask);
JSONArray makedTask_children=new JSONArray();
menu.select();
JSONArray result=menu.getList();
for(int i=0;i<result.length();i++){
	JSONObject task=result.getJSONObject(i);
	//通过用户ID判断用户是否为任务发起者（maker）;
	if(user.getString("id").equals(task.getString("maker"))){
		//若是则添加该任务名称至menuData[1].children;
		JSONObject node=new JSONObject();
		node.put("text",task.getString("taskName"));
		makedTask_children.put(i,node);
	}
}

JSONArray supervisors=new JSONArray();
Connection con=DBPoolUtil.getInstance().getConnection();

String sql2="SELECT supervisors,taskName FROM tasklist";
ResultSet rs=con.createStatement().executeQuery(sql2);
int it=0;
while(rs.next()){
	JSONArray array=new JSONArray(rs.getString("supervisors"));
	for(int i=0;i<array.length();i++){
		JSONObject obj=array.getJSONObject(i);
		if(user.getString("id").equals(obj.getString("id"))){
			JSONObject node=new JSONObject();
			node.put("id",rs.getString("taskName"));
			node.put("text",rs.getString("taskName"));
			supervisors.put(it,node);
			it++;
		}
	}
}
con.close();
menuData.put(0,makeTask_children);
menuData.put(1,makedTask_children);
menuData.put(2,supervisors);
out.write(menuData.toString());

%>