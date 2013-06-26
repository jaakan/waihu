<%@page import="org.json.*"%>

<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="jxl.*" %>
<%@ page import="jxl.write.*" %>
<%@ page import="jxl.read.biff.*" %>
<%@ page import="myBeans.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
JSONObject res=new JSONObject();
JSONObject user=(JSONObject)session.getAttribute("user");
String req=(String)request.getParameter("req");
String upfileURL=(String)session.getAttribute("upfileURL");
java.io.File xlsFile=new java.io.File(upfileURL);
Workbook book=Workbook.getWorkbook(xlsFile);
Sheet sheet=book.getSheet(0);
int column=sheet.getColumns();
int row=sheet.getRows();
Connection con=DBPoolUtil.getInstance().getConnection();
if(req.equals("xlsMeta")){
	JSONObject xlsMeta=new JSONObject();
	if(xlsFile.exists()){
		xlsMeta.put("status","success");
		
		JSONArray titles=new JSONArray();
		for(int i=0;i<column;i++){
			Cell cell=sheet.getCell(i,0);   //sheet.getCell(column,row);
			JSONObject title=new JSONObject();
			title.put("title",cell.getContents());
			titles.put(i,title);
		}
		xlsMeta.put("titles",titles);
	}else{
		xlsMeta.put("status","error");
	}
	
	res.put("xlsMeta",xlsMeta);
	System.out.println(res.toString());
	
}

if(req.equals("getReceiver")){
	//根据上传的表格的列号确定接收人列表；
	String id=(String)request.getParameter("id");
	JSONArray receivers=new JSONArray();
	//定义一个HashSet用于存储接收人;
	HashSet hash=new HashSet();
	int index=new Integer(id);
	for(int i=1;i<row;i++){
		Cell cell=sheet.getCell(index,i);
		hash.add(cell.getContents());
	}
	
	Iterator it=hash.iterator();
	while(it.hasNext()){
		String msg=(String)it.next();
		
		if(!msg.equals("")){
			JSONObject receiver=new JSONObject();
			receiver.put("name",msg);
			receivers.put(receiver);	
		}
		
	}
	res.put("receivers",receivers);
}else if(req.equals("updataToDB")){
	String taskData=request.getParameter("taskData");
	JSONObject taskObj=new JSONObject(taskData);
	String metaData=taskObj.getJSONArray("metaData").toString();
	String maker=taskObj.getString("maker");
	String taskName=taskObj.getString("taskName")+"_"+maker;
	String receivers=taskObj.getJSONArray("receivers").toString();
	String supervisors=taskObj.getJSONArray("supervisors").toString();
	String link=taskObj.getString("link").toString();
	String sql="INSERT INTO tasklist VALUES('"+taskName+"','"+metaData+"','"+maker+"','"+receivers+"','"+supervisors+"','"+link+"')";
	Statement stmt=con.createStatement();
	stmt.executeUpdate(sql);
	String tableName=taskName;
	StringBuffer sql_sb=new StringBuffer("CREATE TABLE taskdata_"+tableName+" (");
	for(int i=0;i<column;i++){
		Cell cell=sheet.getCell(i,0);
		String cellcon=cell.getContents();
		if(i<column-1){
			sql_sb.append(cellcon+" varchar(255),");
		}else if(i==column-1){
			sql_sb.append(cellcon+" varchar(255))");
		}
		
	}
	stmt.executeUpdate(sql_sb.toString());
	for(int i=1;i<row;i++){
		StringBuffer insert_data=new StringBuffer("INSERT INTO taskdata_"+tableName+" VALUES(");
		for(int j=0;j<column;j++){
			Cell cell=sheet.getCell(j,i);
			String cellcon=cell.getContents();
			if(j<column-1){
				insert_data.append("'"+cellcon+"',");
			}else if(j==column-1){
				insert_data.append("'"+cellcon+"')");
			}
		}
		stmt.executeUpdate(insert_data.toString());
	}
	
	con.close();
	
}else if(req.equals("setSupervisors")){
	JSONArray supervisors=new JSONArray();
	
	String sql="SELECT id,name FROM user";
	ResultSet rs=con.createStatement().executeQuery(sql);;
	int it=0;
	while(rs.next()){
		JSONObject supervisor=new JSONObject();
		supervisor.put("id",rs.getString("id"));
		supervisor.put("text",rs.getString("name"));
		supervisor.put("checkbox",true);
		supervisors.put(it,supervisor);
		it++;
	}
	res.put("supervisors",supervisors);
}else if(req.equals("deleteTmpFile")){
	xlsFile.delete();
}
con.close();
res.put("user",user);
out.write(res.toString());


%>