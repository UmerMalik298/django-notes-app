from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from webdriver_manager.chrome import ChromeDriverManager

class TestWebApp:
    def setup_method(self):
        chrome_options = Options()
        chrome_options.add_argument("--headless")
        chrome_options.add_argument("--no-sandbox")
        chrome_options.add_argument("--disable-dev-shm-usage")
        
        self.driver = webdriver.Chrome(
            service=Service(ChromeDriverManager().install()), 
            options=chrome_options
        )
        self.driver.get("http://localhost:8000")  # Your app URL
    
    def test_page_title(self):
        assert "Notes App" in self.driver.title
    
    def test_login_page_exists(self):
        try:
            login_element = self.driver.find_element(By.ID, "login-form")
            assert login_element is not None
        except:
            assert False, "Login form not found"
    
    def teardown_method(self):
        self.driver.quit()
