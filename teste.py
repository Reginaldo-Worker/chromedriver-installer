from selenium import webdriver
import time

# Definir navegador
navegador = webdriver.Chrome()

# Definir um site
navegador.get("https://www.google.com.br/")

time.sleep(10)

navegador.quit()
