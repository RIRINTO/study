# insert into naver (title,link,category,description,telephone,  address,roadAddress,mapx,mapy)
# values ('1','1','1','1','1', '1','1','1','1')
from bs4 import BeautifulSoup
import os
import sys
import urllib.request
import sqlite3
client_id = "qGGEqJFovPi0TfPB_ynf"
client_secret = "qRanRZRm8P"
encText = urllib.parse.quote("대전대흥동맛집")
url = "https://openapi.naver.com/v1/search/local.xml?display=5&query=" + encText # json 결과
# url = "https://openapi.naver.com/v1/search/blog.xml?query=" + encText # xml 결과
request = urllib.request.Request(url)
request.add_header("X-Naver-Client-Id",client_id)
request.add_header("X-Naver-Client-Secret",client_secret)
response = urllib.request.urlopen(request)
rescode = response.getcode()
if(rescode==200):
    response_body = response.read()
    print(response_body.decode('utf-8'))
else:
    print("Error Code:" + rescode)
    
soup = BeautifulSoup(response_body, 'xml')

myitems = soup.select(
    'item'
)

conn = sqlite3.connect("naver.db", isolation_level=None)
cur = conn.cursor()
sql = "insert into naver (title,link,category,description,telephone,  address,roadAddress,mapx,mapy) values (?,?,?,?,?, ?,?,?,?)"

for item in myitems:
    title = item.find('title').text
    link = item.find('link').text
    category = item.find('category').text
    description = item.find('description').text
    telephone = item.find('telephone').text
    
    address = item.find('address').text
    roadAddress = item.find('roadAddress').text
    mapx = item.find('mapx').text
    mapy = item.find('mapy').text
    cur.execute(sql, (title,link,category,description,telephone, address,roadAddress,mapx,mapy ))
    
    print(title)
    print(mapy)


conn.close()


