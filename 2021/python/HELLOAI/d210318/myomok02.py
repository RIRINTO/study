import sys
from PyQt5.QtWidgets import *
from PyQt5 import uic, QtGui, QtCore
import cx_Oracle
import numpy as np
from tensorflow.keras.models import load_model

model = load_model('models/20201213_202430.h5')


def getIJFromAI(input_n):
    input_n = np.reshape(input_n, (1, 20, 20, 1))
    output = model.predict(input_n).squeeze()
    input_n = np.reshape(input_n, (20, 20))
    output = output.reshape((20, 20))
    for i in range(20):
        for j in range(20):
            if input_n[i][j]:
                output[i][j] = 0
    output_y, output_x = np.unravel_index(np.argmax(output), output.shape)
    return output_y, output_x


def getMax():
    conn = cx_Oracle.connect('python/python@localhost:1521/xe')
    cs = conn.cursor()
    rs = cs.execute('select nvl(max(pan)+1,1) as maxpan from omok')
    max_pan = 0
    for record in rs:
        max_pan = int(record[0])
    cs.close()
    conn.close()
    return max_pan


def writeHistory(pan, history, win):
    conn = cx_Oracle.connect('python/python@localhost:1521/xe')
    cs = conn.cursor()

    sql = "insert into omok (pan,pseq,history,win) values (:1,:2,:3,:4)"

    for i, h in enumerate(history):
        cs.execute(sql, (pan, i, h, win))

    cs.close()
    conn.commit()
    conn.close()


form_class = uic.loadUiType("myomok02.ui")[0]


