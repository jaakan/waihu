<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<jsp:useBean id="upload" scope="page" class="myBeans.UploadBean"></jsp:useBean>

<%


JSONObject user=(JSONObject)session.getAttribute("user");
java.util.Date date=new java.util.Date();
SimpleDateFormat format =new SimpleDateFormat("yyMMddHHmmss");

if(user!=null){
	String filename=user.getString("id")+"_"+format.format(date);
	upload.setUploadfile("tmp",filename);
}else{
	upload.setUploadfile("tmp","test");
}
upload.setRequest(request);
upload.upload();

session.setAttribute("upfileURL", upload.getUploadfile().toString());



%>