import time
def w():
    z=0
    while True:    
        with open("C:\\QTtemplate\\Test\\test.txt", 'w+') as f:      
            print(str(z), file = f)
        f.close()    
        z = z+1  
        time.sleep(1)
w()        