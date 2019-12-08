package testing;

import static org.junit.Assert.assertEquals;

import java.util.concurrent.TimeUnit;

import org.junit.BeforeClass;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class DatabaseTests {
	
	/**
	 * The WebDriver used for testing.
	 */
	static WebDriver driver;
	
	static String loc = "C:\\Users\\bryce\\eclipse-workspace\\Capstone\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Capstone\\Databases\\db.db";
	/**
	 * Opens the WebDriver browser.
	 */
	@BeforeClass
	public static void openBrowser() {
		System.setProperty("webdriver.chrome.driver", "./TestingUtils/chromedriver.exe");
		driver = new ChromeDriver();
		//let webpage load in
		driver.manage().timeouts().implicitlyWait(7, TimeUnit.SECONDS);
		driver.manage().window().maximize();
	}
	
	@Test
	public void test2_checkLoginInsertAndLogin() {
		
	}
}