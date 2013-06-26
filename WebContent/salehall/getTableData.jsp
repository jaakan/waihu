
<%@ page import="
org.json.JSONObject,
org.json.JSONArray,
java.sql.ResultSet,
myBeans.PaginationBean
" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
PaginationBean p=new PaginationBean();
JSONObject user=(JSONObject)session.getAttribute("user");
JSONObject link=(JSONObject)session.getAttribute("link");
JSONArray metaData=(JSONArray)session.getAttribute("metaData");
String taskName=(String)session.getAttribute("taskName");


int pageIndex=Integer.parseInt((String)request.getParameter("page"));
int pageSize=Integer.parseInt((String)request.getParameter("rows"));

/*
System.out.println("user:"+user.toString());
System.out.println("metaData:"+metaData.toString());
System.out.println("link:"+link.toString());
System.out.println("taskName:"+taskName);
System.out.println("pageIndex:"+pageIndex);
System.out.println("pageSize:"+pageSize);
*/
String sql="SELECT * FROM taskdata_"+taskName+" WHERE "+link.getString("receivers")+"='"+user.getString("name")+"' ORDER BY "+link.getString("keyColumn")+"";
//System.out.println("sql:"+sql);
p.setSQL(sql);
p.setPageSize(pageSize);
p.setPageIndex(pageIndex);
JSONArray rows=p.getData();
JSONObject tableData=new JSONObject();
tableData.put("total",p.getTotal());
tableData.put("rows",rows);
out.write(tableData.toString());
p.close();
//System.out.println(tableData.toString());

%>
