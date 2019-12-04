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
	 * Tests if registration succeeds or fails.
	 */
	@Test
	public void test2_registerTest() {
		String userbarText;
		TestFunctions.goToPage(driver, "http://localhost:8080/Capstone/");
		
		enterRegister(junitEmail, junitPass);
		userbarText = driver.findElement(By.id("loggedInAccountBtn")).getText();
		
		//test if user bar has the 'logged in as' text, indicating a successful login
		assertEquals(true, userbarText.contains(junitEmail));
	}
	
	/**
	 * Checks if logout works
	 */
	@Test
	public void test3_logoutTest() throws InterruptedException {
		TestFunctions.goToPage(driver, "http://localhost:8080/Capstone/");
		
		driver.findElement(By.xpath("//button[contains(text(),'" + junitEmail + "')]")).click();
		driver.findElement(By.id("logoutBtn")).click();
		
		assertEquals(true, TestFunctions.checkIfElementExists(driver, "loginBtn", true));
	}
	
	/**
	 * Tests if the login function works on all pages
	 */
	@Test
	public void test4_testLoginOnAllPages() {
		String[] pages = {"http://localhost:8080/Capstone/", "http://localhost:8080/Capstone/Events", "http://localhost:8080/Capstone/Games", "http://localhost:8080/Capstone/Gallery", "http://localhost:8080/Capstone/News"};
		
		for(int i = 0; i  < pages.length; i++) {
			TestFunctions.goToPage(driver, pages[i]);
			enterLogin(junitEmail, junitPass);
			TestFunctions.goToPage(driver, pages[i]);
			assertEquals(true, TestFunctions.checkIfElementExists(driver, "loggedInAccountBtn", true));
			driver.findElement(By.id("loggedInAccountBtn")).click();
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
		driver.findElement(By.linkText("Create account")).click();
		driver.findElement(By.id("validationEmail")).sendKeys(n);
		driver.findElement(By.id("validationPass1")).sendKeys(p);
		driver.findElement(By.id("validationPass2")).sendKeys(p);
		driver.findElement(By.id("registerBtn")).click();
	}
}
