package myBeans;

import java.beans.PropertyVetoException;
import java.sql.Connection;
import java.sql.SQLException;

import com.mchange.v2.c3p0.ComboPooledDataSource;

public class DBPoolUtil {
	private static DBPoolUtil dbcputils = null;
	private ComboPooledDataSource cpds = null;

	private DBPoolUtil() {
		if (cpds == null) {
			cpds = new ComboPooledDataSource();
		}
		cpds.setUser(DBConsts.username);
		cpds.setPassword(DBConsts.password);
		cpds.setJdbcUrl(DBConsts.url);
		try {
			cpds.setDriverClass(DBConsts.driverClassName);
		} catch (PropertyVetoException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		cpds.setInitialPoolSize(100);
		cpds.setMaxIdleTime(20);
		cpds.setMaxPoolSize(100);
		cpds.setMinPoolSize(10);
	}

	public synchronized static DBPoolUtil getInstance() {
		if (dbcputils == null)
			dbcputils = new DBPoolUtil();
		return dbcputils;
	}

	public Connection getConnection() {
		Connection con = null;
		try {
			con = cpds.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return con;
	}

	public static void main(String[] args) throws SQLException {
		Connection con = null;
		long begin = System.currentTimeMillis();
		for (int i = 0; i < 1000000; i++) {
			con = DBPoolUtil.getInstance().getConnection();
			con.close();
		}
		long end = System.currentTimeMillis();
		System.out.println("ºÄÊ±Îª:" + (end - begin) + "ms");
	}
}
