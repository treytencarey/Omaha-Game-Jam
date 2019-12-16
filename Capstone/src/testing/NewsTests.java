package testing;

import static org.junit.Assert.assertEquals;

import org.junit.BeforeClass;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class NewsTests {
	/**
	 * The WebDriver used for testing.
	 */
	static WebDriver driver;
	
	static String newsUrl = "http://localhost:8080/Capstone/News";
	static String testTitle, testSubtitle, testBody;
	
	@BeforeClass
	public static void setup() throws InterruptedException {
		driver = TestFunctions.openBrowser(driver);
		
		TestFunctions.goToHomepage(driver);
		/**
		 * Login account to prepare for tests
		 */
		TestFunctions.loginAdmin(driver);
		TestFunctions.goToPage(driver, newsUrl);
	}
	
	/**
	 * Test to see what happens when a large number of characters are put into news article text fields
	 * Along with a large image upload
	 */
	@Test
	public void test1_checkLargeInputs() throws InterruptedException {
		testTitle = TestFunctions.generateLongString(150);
		testSubtitle = TestFunctions.generateLongString(150);
		testBody = TestFunctions.generateLongString(2000);
		driver.findElement(By.id("addArticleBtn")).click();
		driver.findElement(By.name("newsTitle")).sendKeys(testTitle);
		driver.findElement(By.name("newsHeader")).sendKeys(testSubtitle);
		
		//Selenium has trouble finding niceditor, so gotta do a little hack here
		driver.findElement(By.name("newsHeader")).click();
		driver.findElement(By.name("newsHeader")).sendKeys(Keys.TAB);
		driver.switchTo().activeElement().sendKeys(testBody);
		driver.findElement(By.id("newsFile")).sendKeys("C:/Users/bryce/eclipse-workspace/Capstone/Capstone/TestingUtils/TestImages/Pleiades_large.jpg");
		driver.findElement(By.id("newNewsArticleButton")).click();
		Thread.sleep(1000);
		TestFunctions.takeScreenshot(driver, "NewsLargeInputsTest.png");
	}
	
	/**
	 * Test to ensure that articles are not available to non-admins when they are set to not be public
	 */
	@Test
	public void test2_checkNotPublicVisibility() throws InterruptedException {
		driver.findElement(By.id("editArticleBtn")).click();
		Thread.sleep(500);
		driver.findElement(By.name("isPublicCheckbox")).click();
		driver.findElement(By.id("editNewsArticleButton")).click();
		Thread.sleep(1000);
		driver.findElement(By.id("loggedInAccountBtn")).click();
		driver.findElement(By.id("logoutBtn")).click();
		TestFunctions.goToPage(driver, newsUrl);
		
		assertEquals(false, driver.getPageSource().contains(testTitle));
		TestFunctions.takeScreenshot(driver, "NewsPublicTest.png");
	}
	
	/**
	 * Test to ensure that a regular news article from InsertGameHere works when posted on the site
	 */
	@Test
	public void test3_testNormalArticle() throws InterruptedException {
		testTitle = "Spoopy Jam 2019 - \"Tricks & Treats\"";
		testSubtitle = "Come have a spoopy time making games at this year's Spoopy Jam!";
		testBody = TestFunctions.readFileToString("news_article_test.txt");
		TestFunctions.loginAdmin(driver);
		TestFunctions.goToPage(driver, newsUrl);
		driver.findElement(By.id("addArticleBtn")).click();
		driver.findElement(By.name("newsTitle")).sendKeys(testTitle);
		driver.findElement(By.name("newsHeader")).sendKeys(testSubtitle);
		driver.findElement(By.name("newsHeader")).click();
		driver.findElement(By.name("newsHeader")).sendKeys(Keys.TAB);
		driver.switchTo().activeElement().sendKeys(testBody);
		driver.findElement(By.id("newsFile")).sendKeys("C:/Users/bryce/eclipse-workspace/Capstone/Capstone/TestingUtils/TestImages/news_article_image.png");
		driver.findElement(By.id("newNewsArticleButton")).click();
		Thread.sleep(1000);
		TestFunctions.takeScreenshot(driver, "NewsNormalArticleTest.png");
	}
	
	/**
	 * Test that all fields will update when edited
	 */
	@Test
	public void test4_checkEdits() {
		testTitle = TestFunctions.generateLongString(5);
		testSubtitle = TestFunctions.generateLongString(5);
		testBody = TestFunctions.generateLongString(10);
		driver.findElement(By.id("editArticleBtn")).click();
		driver.findElement(By.name("newsTitle")).clear();
		driver.findElement(By.name("newsTitle")).sendKeys(testTitle);
		driver.findElement(By.name("newsHeader")).clear();
		driver.findElement(By.name("newsHeader")).sendKeys(testSubtitle);
		driver.findElement(By.name("newsHeader")).click();
		driver.findElement(By.name("newsHeader")).sendKeys(Keys.TAB);
		driver.switchTo().activeElement().clear();
		driver.switchTo().activeElement().sendKeys(testBody);
		driver.findElement(By.id("newsFile")).sendKeys("C:/Users/bryce/eclipse-workspace/Capstone/Capstone/TestingUtils/TestImages/smallapple.png");
		driver.findElement(By.id("editNewsArticleButton")).click();
		
		assertEquals(true, driver.getPageSource().contains(testTitle));
		assertEquals(true, driver.getPageSource().contains(testSubtitle));
		assertEquals(true, driver.getPageSource().contains(testBody));
	}
	
	/**
	 * Test that article properly deletes
	 */
	@Test
	public void test5_checkDeletion() throws InterruptedException {
		driver.findElement(By.id("deleteArticleBtn")).click();
		Thread.sleep(500);
		driver.findElement(By.id("deleteNewsArticleButton")).click();
		Thread.sleep(1000);
		assertEquals(false, driver.getPageSource().contains(testTitle));
	}
}
