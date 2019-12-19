package testing;

import java.awt.List;

import org.junit.BeforeClass;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class GalleryTests {
	/**
	 * The WebDriver used for testing.
	 */
	static WebDriver driver;
	
	@BeforeClass
	public static void setup() throws InterruptedException {
		driver = TestFunctions.openBrowser(driver);
		
		TestFunctions.goToHomepage(driver);
		/**
		 * Login account to prepare for tests
		 */
		TestFunctions.loginAdmin(driver);
		TestFunctions.goToPage(driver, "http://localhost:8080/Capstone/Gallery");
	}
	
	@Test
	public void test_inputImagesForAll() throws InterruptedException {
		for(int i = 0; i < 99; i++) {
			Thread.sleep(500);
			try {
				driver.findElement(By.id("addPhotoBtn")).click();
				driver.findElement(By.id("galleryUploads")).sendKeys("C:/Users/bryce/eclipse-workspace/Capstone/Capstone/TestingUtils/TestImages/Pleiades_large.jpg");
				driver.findElement(By.id("galleryUploads")).sendKeys("C:/Users/bryce/eclipse-workspace/Capstone/Capstone/TestingUtils/TestImages/news_article_image.png");
				driver.findElement(By.id("galleryUploads")).sendKeys("C:/Users/bryce/eclipse-workspace/Capstone/Capstone/TestingUtils/TestImages/smallapple.png");
				Select dropdown = new Select(driver.findElement(By.id("galleryEventKey")));
				dropdown.selectByIndex(i);
				driver.findElement(By.id("addGalleryPhotosButton")).click();
			} catch(Exception e) {
				driver.navigate().refresh();
				break;
			}
		}
	}
}
