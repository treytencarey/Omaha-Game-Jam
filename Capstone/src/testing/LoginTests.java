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

/**
 * 
 * Handles instructions for site testing.
 *
 */
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class LoginTests {
	/**
	 * The URL of the site to test.
	 */
	String testingUrl = "http://localhost:8080/Capstone/";
	/**
	 * The email and password of the account to test.
	 */
	static String junitEmail, junitPass;
	/**
	 * The WebDriver used for testing.
	 */
	static WebDriver driver;
	
	/**
	 * Opens the WebDriver browser.
	 */
	@BeforeClass
	public static void setup() {
		driver = TestFunctions.openBrowser(driver);
		junitEmail = TestFunctions.generateRandomLogin();
		junitPass = TestFunctions.generatePassword();
	}
	
	/**
	 * Tests that the URL is correct.
	 */
	@Test
	public void test1_testUrl() {
		TestFunctions.goToPage(driver, "http://localhost:8080/Capstone/");
		assertEquals(driver.getCurrentUrl(), "http://localhost:8080/Capstone/");
	}
	
	/**
	 * Tests to see if the registration fails due to invalid email.
	 */
	@Test
	public void test2_noAtSignInRegister() {
		String noAtEmail = junitEmail.replace("@", "");
		
		enterRegister(noAtEmail, junitPass);
		assertEquals(true, TestFunctions.checkIfElementExists(driver, "registerBtn", true)); //register button element should still be on page since invalid email was entered
	}
	
	/**
	 * Tests if registration succeeds or fails.
	 */
	@Test
	public void test4_registerTest() {
		String userbarText;
		TestFunctions.goToPage(driver, "http://localhost:8080/Capstone/");
		
		enterRegister(junitEmail, junitPass);
		userbarText = driver.findElement(By.id("accountBtn")).getText();
		
		//test if user bar has the 'logged in as' text, indicating a successful login
		assertEquals(true, userbarText.contains(junitEmail));
	}
	
	/**
	 * Checks if logout works
	 */
	@Test
	public void test5_logoutTest() {
		driver.findElement(By.id("accountBtn")).click();
		driver.findElement(By.id("logoutBtn")).click();
		
		assertEquals(true, TestFunctions.checkIfElementExists(driver, "loginBtn", true));
	}
	
	/**
	 * Tests if the login function works on all pages
	 */
	@Test
	public void test6_testLoginOnAllPages() {
		String[] pages = {"http://localhost:8080/Capstone/", "http://localhost:8080/Capstone/Events", "http://localhost:8080/Capstone/Games", "http://localhost:8080/Capstone/Gallery", "http://localhost:8080/Capstone/News"};
		
		for(int i = 0; i  < pages.length; i++) {
			TestFunctions.goToPage(driver, pages[i]);
			enterLogin(junitEmail, junitPass);
			assertEquals(true, TestFunctions.checkIfElementExists(driver, "accountBtn", true));
			driver.findElement(By.id("accountBtn")).click();
			driver.findElement(By.id("logoutBtn")).click();
		}
	}
	
	/**
	 * Enters the given login information to the site form.
	 * @param n a string value of the email (username).
	 * @param p a string of the password.
	 */
	private void enterLogin(String n, String p) {
		driver.findElement(By.id("loginBtn")).click();
		driver.findElement(By.name("email")).sendKeys(n);
		driver.findElement(By.name("password")).sendKeys(p);
		driver.findElement(By.id("modalLoginBtn")).click();
	}
	
	private void enterRegister(String n, String p) {
		driver.findElement(By.id("loginBtn")).click();
		driver.findElement(By.xpath("//a[@href='#registerModal']")).click();
		driver.findElement(By.id("validationEmail")).sendKeys(n);
		driver.findElement(By.id("validationPass1")).sendKeys(p);
		driver.findElement(By.id("validationPass2")).sendKeys(p);
		driver.findElement(By.id("registerBtn")).click();
	}
}
