import requests
from bs4 import BeautifulSoup

## HTTP GET Request  86.0.4240.75
req = requests.get('http://localhost/HelloWeb/hello.jsp')
## HTML 소스 가져오기
html = req.text
## BeautifulSoup으로 html소스를 python객체로 변환하기
## 첫 인자는 html소스코드, 두 번째 인자는 어떤 parser를 이용할지 명시.
## 이 글에서는 Python 내장 html.parser를 이용했다.
soup = BeautifulSoup(html, 'html.parser')

my_titles = soup.select(
    'td'
    )
## my_titles는 list 객체
for title in my_titles:
    ## Tag안의 텍스트
    print(title.text)
#     ## Tag의 속성을 가져오기(ex: href속성)
#     print(title.get('href'))