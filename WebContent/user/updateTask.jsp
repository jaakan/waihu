<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.*"%>

<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="myBeans.*"%>

<%@page import="jxl.*"%>
<%@page import='jxl.read.biff.BiffException' %>
<%@page import='jxl.write.WritableWorkbook' %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String taskName=(String)session.getAttribute("taskName");
JSONObject res=new JSONObject();

if(taskName!=null){
	String req=(String)request.getParameter("req");
	Connection con=DBPoolUtil.getInstance().getConnection();
	Statement stmt=con.createStatement();
	if(req.equals("init")){
		JSONArray children=new JSONArray();
		String sql="SELECT * FROM taskdata_"+taskName+"";
		ResultSet rs=stmt.executeQuery(sql);
		ResultSetMetaData rsmd=rs.getMetaData();
		int l=rsmd.getColumnCount();
		
		for(int i=1;i<=l;i++){
			JSONObject node=new JSONObject();
			node.put("text",rsmd.getColumnName(i));
			node.put("id",rsmd.getColumnName(i));
			children.put(i-1,node);
		}
		rs.close();
		res.put("children",children);
	}else if(req.equals("uploaded")){
		String _metaData=(String)request.getParameter("metaData");
		JSONArray metaData=new JSONArray(_metaData);
		String fileURL=(String)session.getAttribute("upfileURL");
		JSONObject status=new JSONObject();
		java.io.File file=new File(fileURL);
		Workbook book=Workbook.getWorkbook(file);
		Sheet sheet=book.getSheet(0);
		ArrayList<String> xlsMeta=new ArrayList<String>();
		boolean match=false;
		for(int i=0;i<metaData.length();i++){
			Cell cell=sheet.getCell(i,0);
			
			System.out.println(cell.getContents());
			String uploadMeta=metaData.getJSONObject(i).getString("name");
			if(uploadMeta.equals(cell.getContents())){
				xlsMeta.add(i,cell.getContents());
				match=true;
			}else{
				match=false;
				break;
			}
		}
		if(match){
			res.put("match","yes");
			String sql_start="UPDATE taskdata_"+taskName+" SET ";
			for(int i=1;i<sheet.getRows();i++){
				StringBuffer sql_column=new StringBuffer(sql_start);
				for(int j=1;j<xlsMeta.size();j++){
					if(j==xlsMeta.size()-1){
						Cell cell=sheet.getCell(j, i);
						Cell cellID=sheet.getCell(0,i);
				        sql_column.append(""+xlsMeta.get(j)+"='"+cell.getContents()+"' ");
						sql_column.append("WHERE "+xlsMeta.get(0)+"='"+cellID.getContents()+"'");
					}else{
						Cell cell=sheet.getCell(j, i);
				        sql_column.append(""+xlsMeta.get(j)+"='"+cell.getContents()+"',");
					}
					
				}
				System.out.println(sql_column.toString());
				int s=stmt.executeUpdate(sql_column.toString());
				if(s==1){
					res.put("status","success");
				}else{
					res.put("status","fail");
				}
			}
			
		}else{
			res.put("match","no");
		}
		
		file.delete();
		
	}
	con.close();
}else{
	
}

out.write(res.toString());

%>