import random
import sys

from PyQt5.QtWidgets import *
from PyQt5 import uic, QtGui, QtCore

# UI파일 연결
# 단, UI파일은 Python 코드 파일과 같은 디렉토리에 위치해야한다.
form_class = uic.loadUiType("myomoc02.ui")[0]


def insertresult(dol, win):
    import cx_Oracle

    conn = cx_Oracle.connect('python/python@localhost:1521/xe')
    cur = conn.cursor()
    cur.execute("SELECT NVL(MAX(PAN) + 1, 1) FROM OMOK")
    pan = list(cur)[0][0]

    sql = "INSERT INTO OMOK (PAN, PSEQ, HISTORY, WIN) VALUES(" + str(pan) + ", :V_col01, :V_col02, " + str(win) + ")"

    count = 0
    rowcount = 0
    history = ['0' for _ in range(WindowClass.XY * WindowClass.XY)]
    for index, color in dol:
        count += 1
        history[index] = str(color)
        cur.execute(sql, (str(count), "".join(history)))
        rowcount += cur.rowcount

    print(rowcount, "개 행이 추가되었습니다.")
    conn.commit()
    cur.close()
    conn.close()


# 화면을 띄우는데 사용되는 Class 선언
class WindowClass(QMainWindow, form_class):
    XY = 19

    def __init__(self):
        super().__init__()
        self.setupUi(self)

        self.X, self.Y = WindowClass.XY, WindowClass.XY  # 가로 및 세로 길이 지정 ( x 좌표의 범위, y 좌표의 범위 )

        self.array2D = [[0 for _ in range(self.X)] for _ in range(self.Y)]

        self.pb2d = list()
        self.dol = list()
        for i in range(self.Y):
            line = list()
            for j in range(self.X):
                temp = QPushButton(self)
                temp.setGeometry(j * 40, i * 40, 40, 40)
                temp.setIcon(QtGui.QIcon("0.png"))
                temp.setIconSize(QtCore.QSize(40, 40))
                # temp.setToolTip(str(i) + "," + str(j))
                temp.clicked.connect(self.myclick)
                line.append(temp)
            self.pb2d.append(line)
        self.myrender()

        self.flag_wb = True
        self.flag_ing = True
        self.pb.clicked.connect(self.myreset)

    def myrender(self):
        for i in range(len(self.array2D)):
            for j in range(len(self.array2D)):
                self.pb2d[i][j].setIcon(QtGui.QIcon(str(self.array2D[i][j]) + ".png"))

    def yourclick(self):
        int_i, int_j = random.randrange(0, WindowClass.XY), random.randrange(0, WindowClass.XY)
        if self.array2D[int_i][int_j]:
            self.yourclick()
            return

        if self.flag_wb:
            int_stone = 1
        else:
            int_stone = 2

        self.array2D[int_i][int_j] = int_stone
        self.myrender()
        self.dol.append((int_i * self.X + int_j, int_stone))
        self.flag_wb = not self.flag_wb

        if self.calc(int_j, int_i, int_stone, self.up) + 1 + self.calc(int_j, int_i, int_stone, self.down) == 5 \
                or self.calc(int_j, int_i, int_stone, self.left) + 1 + self.calc(int_j, int_i, int_stone, self.right) == 5 \
                or self.calc(int_j, int_i, int_stone, self.upleft) + 1 + self.calc(int_j, int_i, int_stone, self.downright) == 5 \
                or self.calc(int_j, int_i, int_stone, self.downleft) + 1 + self.calc(int_j, int_i, int_stone, self.upright) == 5:
            self.flag_ing = False
            if int_stone == 1:
                QMessageBox.about(self, "흰색 승", "흰색 돌이 이겼습니다.")
            else:
                QMessageBox.about(self, "흑색 승", "흑색 돌이 이겼습니다.")
            try:
                insertresult(self.dol, int_stone)
            except Exception as e:
                print(e)
        return

    def myclick(self):
        if not self.flag_ing:
            QMessageBox.about(self, "게임 종료", "reset 버튼을 눌러 게임을 다시 실행하세요.")
            return

        int_i, int_j = self.find_ij()

        # int_i, int_j = map(int, self.sender().toolTip().split(','))

        if self.array2D[int_i][int_j]:
            QMessageBox.about(self, "알림", "이미 입력된 좌표입니다.")
            return

        if self.flag_wb:
            int_stone = 1
        else:
            int_stone = 2

        self.array2D[int_i][int_j] = int_stone
        self.myrender()
        self.dol.append((int_i * self.X + int_j, int_stone))
        self.flag_wb = not self.flag_wb

        if self.calc(int_j, int_i, int_stone, self.up) + 1 + self.calc(int_j, int_i, int_stone, self.down) == 5 \
                or self.calc(int_j, int_i, int_stone, self.left) + 1 + self.calc(int_j, int_i, int_stone, self.right) == 5 \
                or self.calc(int_j, int_i, int_stone, self.upleft) + 1 + self.calc(int_j, int_i, int_stone, self.downright) == 5 \
                or self.calc(int_j, int_i, int_stone, self.downleft) + 1 + self.calc(int_j, int_i, int_stone, self.upright) == 5:
            self.flag_ing = False
            if int_stone == 1:
                QMessageBox.about(self, "흰색 승", "흰색 돌이 이겼습니다.")
            else:
                QMessageBox.about(self, "흑색 승", "흑색 돌이 이겼습니다.")
            try:
                insertresult(self.dol, int_stone)
            except Exception as e:
                print(e)
            return
        self.yourclick()

    def calc(self, x, y, stone, define):
        count = 0
        while True:
            x, y = define(x, y)
            if x < 0 or y < 0 or x >= self.X or y >= self.Y or self.array2D[y][x] != stone:
                break
            count += 1
        return count

    def up(self, x, y):
        return x, y - 1

    def down(self, x, y):
        return x, y + 1

    def left(self, x, y):
        return x - 1, y

    def right(self, x, y):
        return x + 1, y

    def upleft(self, x, y):
        return x - 1, y - 1

    def upright(self, x, y):
        return x + 1, y - 1

    def downleft(self, x, y):
        return x - 1, y + 1

    def downright(self, x, y):
        return x + 1, y + 1

    def find_ij(self):
        for i in range(self.Y):
            for j in range(self.X):
                if self.pb2d[i][j] is self.sender():
                    return i, j

    def myreset(self):
        self.array2D = [[0 for _ in range(self.X)] for _ in range(self.Y)]
        self.dol = list()
        self.myrender()
        self.flag_ing = True
        self.flag_wb = True
        print("게임을 다시 시작합니다.")


if __name__ == "__main__":
    # QApplication : 프로그램을 실행시켜주는 클래스
    app = QApplication(sys.argv)

    # WindowClass의 인스턴스 생성
    myWindow = WindowClass()

    # 프로그램 화면을 보여주는 코드
    myWindow.show()

    # 프로그램을 이벤트루프로 진입시키는(프로그램을 작동시키는) 코드
    app.exec_()