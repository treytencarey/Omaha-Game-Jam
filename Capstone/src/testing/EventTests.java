package testing;

import org.junit.BeforeClass;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class EventTests {
	/**
	 * The WebDriver used for testing.
	 */
	static WebDriver driver;
	
	@BeforeClass
	public static void setup() throws InterruptedException {
		driver = TestFunctions.openBrowser(driver);
		
		TestFunctions.goToHomepage(driver);
		/**
		 * Login account to prepare for tests
		 */
		TestFunctions.loginAdmin(driver);
		Thread.sleep(500);
		driver.findElement(By.id("detailsBtn")).click();
	}
	
	@Test
	public void test1_editEvent() {
		driver.findElement(By.id("viewEventsBtn")).click();
		//TODO: Find element with highest value
		driver.findElement(By.xpath("//button[@value='3.2']"));
	}
}
