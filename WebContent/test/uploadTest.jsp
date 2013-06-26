<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="mReq" scope="page" class="myBeans.UploadBean" ></jsp:useBean>





<%
request.setCharacterEncoding("utf-8");

response.setCharacterEncoding("utf-8");

	//上传文件;
	mReq.setUploadfile("tmp","tem.txt");
	mReq.setRequest(request);
	mReq.upload();
	
	out.write("success");

%>
