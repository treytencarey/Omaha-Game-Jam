package testing;

import static org.junit.Assert.assertEquals;

import java.util.concurrent.TimeUnit;

import org.junit.BeforeClass;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

public class RunTests {
	String testingUrl = "http://localhost:8080/Capstone/";
	static WebDriver driver;
	
	@BeforeClass
	public static void openBrowser() {
		System.setProperty("webdriver.chrome.driver", "./TestingUtils/chromedriver.exe");
		driver = new ChromeDriver();
		//let webpage load in
		driver.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS);
	}
	
	@Test
	public void testUrl() {
		driver.get(testingUrl);
		//testing to ensure that driver is functioning properly with JUnit
		assertEquals(driver.getCurrentUrl(), "http://localhost:8080/Capstone/");
	}
}
