package testing;

import java.io.File;
import java.io.IOException;
import java.util.Random;
import java.util.concurrent.TimeUnit;

import org.apache.commons.io.FileUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
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
		driver.manage().timeouts().implicitlyWait(2, TimeUnit.SECONDS);
		driver.manage().window().maximize();
		return driver;
	}
	
	/**
	 * Makes web browser go to given URL
	 * @param driver
	 * @param url
	 */
	public static void goToPage(WebDriver driver, String url) {
		driver.get(url);
	}
	
	/**
	 * Takes a screenshot of the page and saves it.
	 * @param filename a string of the file location to save to.
	 */
	public static void takeScreenshot(WebDriver driver, String filename) {
		String loc = "./TestingUtils/TestingScreenshots/" + filename;
		File f = ((TakesScreenshot)driver).getScreenshotAs(OutputType.FILE);
		try {
			FileUtils.copyFile(f, new File(loc));
		} catch(IOException e) {
			System.out.println(e.getMessage());
		}
	}
	
	/**
	 * Checks if the given element exists.
	 * @param driver
	 * @param n the string of the element's name.
	 * @param id - enter true to check for the id, otherwise check for name
	 * @return True if the element exists, otherwise false.
	 */
	public static boolean checkIfElementExists(WebDriver driver, String n, boolean id) {
		try {
			if(id)
				return driver.findElement(By.id(n)).isDisplayed();
			else
				return driver.findElement(By.name(n)).isDisplayed();
		} catch(NoSuchElementException e) {
			return false;
		}
	}
	
	/**
	 * Generates a random login
	 * @return String for login email
	 */
	public static String generateRandomLogin() {
		Random random = new Random();
		return random.nextInt(9999999) + "@test.com";
	}
	
	/**
	 * Generates a random password
	 * @return String for password
	 */
	public static String generatePassword() {
		Random random = new Random();
		return "TestPassword!" + random.nextInt(99);
	}
}
