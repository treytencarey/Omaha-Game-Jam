package testing;

import static org.junit.Assert.assertEquals;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.TimeUnit;

import org.junit.BeforeClass;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.Keys;

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class EventTests {
	
	/**
	 * The WebDriver used for testing.
	 */
	static WebDriver driver;
	
	/**
	 * The email and password of the account to test.
	 */
	static String junitEmail, junitPass;
	
	@BeforeClass
	public static void setup() throws InterruptedException {
		driver = TestFunctions.openBrowser(driver);
		
		TestFunctions.goToHomepage(driver);
		/**
		 * Login account to prepare for tests
		 */
		TestFunctions.loginAdmin(driver);
	}
	
	/**
	 * Tests to see what happens when very large inputs are put into Add Event fields
	 */
	@Test
	public void test1_checkLargeInputs() {
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MM/dd/yyyy");
		String currentDate = dtf.format(LocalDateTime.now());
		String endDate = dtf.format(LocalDateTime.now().plusDays(3));
		
		TestFunctions.goToPage(driver, "http://localhost:8080/Capstone/Events");
		driver.findElement(By.id("addEventBtn")).click();
		driver.findElement(By.name("title")).sendKeys(TestFunctions.generateLongString(200));
		driver.findElement(By.name("theme")).sendKeys(TestFunctions.generateLongString(200));
		
		//Selenium has trouble finding niceditor, so gotta do a little hack here
		driver.findElement(By.name("theme")).click();
		driver.findElement(By.name("theme")).sendKeys(Keys.TAB);
		driver.switchTo().activeElement().sendKeys(TestFunctions.generateLongString(800));
		
		driver.findElement(By.id("eventImage")).sendKeys("C:/Users/bryce/eclipse-workspace/Capstone/Capstone/TestingUtils/TestImages/smallapple.png");
		driver.findElement(By.id("addMutatorBtn")).click();
		driver.findElement(By.name("mutator")).sendKeys(TestFunctions.generateLongString(200));
		driver.findElement(By.name("mutatorDescription")).sendKeys(TestFunctions.generateLongString(200));
		driver.findElement(By.id("startDate")).sendKeys(currentDate);
		driver.findElement(By.id("endDate")).sendKeys(endDate);
		driver.findElement(By.name("newEventButton")).click();
		
	}
}
