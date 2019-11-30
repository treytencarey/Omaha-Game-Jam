package testing;

import java.util.concurrent.TimeUnit;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

public class TestFunctions {
	/**
	 * Sets up the Chrome browser for testing
	 * @param driver - WebDriver that contains Chrome
	 * @return the driver to be used in testing classes
	 */
	public static WebDriver openBrowser(WebDriver driver) {
		System.setProperty("webdriver.chrome.driver", "./TestingUtils/chromedriver.exe");
		driver = new ChromeDriver();
		// let webpage load in
		driver.manage().timeouts().implicitlyWait(7, TimeUnit.SECONDS);
		driver.manage().window().maximize();
		return driver;
	}
}
