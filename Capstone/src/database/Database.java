package database;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.CharBuffer;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import project.Main;
import utils.Utils;

/**
 * 
 * Handles all interactions between the site and the database.
 *
 */
@WebServlet("/databaseServlet")
public class Database extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * The database location.
	 */
	public static final String AUTH_DB = Main.context.getRealPath("/Databases/db.db");

	/**
	 * Gets URL parameters as a map.
	 * @param query a string of the URL parameters query.
	 * @return A map of URL parameters.
	 */
	public static Map<String, String> getQueryMap(String query)  
	{  
	    String[] params = query.split("&");  
	    Map<String, String> map = new HashMap<String, String>();  
	    for (String param : params)  
	    {  
	        String name = param.split("=")[0];  
	        String value = param.split("=")[1];  
	        map.put(name, value);  
	    }  
	    return map;  
	}
	
	/**
	 * Formats a string to an SQL-safe string.
	 * @param str a string of the value being used in a query.
	 * @return An SQL-safe value of the string.
	 */
	public static String formatString(String str)
	{
		return str.replace("'", "''");
	}
	
	/**
	 * Executes a write-only SQL statement in the default database.
	 * @param sql a write string to be executed.
	 * @return An error as a string, if any. Otherwise, an empty string if successful.
	 */
	public static String executeUpdate(String sql) {
		return Database.executeUpdate(sql, Database.AUTH_DB);
	}
	/**
	 * Executes a write-only SQL statement in the given database.
	 * @param sql a write string to be executed.
	 * @param dbName a string of the database location.
	 * @return An error as a string, if any. Otherwise, an empty string if successful.
	 */
	public static String executeUpdate(String sql, String dbName)
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
			connection = DriverManager.getConnection("jdbc:sqlite:" + dbName);
			
			Statement statement = connection.createStatement();
			statement.setQueryTimeout(30);  // set timeout to 30 sec.
			
			statement.executeUpdate(sql);
		}
	    catch (SQLException e)
	    {
	    	System.err.println(e.getMessage());
	    	err = e.getMessage();
	    	if (err.indexOf("[SQLITE_CONSTRAINT_TRIGGER]") == 0)
	    	{
	    		String fnd = "causing the SQL statement to abort (";
	    		err = err.substring(err.indexOf(fnd)+fnd.length());
	    		err = err.substring(0,err.length()-1);
	    	}
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
	
	/**
	 * Executes a read-only SQL statement in the default database and returns of list of maps of the results.
	 * @param sql a read string to be executed.
	 * @return A list, where each item is a row of the results, of maps, where each key in the map is a column and the value is the cell value.
	 */
	public static List<Map<String, Object>> executeQuery(String sql)
	{
		//System.out.println(AUTH_DB);
		return Database.executeQuery(sql, Database.AUTH_DB);
	}
	/**
	 * Executes a read-only SQL statement in the diven database and returns of list of maps of the results.
	 * @param sql a read string to be executed.
	 * @param dbName a string of the database location.
	 * @return A list, where each item is a row of the results, of maps, where each key in the map is a column and the value is the cell value.
	 */
	public static List<Map<String, Object>> executeQuery(String sql, String dbName)
	{
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
			connection = DriverManager.getConnection("jdbc:sqlite:" + dbName);
			
			Statement statement = connection.createStatement();
			statement.setQueryTimeout(30);  // set timeout to 30 sec.
			
			ResultSet resultset = statement.executeQuery(sql);
			
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
}
