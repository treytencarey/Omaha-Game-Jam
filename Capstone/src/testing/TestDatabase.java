package testing;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class TestDatabase {
	static String loc = "C:\\Users\\bryce\\eclipse-workspace\\Capstone\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Capstone\\Databases\\db.db";
	
	public static List<Map<String, Object>> executeQuery(String q) {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		
		// load the sqlite-JDBC driver using the current class loader
	    try {
	    	Class.forName("org.sqlite.JDBC");
	    } catch (ClassNotFoundException e)
	    {
	    	return resultList;
	    }
	
	    Connection connection = null;
	    
	    try
	    {
			// create a database connection
			connection = DriverManager.getConnection("jdbc:sqlite:" + loc);
			
			Statement statement = connection.createStatement();
			statement.setQueryTimeout(30);  // set timeout to 30 sec.
			
			ResultSet resultset = statement.executeQuery(q);
			
		    Map<String, Object> row = null;

		    ResultSetMetaData metaData = resultset.getMetaData();
		    Integer columnCount = metaData.getColumnCount();

		    while (resultset.next()) {
		        row = new LinkedHashMap<String, Object>();
		        for (int i = 1; i <= columnCount; i++) {
		            row.put(metaData.getColumnName(i), resultset.getObject(i));
		        }
		        resultList.add(row);
		    }
		}
	    catch (SQLException e)
	    {
	    	System.err.println(e.getMessage());
	    }       
	    finally
	    {         
			try {
				if(connection != null)
					connection.close();
			}
			catch(SQLException e)
			{  // Use SQLException class instead.          
				System.err.println(e); 
			}
	    }
	    return resultList;
	}
	
	public static String executeUpdate(String q)
	{
		// load the sqlite-JDBC driver using the current class loader
		try
		{
			Class.forName("org.sqlite.JDBC");
		} catch (ClassNotFoundException e)
		{
			return "INTERNAL ERROR"; // User may see this error, so make it ambiguous for them
		}
	    String err = "";
	
	    Connection connection = null;
	    try
	    {
			// create a database connection
			connection = DriverManager.getConnection("jdbc:sqlite:" + loc);
			
			Statement statement = connection.createStatement();
			statement.setQueryTimeout(30);  // set timeout to 30 sec.
			
			statement.executeUpdate(q);
		}
	    catch (SQLException e)
	    {
	    	System.err.println(e.getMessage());
	    	err = e.getMessage();
	    }       
	    finally
	    {         
			try {
				if(connection != null)
					connection.close();
			}
			catch(SQLException e)
			{  // Use SQLException class instead.          
				System.err.println(e);
				err = e.getMessage();
			}
	    }
	    return err;
	}
}
