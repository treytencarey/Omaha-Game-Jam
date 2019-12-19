package testing;

import static org.junit.Assert.assertEquals;

import org.junit.BeforeClass;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.Select;

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class GameSubmitTests {
	/**
	 * The WebDriver used for testing.
	 */
	static WebDriver driver;
	
	static String login, password;

	@BeforeClass
	public static void setup() {
		login = TestFunctions.generateRandomLogin();
		password = TestFunctions.generatePassword();
		
		driver = TestFunctions.openBrowser(driver);
		TestFunctions.goToHomepage(driver);
		
		driver.findElement(By.id("loginBtn")).click();
		driver.findElement(By.linkText("Create account")).click();
		driver.findElement(By.id("validationEmail")).sendKeys(login);
		driver.findElement(By.id("validationPass1")).sendKeys(password);
		driver.findElement(By.id("validationPass2")).sendKeys(password);
		driver.findElement(By.id("registerBtn")).click();
	}
	
	/**
	 * Checks that games cannot be submitted when the user is not RSVP'd to event
	 */
	@Test
	public void test1_checkSubmitGameWithNoRSVP() {
		driver.findElement(By.linkText("Games")).click();
		driver.findElement(By.id("addGameBtn")).click();
		assertEquals(driver.getCurrentUrl(), "http://localhost:8080/Capstone/Games/#");
	}
	
	/**
	 * Checks that you can't submit a game if you RSVP, then unRSVP
	 */
	@Test
	public void test2_checkSubmitGameWithRSVPAndUnRSVP() throws InterruptedException {
		driver.findElement(By.linkText("Events")).click();
		driver.findElement(By.id("RSVPButton")).click();
		Thread.sleep(500);
		driver.findElement(By.id("RSVPButton")).click();
		driver.findElement(By.linkText("Games")).click();
		driver.findElement(By.id("addGameBtn")).click();
		assertEquals(driver.getCurrentUrl(), "http://localhost:8080/Capstone/Games/#");
	}
	
	/**
	 * Checks to see what happens when very long inputs are put into game submission fields
	 */
	@Test
	public void test3_checkLongInputs() {
		driver.findElement(By.linkText("Events")).click();
		driver.findElement(By.id("RSVPButton")).click();
		driver.findElement(By.linkText("Games")).click();
		driver.findElement(By.id("addGameBtn")).click();
		
		driver.findElement(By.name("title")).sendKeys(TestFunctions.generateLongString(80));
		driver.findElement(By.name("description")).sendKeys(TestFunctions.generateLongString(200));
		driver.findElement(By.name("link")).sendKeys("http://www." + TestFunctions.generateLongString(80) + ".com");
		driver.findElement(By.id("validatedCustomFile1")).sendKeys("C:/Users/bryce/eclipse-workspace/Capstone/Capstone/TestingUtils/TestImages/Pleiades_large.jpg");
		driver.findElement(By.id("validatedCustomFile2")).sendKeys("C:/Users/bryce/eclipse-workspace/Capstone/Capstone/TestingUtils/TestImages/Pleiades_large.jpg");
		driver.findElement(By.id("platformCheck0")).click();
		Select dropdown = new Select(driver.findElement(By.id("toolsSelect")));
		for(int i = 0; i < 5; i++)
			dropdown.selectByIndex(i);
		
		driver.findElement(By.id("add_author_button")).click();
		driver.findElement(By.name("author1")).sendKeys(login);
		dropdown = new Select(driver.findElement(By.name("authorRole1")));
		dropdown.selectByIndex(1);
		driver.findElement(By.name("newGameButton")).click();
		TestFunctions.takeScreenshot(driver, "GameLongInputs.png");
	}
	
	/**
	 * Check that all text on page updates when the game is edited
	 */
	@Test
	public void test4_checkGameEditing() {
		driver.findElement(By.id("editGameBtn")).click();
		driver.findElement(By.name("title")).clear();
		driver.findElement(By.name("title")).sendKeys(TestFunctions.generateLongString(5));
		driver.findElement(By.name("description")).clear();
		driver.findElement(By.name("description")).sendKeys(TestFunctions.generateLongString(5));
		driver.findElement(By.name("link")).clear();
		driver.findElement(By.name("link")).sendKeys("http://www." + TestFunctions.generateLongString(5) + ".com");
		driver.findElement(By.id("validatedCustomFile1")).sendKeys("C:/Users/bryce/eclipse-workspace/Capstone/Capstone/TestingUtils/TestImages/smallapple.png");
		driver.findElement(By.id("validatedCustomFile2")).sendKeys("C:/Users/bryce/eclipse-workspace/Capstone/Capstone/TestingUtils/TestImages/smallapple.png");
		driver.findElement(By.id("platformCheck0")).click();
		Select dropdown = new Select(driver.findElement(By.id("toolsSelect")));
		dropdown.selectByIndex(3);
		driver.findElement(By.name("newGameButton")).click();
		TestFunctions.takeScreenshot(driver, "GameEditing.png");
	}
	
	/**
	 * Test to see if game submission works when abnormal symbols are put into input fields
	 */
	@Test
	public void test5_symbolsInInputs() throws InterruptedException {
		String symbols = TestFunctions.generateSymbolString();
		driver.findElement(By.linkText("Games")).click();
		driver.findElement(By.id("addGameBtn")).click();
		
		driver.findElement(By.name("title")).sendKeys(symbols);
		driver.findElement(By.name("description")).sendKeys(symbols);
		driver.findElement(By.name("link")).sendKeys("http://www." + symbols + ".com");
		driver.findElement(By.id("validatedCustomFile1")).sendKeys("C:/Users/bryce/eclipse-workspace/Capstone/Capstone/TestingUtils/TestImages/Pleiades_large.jpg");
		driver.findElement(By.id("validatedCustomFile2")).sendKeys("C:/Users/bryce/eclipse-workspace/Capstone/Capstone/TestingUtils/TestImages/Pleiades_large.jpg");
		driver.findElement(By.id("platformCheck0")).click();
		Select dropdown = new Select(driver.findElement(By.id("toolsSelect")));
		for(int i = 0; i < 5; i++)
			dropdown.selectByIndex(i);
		
		driver.findElement(By.name("author1")).sendKeys(symbols);
		dropdown = new Select(driver.findElement(By.name("authorRole1")));
		dropdown.selectByIndex(1);
		driver.findElement(By.name("newGameButton")).click();
		
		Thread.sleep(1000);
		assertEquals(true, driver.getPageSource().contains(symbols));
	}
}
