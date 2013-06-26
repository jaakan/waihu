package myBeans;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


public class PaginationBean {

	/**
	 * @param args
	 */
	private int pageSize;
	private int pageInedx;
	private int total;
	private JSONArray data=null;
	private String sql=null;
	
	private Connection con=null;
	private ResultSet rs=null;
	
	public PaginationBean(){
		con=DBPoolUtil.getInstance().getConnection();
	}
	
	public int getTotal(){
		return this.total;
	}
	
	public void setSQL(String sql){
		this.sql=sql;
		try {
			rs=con.createStatement().executeQuery(sql);
			rs.last();
			total=rs.getRow();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void setPageSize(int size){
		if(size>total){
			this.pageInedx=1;
		}
		this.pageSize=size;
	}
	
	public void setPageIndex(int index){
		int n=0;
		if(total%pageSize==0){
			n=total/pageSize;
		}else{
			n=total/pageSize+1;
		}
		if(index>n){
			index=1;
		}
		this.pageInedx=index;
	}
	
	public JSONArray getData(){
		data=new JSONArray();
		int star=(this.pageInedx-1)*this.pageSize+1;
		
		try {
			ResultSetMetaData rsmd=rs.getMetaData();
			rs.absolute(star);
			int it=0;
			
			do{
				JSONObject obj=new JSONObject();
				for(int i=1;i<=rsmd.getColumnCount();i++){
					String key=rsmd.getColumnName(i);
					obj.put(key,rs.getString(key));
				}
				data.put(it,obj);
				if(it==(pageSize-1)){
					break;
				}
				it++;
			}while(rs.next());
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return data;
	}
	public void close(){
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
