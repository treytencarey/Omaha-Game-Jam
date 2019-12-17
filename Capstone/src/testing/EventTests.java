package testing;

import static org.junit.Assert.assertEquals;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.junit.BeforeClass;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class EventTests {
	/**
	 * The WebDriver used for testing.
	 */
	static WebDriver driver;
	
	/**
	 * Goes to event edit page
	 */
	static String editEventUrl = "http://localhost:8080/Capstone/ViewEventServlet";
	
	@BeforeClass
	public static void setup() throws InterruptedException {
		driver = TestFunctions.openBrowser(driver);
		
		TestFunctions.goToHomepage(driver);
		/**
		 * Login account to prepare for tests
		 */
		TestFunctions.loginAdmin(driver);
		Thread.sleep(500);
	}
	
	/**
	 * Test that all fields correctly display new info/photo when edited
	 * NOTE: Go to edit page of event before
	 */
	@Test
	public void test1_editEvent() throws InterruptedException {
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MM/dd/yyyy");
		String startDate = dtf.format(LocalDateTime.now().plusDays(1));
		String endDate = dtf.format(LocalDateTime.now().plusDays(2));
		
		String title = "titletest";
		String theme = "themetest";
		String description = "descriptiontest";
		String mutator = "testmutator";
		String mutatorDescription = "testmutatordescription";
		TestFunctions.goToPage(driver, editEventUrl);
		Thread.sleep(500);
		
		driver.findElement(By.name("title")).clear();
		driver.findElement(By.name("title")).sendKeys(title);
		driver.findElement(By.name("theme")).clear();
		driver.findElement(By.name("theme")).sendKeys(theme);
		driver.findElement(By.name("theme")).click();
		driver.findElement(By.name("theme")).sendKeys(Keys.TAB);
		driver.switchTo().activeElement().clear();
		driver.switchTo().activeElement().sendKeys(description);
		driver.findElement(By.id("eventImage")).sendKeys("C:/Users/bryce/eclipse-workspace/Capstone/Capstone/TestingUtils/TestImages/smallapple.png");

		driver.findElement(By.name("mutator")).clear();
		driver.findElement(By.name("mutator")).sendKeys(mutator);
		driver.findElement(By.name("mutatorDescription")).clear();
		driver.findElement(By.name("mutatorDescription")).sendKeys(mutatorDescription);
		driver.findElement(By.id("startDate")).clear();
		driver.findElement(By.id("startDate")).sendKeys(startDate);
		driver.findElement(By.id("endDate")).clear();
		driver.findElement(By.id("endDate")).sendKeys(endDate);
		driver.findElement(By.id("submitEventButton")).click();
		driver.switchTo().alert().accept();
		
		TestFunctions.goToPage(driver, "http://localhost:8080/Capstone/Events");
		Thread.sleep(500);
		assertEquals(true, driver.getPageSource().contains(title));
		assertEquals(true, driver.getPageSource().contains(theme));
		assertEquals(true, driver.getPageSource().contains(description));
		assertEquals(true, driver.getPageSource().contains(mutator));
		assertEquals(true, driver.getPageSource().contains(mutatorDescription));
		assertEquals(true, driver.getPageSource().contains(startDate));
		assertEquals(true, driver.getPageSource().contains(endDate));
	}
}
