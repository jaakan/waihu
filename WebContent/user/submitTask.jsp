<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="org.json.*" %>
<jsp:useBean id="submit" scope="page" class="myBeans.user.SubmitTaskBean"></jsp:useBean>
<%
String submitData=request.getParameter("submit");
JSONObject user=(JSONObject)session.getAttribute("msg");
String userid=user.getString("id");
submit.setSubmit(userid, submitData);

%>

<% 
/*
request:
{
	"name":"taskname",
	"columns":[
	           {"name":"1","type":"text","value":"#N/A"},
	           {"name":"2","type":"input","value":"输入默认值(可选)"},
	           {"name":"3","type":"select","value":"1,2,3,4"},
	           {"name":"4","type":"textarea","value":"输入默认值(可选)"}
	           ],
	"receivers":[{"id":"5"},{"id":"61652"},{"id":"61659"},{"id":"68258"}]
}
*/
%>