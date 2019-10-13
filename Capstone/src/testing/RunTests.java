package testing;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.*;
import static org.junit.Assert.assertEquals;

import java.util.concurrent.TimeUnit;

import org.junit.*;
import org.junit.runner.JUnitCore;
import org.junit.runner.Result;
import org.junit.runner.notification.Failure;

public class RunTests {
	String testingUrl = "http://localhost:8080/Capstone/";
	static WebDriver driver;
	
	@BeforeClass
	public static void openBrowser() {
		System.setProperty("webdriver.chrome.driver", "./TestingUtils/chromedriver.exe");
		driver = new ChromeDriver();
		driver.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS);
	}
	
	@Test
	public void testAssert() {
		driver.get(testingUrl);
		//testing to ensure that driver is functioning properly with JUnit
		assertEquals(driver.getCurrentUrl(), "http://localhost:8080/Capstone/");
	}
}
