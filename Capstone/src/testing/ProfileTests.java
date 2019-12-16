package testing;

import static org.junit.Assert.assertEquals;

import java.util.concurrent.TimeUnit;

import org.junit.BeforeClass;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class ProfileTests {
	
	/**
	 * The WebDriver used for testing.
	 */
	static WebDriver driver;
	
	/**
	 * The email and password of the account to test.
	 */
	static String junitEmail, junitPass;
	
	@BeforeClass
	public static void setup() {
		driver = TestFunctions.openBrowser(driver);
		junitEmail = TestFunctions.generateRandomLogin();
		junitPass = TestFunctions.generatePassword();
		TestFunctions.goToHomepage(driver);
		/**
		 * Register account to prepare for tests
		 */
		driver.findElement(By.id("loginBtn")).click();
		driver.findElement(By.linkText("Create account")).click();
		driver.findElement(By.id("validationEmail")).sendKeys(junitEmail);
		driver.findElement(By.id("validationPass1")).sendKeys(junitPass);
		driver.findElement(By.id("validationPass2")).sendKeys(junitPass);
		driver.findElement(By.id("registerBtn")).click();
		driver.navigate().refresh();
	}
	
	/**
	 * Test if profile is not created upon account creation
	 */
	@Test
	public void test1_checkNoProfileOnAccCreation() {
		driver.findElement(By.id("loggedInAccountBtn")).click();
		driver.findElement(By.linkText("My Profile")).click();
		assertEquals(true, driver.getPageSource().contains("No profile has been created for this account yet."));
	}
	
	/**
	 * Test to see what happens when a large number of characters are put into profile text fields
	 * Along with a large image upload
	 */
	@Test
	public void test2_checkLargeInputs() throws InterruptedException {
		driver.findElement(By.id("editProfileBtn")).click();
		driver.findElement(By.name("pic")).sendKeys("C:/Users/bryce/eclipse-workspace/Capstone/Capstone/TestingUtils/TestImages/Pleiades_large.jpg");
		driver.findElement(By.name("name")).sendKeys(TestFunctions.generateLongString(200));
		driver.findElement(By.name("bio")).sendKeys(TestFunctions.generateLongString(200));
		driver.findElement(By.name("site")).sendKeys(TestFunctions.generateLongString(200));
		driver.findElement(By.name("skills")).sendKeys(TestFunctions.generateLongString(200));
		driver.findElement(By.name("update")).click();
		Thread.sleep(5000);
		driver.navigate().refresh();
		Thread.sleep(2000);
		TestFunctions.takeScreenshot(driver, "ProfileLargeInputsTest.png");
	}
	
	/**
	 * Test to ensure profile edits work
	 */
	@Test
	public void test3_checkProfileEditing() throws InterruptedException {
		driver.findElement(By.id("editProfileBtn")).click();
		driver.findElement(By.name("pic")).sendKeys("C:/Users/bryce/eclipse-workspace/Capstone/Capstone/TestingUtils/TestImages/smallapple.png");
		String nameTest = TestFunctions.generateLongString(20);
		String bioTest = TestFunctions.generateLongString(20);
		String siteTest = TestFunctions.generateLongString(20);
		String skillsTest = TestFunctions.generateLongString(20);
		
		driver.findElement(By.name("name")).clear();
		driver.findElement(By.name("bio")).clear();
		driver.findElement(By.name("site")).clear();
		driver.findElement(By.name("skills")).clear();
		
		driver.findElement(By.name("name")).sendKeys(nameTest);
		driver.findElement(By.name("bio")).sendKeys(bioTest);
		driver.findElement(By.name("site")).sendKeys(siteTest);
		driver.findElement(By.name("skills")).sendKeys(skillsTest);
		driver.findElement(By.name("update")).click();
		
		Thread.sleep(5000);
		driver.navigate().refresh();
		Thread.sleep(2000);
		TestFunctions.takeScreenshot(driver, "ProfileEditingTest.png");
		
		assertEquals(true, driver.getPageSource().contains(nameTest));
		assertEquals(true, driver.getPageSource().contains(bioTest));
		assertEquals(true, driver.getPageSource().contains(siteTest));
		assertEquals(true, driver.getPageSource().contains(skillsTest));
	}
	
	/**
	 * Test to see what happens when symbols are put in fields
	 */
	@Test
	public void test4_checkSymbolsInFields() throws InterruptedException {
		driver.findElement(By.id("editProfileBtn")).click();
		driver.findElement(By.name("pic")).sendKeys("C:/Users/bryce/eclipse-workspace/Capstone/Capstone/TestingUtils/TestImages/smallapple.png");
		String symbols = TestFunctions.generateSymbolString();
		
		driver.findElement(By.name("name")).clear();
		driver.findElement(By.name("bio")).clear();
		driver.findElement(By.name("site")).clear();
		driver.findElement(By.name("skills")).clear();
		
		driver.findElement(By.name("name")).sendKeys(symbols);
		driver.findElement(By.name("bio")).sendKeys(symbols);
		driver.findElement(By.name("site")).sendKeys(symbols);
		driver.findElement(By.name("skills")).sendKeys(symbols);
		driver.findElement(By.name("update")).click();
		
		driver.navigate().refresh();
		Thread.sleep(2000);
		TestFunctions.takeScreenshot(driver, "ProfileSymbolsTest.png");
		
		assertEquals(true, driver.getPageSource().contains(symbols));
	}
}
