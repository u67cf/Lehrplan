import os
from dotenv import load_dotenv
import requests

load_dotenv()

url = "https://sso.tku.edu.tw/ePortfolio/ilifeStuClass.cshtml"
cookie = os.getenv("COOKIE")
print(cookie)

payload = {}
headers = {
  'Cookie': f'{cookie}'
}

response = requests.request("GET", url, headers=headers, data=payload)

print(response.text)

