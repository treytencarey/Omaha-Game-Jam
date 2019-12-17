package testing;

import static org.junit.Assert.assertEquals;

import org.junit.BeforeClass;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class EventRSVPTests {
	/**
	 * The WebDriver used for testing.
	 */
	static WebDriver driver;
	
	/**
	 * Generate an array of logins to be used for testing multiple users signing up to an event
	 */
	static String[] testLogins;
	static String testPassword;
	static int numberOfLogins;
	
	@BeforeClass
	public static void setup() throws InterruptedException {
		numberOfLogins = 5;
		testPassword = "Testpassword15$";
		testLogins = new String[numberOfLogins];
		for(int i = 0; i < numberOfLogins; i++)
			testLogins[i] = TestFunctions.generateRandomLogin();
		driver = TestFunctions.openBrowser(driver);
		
		TestFunctions.goToHomepage(driver);
	}
	
	@Test
	public void test1_createAndRSVPAccounts() throws InterruptedException {
		for(int i = 0; i < numberOfLogins; i++) {
			driver.navigate().refresh();
			driver.findElement(By.id("loginBtn")).click();
			driver.findElement(By.linkText("Create account")).click();
			driver.findElement(By.id("validationEmail")).sendKeys(testLogins[i]);
			driver.findElement(By.id("validationPass1")).sendKeys(testPassword);
			driver.findElement(By.id("validationPass2")).sendKeys(testPassword);
			driver.findElement(By.id("registerBtn")).click();
			driver.navigate().refresh();
			driver.findElement(By.id("RSVPButton")).click();
			driver.findElement(By.id("loggedInAccountBtn")).click();
			driver.findElement(By.id("logoutBtn")).click();
			
		}
		driver.navigate().refresh();
		Thread.sleep(500);
		assertEquals(true, driver.getPageSource().contains(numberOfLogins + " other Jammers have RSVP'd for this Jam."));
	}
	
	@Test
	public void test2_unRSVPAccounts() throws InterruptedException{
		for(int i = 0; i < numberOfLogins - 1; i++) {
			driver.navigate().refresh();
			driver.findElement(By.id("loginBtn")).click();
			driver.findElement(By.name("email")).sendKeys(testLogins[i]);
			driver.findElement(By.name("password")).sendKeys(testPassword);
			driver.findElement(By.id("modalLoginBtn")).click();
			driver.navigate().refresh();
			driver.findElement(By.id("RSVPButton")).click();
			driver.findElement(By.id("loggedInAccountBtn")).click();
			driver.findElement(By.id("logoutBtn")).click();
		}
		driver.navigate().refresh();
		Thread.sleep(500);
		assertEquals(true, driver.getPageSource().contains("1 other Jammers have RSVP'd for this Jam."));
	}

}
