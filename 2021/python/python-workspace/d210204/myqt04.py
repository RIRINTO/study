import sys
from PyQt5.QtWidgets import *
from PyQt5 import uic

# UI파일 연결
# 단, UI파일은 Python 코드 파일과 같은 디렉토리에 위치해야한다.
form_class = uic.loadUiType("myqt04.ui")[0]


# 화면을 띄우는데 사용되는 Class 선언
class WindowClass(QMainWindow, form_class):
    def __init__(self):
        super().__init__()
        self.setupUi(self)

        # 버튼에 기능을 할당하는 코드
        self.pb.clicked.connect(self.pbFunction)

    def pbFunction(self):
        le1 = self.le1.text()
        le2 = self.le2.text()
        if le1 == "" or le2 == "":
            le3 = "값을 입력해주세요."
        else:
            try:
                int_le1 = int(le1)
                int_le2 = int(le2)
                int_le3 = int_le1 + int_le2
                le3 = str(int_le3)
            except Exception as e:
                le3 = "숫자만 입력해주세요."
                print(e)
        self.le3.setText(le3)


if __name__ == "__main__":
    # QApplication : 프로그램을 실행시켜주는 클래스
    app = QApplication(sys.argv)

    # WindowClass의 인스턴스 생성
    myWindow = WindowClass()

    # 프로그램 화면을 보여주는 코드
    myWindow.show()

    # 프로그램을 이벤트루프로 진입시키는(프로그램을 작동시키는) 코드
    app.exec_()
