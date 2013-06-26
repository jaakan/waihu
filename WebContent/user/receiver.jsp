<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="select" scope="page" class="myBeans.user.GetReceiverBean"></jsp:useBean>

<%
StringBuffer sb=new StringBuffer();
JSONArray list =new JSONArray();
HashSet subcenters=new HashSet();
ArrayList<JSONObject> users=select.select("select * from user");
for(int i=0;i<users.size();i++){
	JSONObject obj=users.get(i);
	String id=obj.getString("subcenter");
	if(subcenters.add(id)){
		//id已存在;
		JSONObject subcenter=new JSONObject();
		
		JSONArray children=new JSONArray();
		JSONObject child=new JSONObject();
		child.put("id",obj.getString("id"));
		child.put("text",obj.getString("name"));
		children.put(child);
		
		
		subcenter.put("id",id);
		subcenter.put("text","第"+id+"分中心");
		subcenter.put("state","closed");
		subcenter.put("children",children);
		
		list.put(subcenter);
	}else{
		//id不存在;
		for(int j=0;j<list.length();j++){
			JSONObject subcenter=list.getJSONObject(j);
			if(subcenter.getString("id").equals(id)){
				JSONArray children=subcenter.getJSONArray("children");
				JSONObject child=new JSONObject();
				child.put("id",obj.getString("id"));
				child.put("text",obj.getString("name"));
				children.put(child);
			}
			
		}
	}
}
out.write(list.toString());
%>