class WindowClass(QMainWindow, form_class):

    def __init__(self):
        super().__init__()
        self.setupUi(self)
        self.history = []
        self.flag_wb = True
        self.flag_ing = True
        self.pb2d = []
        self.arr2d = np.zeros((20, 20), dtype=int)

        for i in range(20):
            line = []
            for j in range(20):
                temp = QPushButton("", self)
                temp.setIcon(QtGui.QIcon('0.png'))
                temp.setGeometry(j * 40, i * 40, 40, 40)
                temp.setIconSize(QtCore.QSize(40, 40))
                temp.setToolTip(str(i) + "," + str(j))
                temp.clicked.connect(self.myclick)
                line.append(temp)
            self.pb2d.append(line)
        self.pb.clicked.connect(self.myreset)
        self.myrender()

    def myreset(self):
        self.flag_wb = True
        self.flag_ing = True
        for i in range(20):
            for j in range(20):
                self.arr2d[i][j] = 0

        self.history.clear()
        self.myrender()

    def myrender(self):
        for i in range(20):
            for j in range(20):
                if self.arr2d[i][j] == 0:
                    self.pb2d[i][j].setIcon(QtGui.QIcon('0.png'))
                if self.arr2d[i][j] == 1:
                    self.pb2d[i][j].setIcon(QtGui.QIcon('1.png'))
                if self.arr2d[i][j] == 2:
                    self.pb2d[i][j].setIcon(QtGui.QIcon('2.png'))

    def myclick(self):
        if not self.flag_ing:
            return

        str_ij = self.sender().toolTip()
        arr_ij = str_ij.split(",")
        int_i = int(arr_ij[0])
        int_j = int(arr_ij[1])

        if self.arr2d[int_i][int_j] > 0:
            return

        int_stone = 0
        if self.flag_wb:
            self.arr2d[int_i][int_j] = 1
            int_stone = 1
        else:
            self.arr2d[int_i][int_j] = 2
            int_stone = 2

        up = self.getUP(int_i, int_j, int_stone)
        dw = self.getDW(int_i, int_j, int_stone)
        le = self.getLE(int_i, int_j, int_stone)
        ri = self.getRI(int_i, int_j, int_stone)

        ur = self.getUR(int_i, int_j, int_stone)
        ul = self.getUL(int_i, int_j, int_stone)
        dr = self.getDR(int_i, int_j, int_stone)
        dl = self.getDL(int_i, int_j, int_stone)

        d1 = up + dw + 1
        d2 = le + ri + 1
        d3 = ur + dl + 1
        d4 = ul + dr + 1

        self.myrender()

        str100 = ""
        for i in range(20):
            for j in range(20):
                str100 += str(self.arr2d[i][j])
        self.history.append(str100)

        if d1 == 5 or d2 == 5 or d3 == 5 or d4 == 5:
            self.flag_ing = False
            win = 0
            if self.flag_wb:
                QMessageBox.about(self, "omok", "????????? ???????????????.")
                win = 1
            else:
                QMessageBox.about(self, "omok", "????????? ???????????????.")
                win = 2

            max_pan = getMax()
            writeHistory(max_pan, self.history, win)
            return

        self.flag_wb = not self.flag_wb

        # ---------------------------------------------------------------------------------------------------------------------------

        #         com_i = 0
        #         com_j = 0
        #
        #         while True:
        #             rnd_i = np.random.randint(0, 20)
        #             rnd_j = np.random.randint(0, 20)
        #             if self.arr2d[rnd_i][rnd_j] == 0:
        #                 com_i = rnd_i
        #                 com_j = rnd_j
        #                 break

        # ---------------------------------------------------------------------------------------------------------------------------

        input_ai = np.zeros((20, 20), dtype=int)

        for i in range(20):
            for j in range(20):
                if self.arr2d[i][j] == 2:
                    input_ai[i][j] = -1
                if self.arr2d[i][j] == 1:
                    input_ai[i][j] = 1

        com_i, com_j = getIJFromAI(input_ai)

        # ---------------------------------------------------------------------------------------------------------------------------

        int_stone = 0
        if self.flag_wb:
            self.arr2d[com_i][com_j] = 1
            int_stone = 1
        else:
            self.arr2d[com_i][com_j] = 2
            int_stone = 2

        up = self.getUP(com_i, com_j, int_stone)
        dw = self.getDW(com_i, com_j, int_stone)
        le = self.getLE(com_i, com_j, int_stone)
        ri = self.getRI(com_i, com_j, int_stone)

        ur = self.getUR(com_i, com_j, int_stone)
        ul = self.getUL(com_i, com_j, int_stone)
        dr = self.getDR(com_i, com_j, int_stone)
        dl = self.getDL(com_i, com_j, int_stone)

        d1 = up + dw + 1
        d2 = le + ri + 1
        d3 = ur + dl + 1
        d4 = ul + dr + 1

        self.myrender()

        str100 = ""
        for i in range(20):
            for j in range(20):
                str100 += str(self.arr2d[i][j])
        self.history.append(str100)

        if d1 == 5 or d2 == 5 or d3 == 5 or d4 == 5:
            self.flag_ing = False
            win = 0
            if self.flag_wb:
                QMessageBox.about(self, "omok", "????????? ???????????????.")
                win = 1
            else:
                QMessageBox.about(self, "omok", "????????? ???????????????.")
                win = 2

            max_pan = getMax()
            writeHistory(max_pan, self.history, win)

        self.flag_wb = not self.flag_wb

    # ---------------------------------------------------------------------------------------------------------------------------

    def getDL(self, int_i, int_j, int_stone):
        cnt = 0
        try:
            while True:
                int_i += +1
                int_j += -1
                if int_i < 0:
                    return cnt
                if int_j < 0:
                    return cnt

                if self.arr2d[int_i][int_j] == int_stone:
                    cnt += 1
                else:
                    return cnt
        except:
            return cnt

    def getDR(self, int_i, int_j, int_stone):
        cnt = 0
        try:
            while True:
                int_i += +1
                int_j += +1
                if int_i < 0:
                    return cnt
                if int_j < 0:
                    return cnt

                if self.arr2d[int_i][int_j] == int_stone:
                    cnt += 1
                else:
                    return cnt
        except:
            return cnt

    def getUL(self, int_i, int_j, int_stone):
        cnt = 0
        try:
            while True:
                int_i += -1
                int_j += -1
                if int_i < 0:
                    return cnt
                if int_j < 0:
                    return cnt

                if self.arr2d[int_i][int_j] == int_stone:
                    cnt += 1
                else:
                    return cnt
        except:
            return cnt

    def getUR(self, int_i, int_j, int_stone):
        cnt = 0
        try:
            while True:
                int_i += -1
                int_j += 1
                if int_i < 0:
                    return cnt
                if int_j < 0:
                    return cnt

                if self.arr2d[int_i][int_j] == int_stone:
                    cnt += 1
                else:
                    return cnt
        except:
            return cnt

    def getRI(self, int_i, int_j, int_stone):
        cnt = 0
        try:
            while True:
                int_j += 1
                if int_i < 0:
                    return cnt
                if int_j < 0:
                    return cnt

                if self.arr2d[int_i][int_j] == int_stone:
                    cnt += 1
                else:
                    return cnt
        except:
            return cnt

    def getLE(self, int_i, int_j, int_stone):
        cnt = 0
        try:
            while True:
                int_j += -1
                if int_i < 0:
                    return cnt
                if int_j < 0:
                    return cnt

                if self.arr2d[int_i][int_j] == int_stone:
                    cnt += 1
                else:
                    return cnt
        except:
            return cnt

    def getUP(self, int_i, int_j, int_stone):
        cnt = 0
        try:
            while True:
                int_i += -1
                if int_i < 0:
                    return cnt
                if int_j < 0:
                    return cnt

                if self.arr2d[int_i][int_j] == int_stone:
                    cnt += 1
                else:
                    return cnt
        except:
            return cnt

    def getDW(self, int_i, int_j, int_stone):
        cnt = 0
        try:
            while True:
                int_i += +1
                if int_i < 0:
                    return cnt
                if int_j < 0:
                    return cnt

                if self.arr2d[int_i][int_j] == int_stone:
                    cnt += 1
                else:
                    return cnt
        except:
            return cnt


if __name__ == "__main__":
    app = QApplication(sys.argv)
    myWindow = WindowClass()
    myWindow.show()
    app.exec_()
