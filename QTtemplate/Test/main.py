import sys
import serial
import os
import re
import datetime
import pymongo
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, Slot, Signal, QTimer, QUrl, QProcess
from PySide2.QtWidgets import QLabel
from PySide2.QtWidgets import QWidget




client = pymongo.MongoClient("mongodb://localhost:27017/")
print(client)
db = client["div"]
collection = db["mycol"]
b = 0
z = 0
a = []
z1baudrate = 2400
z1port = 'COM1'
z1serial = serial.Serial(port=z1port, baudrate=z1baudrate)
class PWpage(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.timer = QTimer()
        self.timer.timeout.connect(lambda: self.setTime())
        #self.timer.timeout.connect(lambda: self.setZ())
        self.timer.timeout.connect(lambda: self.setCom())
        self.timer.start(100)   
        
    printTime = Signal(str)
    def setTime(self):
        now = datetime.datetime.now()
        formatDate = now.strftime("Date:%d/%m/%Y Time: %H:%M:%S %p")
        #print(formatDate)
        self.printTime.emit(formatDate)

    printCom = Signal(str)
    def setCom(self):        
        if z1serial.is_open:
            size = z1serial.inWaiting()
            if size:
                data = z1serial.read(size)
                b = data.decode('ASCII', errors='ignore')
                z = str(b)
                y = re.sub(re.compile(r'[^\d.]+'),',', z)
                for i in range(0,len(y)-1):
                    if(y[i]==','):
                        b=''
                        j=i+1
                        for j in range(i+1,len(y)):
                            if(y[j]==','):
                                break
                            b = b+y[j]
                        b = float(b)  
                    #print(b)
            else:
                print ('no data')
        else:
            print ('z1serial not open')
        com = str(b)
        self.printCom.emit("Weight : "+com+" Kg")    

    textField = ""
    @Slot(str)
    def getTextField(self, text):
        self.textField = text
        a.append(text)
    @Slot()
    def op(self):
        dic = {}
        key = ["name", "age", "datetime", "Weight 1"]
        for i in range(len(a)):
            #print(a[i])
            if(i == 0):
                dic[key[i]] = a[i]
            elif(i==1):
                dic[key[i]] = a[i]
            elif(i==2):
                dic[key[i]] = a[i] 
            elif(i==3):
                dic[key[i]] = a[i]   
        collection.insert_one(dic)    

        a.clear()

if __name__ == "__main__":
    
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    pw = PWpage()
    engine.rootContext().setContextProperty("backend", pw)
    app.setOrganizationName("DS")
    app.setOrganizationDomain("N/A")
    engine.load(os.path.join(os.path.dirname(__file__), "qml/main.qml"))
    
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())

