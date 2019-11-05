package testing;

import static org.junit.Assert.assertEquals;

import java.io.File;
import java.io.IOException;
import java.util.Random;
import java.util.concurrent.TimeUnit;

import org.apache.commons.io.FileUtils;
import org.junit.BeforeClass;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

import database.Database;

/**
 * 
 * Handles instructions for site testing.
 *
 */
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class RunTests {
	/**
	 * The URL of the site to test.
	 */
	String testingUrl = "http://localhost:8080/Capstone/";
	/**
	 * The email (username) of the account to test.
	 */
	static String junitEmail;
	/**
	 * The password of the account to test.
	 */
	String junitPass = "test";
	/**
	 * The WebDriver used for testing.
	 */
	static WebDriver driver;
	
	/**
	 * Opens the WebDriver browser.
	 */
	@BeforeClass
	public static void openBrowser() {
		System.setProperty("webdriver.chrome.driver", "./TestingUtils/chromedriver.exe");
		driver = new ChromeDriver();
		generateRandomLogin();
		//let webpage load in
		driver.manage().timeouts().implicitlyWait(7, TimeUnit.SECONDS);
		driver.manage().window().maximize();
	}
	
	/**
	 * Tests that the URL is correct.
	 */
	@Test
	public void test1_testUrl() {
		goToHomepage();
		assertEquals(driver.getCurrentUrl(), "http://localhost:8080/Capstone/");
	}
	
	/**
	 * Tests to see if the login fails due to invalid email.
	 */
	@Test
	public void test2_noAtSignInEmail() {
		String noAtEmail = junitEmail.replace("@", "");
		
		driver.findElement(By.id("loginBtn")).click();
		enterLogin(noAtEmail, junitPass);
		driver.findElement(By.name("loginButton")).click();
		assertEquals(true, checkIfElementExists("loginButton")); //login button element should still be on page since invalid info was entered
	}
	
	/**
	 * Tests to see if the registration fails due to invalid email.
	 */
	@Test
	public void test3_noAtSignInRegister() {
		goToHomepage();
		String noAtEmail = junitEmail.replace("@", "");
		
		driver.findElement(By.id("loginBtn")).click();
		driver.findElement(By.id("createAccountButton")).click();
		driver.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS);
		driver.findElement(By.id("validationEmail")).sendKeys(noAtEmail);
		driver.findElement(By.id("validationPass1")).sendKeys(junitPass);
		driver.findElement(By.id("validationPass2")).sendKeys(junitPass);
		driver.findElement(By.name("registerButton")).click();
		assertEquals(true, checkIfElementExists("registerButton")); //register button element should still be on page since invalid email was entered
	}
	
	/**
	 * Tests if registration succeeds or fails.
	 */
	@Test
	public void test4_registerTest() {
		String userbarText;
		
		goToHomepage();
		driver.findElement(By.id("loginBtn")).click();
		driver.findElement(By.id("createAccountButton")).click();
		driver.findElement(By.id("validationEmail")).sendKeys(junitEmail);
		driver.findElement(By.id("validationPass1")).sendKeys(junitPass);
		driver.findElement(By.id("validationPass2")).sendKeys(junitPass);
		driver.findElement(By.name("registerButton")).click();
		userbarText = driver.findElement(By.xpath("//ul[contains(@class, 'userbar')]")).getText();
		
		//test if user bar has the 'logged in as' text, indicating a successful login
		assertEquals(true, userbarText.contains("Logged in as " + junitEmail));
	}
	
	/**
	 * Tests if profile successfully sees that no profile has yet been created.
	 */
	@Test
	public void test5_checkForNoProfile() {
		String profileText;
		driver.findElement(By.id("accountDropdown")).click();
		driver.findElement(By.id("myProfileDropdown")).click();
		profileText = driver.findElement(By.xpath("//div[contains(@class, 'container emp-profile')]")).getText();
		
		//account was just created, so there should be no profile created yet
		assertEquals(true, profileText.contains("No profile has been created for this account yet."));
	}
	
	/**
	 * Tests if profile was successfully created with the correct information.
	 */
	@Test
	public void test6_checkIfProfileCreates() {
		String profileHead, profileText, profileWork;
		String testName = "TEST NAME";
		String testBio = "TEST BIO";
		String testSite = "www.google.com";
		String testSkills = "TEST SKILLS";
		
		//edit profile and fill in all fields
		driver.findElement(By.name("btnAddMore")).click();
		driver.findElement(By.name("name")).sendKeys(testName);
		driver.findElement(By.name("bio")).sendKeys(testBio);
		driver.findElement(By.name("site")).sendKeys(testSite);
		driver.findElement(By.name("skills")).sendKeys(testSkills);
		driver.findElement(By.name("update")).click();
		driver.findElement(By.name("btnAddMore")).click();
		
		//get each info area on page
		profileHead = driver.findElement(By.xpath("//div[contains(@class, 'profile-head')]")).getText();
		profileText = driver.findElement(By.xpath("//div[contains(@id, 'home')]")).getText();
		profileWork = driver.findElement(By.xpath("//div[contains(@class, 'profile-work')]")).getText();
		
		//check if all info is as entered
		assertEquals(true, profileHead.contains(testName) && profileHead.contains(testBio) && profileText.contains(testName) && profileText.contains(junitEmail) && profileWork.contains(testSkills));
		takeScreenshot("test6.png");
	}
	
	/*
	 * debugging this one, database query not working properly
	@Test
	public void test7_checkIfProfileIdCorrect() {
		System.out.println(Database.executeQuery("SELECT COUNT(*) FROM Accounts"));
		//assertEquals(true, driver.getCurrentUrl().contains("profile/view?id=" + profId + "?"));
		//System.out.println(profId);
	} */
	
	/**
	 * Fills the profile fields with a bunch of junk data and save to see how it affects the page.
	 */
	@Test
	public void test7_overflowProfileFields() {
		String junkText = "";
		int maxCharacters = 100;
		Random rnd = new Random();
		
		//click edit profile button
		driver.findElement(By.name("btnAddMore")).click();
		
		//clear all fields
		driver.findElement(By.name("name")).clear();
		driver.findElement(By.name("bio")).clear();
		driver.findElement(By.name("site")).clear();
		driver.findElement(By.name("skills")).clear();
		
		//fill text fields with a bunch of junk characters
		for(int i = 0; i < maxCharacters; i++) {
			char rndChar = (char)(rnd.nextInt(26) + 'a');
			junkText = junkText + rndChar;
		}
		driver.findElement(By.name("name")).sendKeys(junkText);
		driver.findElement(By.name("bio")).sendKeys(junkText);
		driver.findElement(By.name("site")).sendKeys(junkText);
		driver.findElement(By.name("skills")).sendKeys(junkText);
		driver.findElement(By.name("update")).click();
		driver.findElement(By.name("btnAddMore")).click();
		
		takeScreenshot("test7.png");
	}
	
	/**
	 * Generates a random email for logging in testing.
	 */
	private static void generateRandomLogin() {
		Random random = new Random();
		junitEmail = random.nextInt(9999999) + "@test.com";
	}
	
	/**
	 * Enters the given login information to the site form.
	 * @param n a string value of the email (username).
	 * @param p a string of the password.
	 */
	private void enterLogin(String n, String p) {
		driver.findElement(By.name("email")).sendKeys(n);
		driver.findElement(By.name("password")).sendKeys(p);
	}
	
	/**
	 * Checks if the given element exists.
	 * @param n the string of the element's name.
	 * @return True if the element exists, otherwise false.
	 */
	private boolean checkIfElementExists(String n) {
		try {
			return driver.findElement(By.name(n)).isDisplayed();
		} catch(NoSuchElementException e) {
			return false;
		}
	}
	
	/**
	 * Sends a redirect to the homepage URL.
	 */
	private void goToHomepage() {
		driver.get(testingUrl);
	}
	
	/**
	 * Takes a screenshot of the page and saves it.
	 * @param filename a string of the file location to save to.
	 */
	private void takeScreenshot(String filename) {
		String loc = "./TestingUtils/TestingScreenshots/" + filename;
		File f = ((TakesScreenshot)driver).getScreenshotAs(OutputType.FILE);
		try {
			FileUtils.copyFile(f, new File(loc));
		} catch(IOException e) {
			System.out.println(e.getMessage());
		}
	}
}
