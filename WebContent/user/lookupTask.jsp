<%@page import="java.sql.ResultSetMetaData"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="myBeans.*" %>
<%@ page import="org.dom4j.*" %>
<%@ page import="org.dom4j.dom.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
JSONObject res=new JSONObject();
JSONObject user=(JSONObject)session.getAttribute("user");
if(user!=null){
	Document doc = DocumentHelper.createDocument();
	Connection con=DBPoolUtil.getInstance().getConnection();
	String req=(String)request.getParameter("req");
		String taskName=(String)session.getAttribute("taskName");
		String sql="SELECT * FROM taskdata_"+taskName+"";
		System.out.println("lookupTask:"+sql);
		ResultSet rs=con.createStatement().executeQuery(sql);
		ResultSetMetaData rsmd=rs.getMetaData();
		int column=rsmd.getColumnCount();
		 Element root=DocumentHelper.createElement("table");
		 Element thead=DocumentHelper.createElement("thead");
		 Element tbody=DocumentHelper.createElement("tbody");
		 Element trHead=DocumentHelper.createElement("tr");
		 doc.setRootElement(root);
		 root.add(thead);
		 root.add(tbody);
		 
		for(int i=1;i<=column;i++){
			Element th=DocumentHelper.createElement("th");
			th.setText(rsmd.getColumnName(i));
			trHead.add(th);
		}
		thead.add(trHead);
		while(rs.next()){
			Element trBody=DocumentHelper.createElement("tr");
			for(int i=1;i<=column;i++){
				Element td=DocumentHelper.createElement("td");
				td.setText(rs.getString(rsmd.getColumnName(i)));
				trBody.add(td);
			}
			tbody.add(trBody);
		}
		con.close();
	out.write(root.asXML());
}else{
	out.write("请先登录");
}
%>