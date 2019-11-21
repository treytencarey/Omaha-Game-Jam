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

import org.junit.BeforeClass;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;
import org.openqa.selenium.WebDriver;

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class DatabaseTests {
	
	/**
	 * The WebDriver used for testing.
	 */
	static WebDriver driver;
	
	Statement statement;
	String loc = "C:\\Users\\bryce\\eclipse-workspace\\Capstone\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Capstone\\Databases\\db.db";
	
	static Connection connection;
	/**
	 * Opens the WebDriver browser.
	 */
	@BeforeClass
	public static void openBrowser() {
		System.setProperty("webdriver.chrome.driver", "./TestingUtils/chromedriver.exe");
		//driver = new ChromeDriver();
		//let webpage load in
		//driver.manage().timeouts().implicitlyWait(7, TimeUnit.SECONDS);
		//driver.manage().window().maximize();
	}
	
	@Test
	public void test1_checkDatabaseNotNull() throws ClassNotFoundException, SQLException {
		System.out.println(executeQuery("SELECT * From Blogs"));
	}
	
	public List<Map<String, Object>> executeQuery(String q) throws SQLException, ClassNotFoundException {
		Class.forName("org.sqlite.JDBC");
		statement = DriverManager.getConnection("jdbc:sqlite:" +  loc).createStatement();
		statement.setQueryTimeout(30);  // set timeout to 30 sec.
		statement.executeUpdate(q);
		statement.close();
		
		ResultSet resultset = statement.executeQuery(q);
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		
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
	    
	    return resultList;
	}
	
	public static void initializeDatabase() {
		//Database.executeUpdate("INSERT INTO Blogs (Title, Header) VALUES('Testboy', 'Bigtestboy')");
		//mockStatic(Database.class);
		//System.out.println(Database.executeQuery("SELECT * From Blogs", "jdbc:sqlite:/WebContent/Databases/db.db"));
	}
}
