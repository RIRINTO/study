class Human:
    def __init__(self):
        self.name = "홍길동"
        print("constructor")
    def __del__(self):
        print("destructor")

if __name__ == '__main__':
    a = Human()
    b = Human()