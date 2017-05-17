//
//  main.swift
//  AKIT
//
//  Created by Semyon on 16.04.17.
//  Copyright © 2017 Semyon. All rights reserved.
//

import Foundation

struct point {
    var x = 0
    var y = 0
    var priznak = 0
    var number = 0
    var character: String?
}

var lastMin = [0,1,2,3,4,5,6,7]
var arrayPoint = [point]()
var arrayPointEmpty = [point]()
var n = 0 //Правильно инициализировать первым элментом массива
var m = 0

func initializeMatrixSize(){
    m = arrayPoint[0].x
    n = arrayPoint[0].y
    for i in arrayPoint{
        if i.x + 1 > m {
            m = i.x + 1
        }
        if i.y + 1 > n{
            n = i.y + 1
        }
    }
}

func initializationArrayPointEmpty() {
    for i in (0...(n-1)*2){
        for j in (0...(m-1)*2){
            if (i%2==0){
                if (j%2==0){
                    arrayPointEmpty.append(point(x:j,y:i,priznak:9,number:0,character:"+"))
                }
                else {
                   arrayPointEmpty.append(point(x:j,y:i,priznak:9,number:0,character:"—"))
                }
            } else {
                if (j%2==0){
                    arrayPointEmpty.append(point(x:j,y:i,priznak:9,number:0,character:"|"))
                }
                else {
                    arrayPointEmpty.append(point(x:j,y:i,priznak:9,number:0,character:" "))
                }
            }
        }
    }
}

var flag = false
//Получить элемент из матрицы
func getIndexInputData(xF:Int,yF:Int) -> Int? {
    var index:Int?
    index = nil
    for i in 0..<arrayPoint.count {
        if (xF == arrayPoint[i].x) && (yF==arrayPoint[i].y) {
            index = i
        }
    }
    return index
}

//Получить элемент из пустой матрицы
func getElement(xF:Int,yF:Int) -> point {
    var bufFunc = point(x: 99,y:99, priznak: 99, number: 99, character:"x")
    for i in 0..<arrayPointEmpty.count {
        if (xF == arrayPointEmpty[i].x) && (yF==arrayPointEmpty[i].y) {
            bufFunc = arrayPointEmpty[i]
        }
    }
    return bufFunc
}

//Присваим ячейке матрицы номер
func setDataInArrayEmpty(x: Int, y: Int, number: Int, picCharacter: String) {
    var flag = false
    var k = 0
    while (k<=arrayPointEmpty.count) && (flag == false){
        if (x == arrayPointEmpty[k].x) && (y==arrayPointEmpty[k].y) {
            arrayPointEmpty[k].number = number
            if x%2==0 {
                if y%2==0 {
                    if getIndexInputData(xF: x/2, yF: y/2) != nil {
                        arrayPointEmpty[k].character = "*"
                    } else {
                        arrayPointEmpty[k].character = picCharacter
                    } }else {
                        arrayPointEmpty[k].character = picCharacter
                    }
                
            } else {
                arrayPointEmpty[k].character = picCharacter
            }
            
            flag = true
            print ("Покрасили [\(arrayPointEmpty[k].x)][\(arrayPointEmpty[k].y)] в \(arrayPointEmpty[k].number)")
        }
        k += 1
    }
}

//Функция возвращающая меньший номер из двух
func lessNumberFunc (start:Int, end: Int) -> Int{
    var less = 0
    if (arrayPoint[start].number > arrayPoint[end].number){
        less = arrayPoint[end].number
    } else {
        less = arrayPoint[start].number
    }
    return less
}

//Прокладываем путь и присваиваем номера между двумя точками для признака 0
func makeWay0(start: Int, end: Int) {
    
    var k = 0
    let lessNumber = lessNumberFunc(start: start, end: end)
    
    var greaterNumber = arrayPoint[end].number
    if greaterNumber == lessNumber {
        greaterNumber = arrayPoint[start].number
    }
    
    var yValue = start
    var xValue = end
    if arrayPoint[end].priznak == 0 {
        yValue = end
        xValue = start
    }
    
    if arrayPoint[start].x > arrayPoint[end].x {
        k = arrayPoint[end].x*2
        while (k <= arrayPoint[start].x*2) {
            setDataInArrayEmpty(x: k, y: arrayPoint[yValue].y*2, number: lessNumber, picCharacter: "=")
            k += 1
        }
    } else {
        k = arrayPoint[start].x*2
        while (k <= arrayPoint[end].x*2) {
            setDataInArrayEmpty(x: k, y: arrayPoint[yValue].y*2, number: lessNumber, picCharacter: "=")
            k += 1
        }
    }
    
    if (arrayPoint[start].y > arrayPoint[end].y){
        k = arrayPoint[end].y*2
        while (k<=arrayPoint[start].y*2){
            setDataInArrayEmpty(x: arrayPoint[xValue].x*2, y: k, number: lessNumber, picCharacter: "‖")
            k += 1
        }
    } else {
        k = arrayPoint[start].y*2
        while (k<=arrayPoint[end].y*2){
            setDataInArrayEmpty(x: arrayPoint[xValue].x*2, y: k, number: lessNumber, picCharacter: "‖")
            k += 1
        }
    }
    
    arrayPoint[start].number = lessNumber
    arrayPoint[end].number = lessNumber
    repaintAll(lessNumber: lessNumber, greaterNumber: greaterNumber)
    chaekEnd()
}

//Прокладываем путь и присваимваем номера между двумя точка для признака 1
func makeWay1(start: Int, end: Int) {
    
    var k = 0
    let lessNumber = lessNumberFunc(start: start, end: end)
    
    var greaterNumber = arrayPoint[end].number
    if greaterNumber == lessNumber {
        greaterNumber = arrayPoint[start].number
    }
    
    var xValue = start
    var yValue = end
    if arrayPoint[end].priznak == 1 {
        xValue = end
        yValue = start
    }
    
    if (arrayPoint[start].y > arrayPoint[end].y){
        k = arrayPoint[end].y*2
        while (k<=arrayPoint[start].y*2){
            setDataInArrayEmpty(x: arrayPoint[xValue].x*2, y: k, number: lessNumber, picCharacter: "Y")
            k += 1
        }
    } else {
        k = arrayPoint[start].y*2
        while (k<=arrayPoint[end].y*2){
            setDataInArrayEmpty(x: arrayPoint[xValue].x*2, y: k, number: lessNumber, picCharacter: "Y")
            k += 1
        }
    }
    
    if arrayPoint[start].x > arrayPoint[end].x {
        k = arrayPoint[end].x*2
        while (k <= arrayPoint[start].x*2) {
            setDataInArrayEmpty(x: k, y: arrayPoint[yValue].y*2, number: lessNumber, picCharacter: "=")
            k += 1
        }
    } else {
        k = arrayPoint[start].x*2
        while (k <= arrayPoint[end].x*2) {
            setDataInArrayEmpty(x: k, y: arrayPoint[yValue].y*2, number: lessNumber, picCharacter: "=")
            k += 1
        }
    }
    arrayPoint[start].number = lessNumber
    arrayPoint[end].number = lessNumber
    repaintAll(lessNumber: lessNumber, greaterNumber: greaterNumber)
    chaekEnd()
}

//Докрашиваем матрицу признаками и массив исходных выводов цепи
func repaintAll(lessNumber: Int, greaterNumber: Int) {
    for i in (0..<arrayPointEmpty.count) {
        if arrayPointEmpty[i].number == greaterNumber{
            arrayPointEmpty[i].number = lessNumber
        }
    }
    for i in (0..<arrayPoint.count){
        if arrayPoint[i].number == greaterNumber{
            arrayPoint[i].number = lessNumber
        }
    }
}

func FindSecondMinimum(loopNumber: Int, iLoop: Int) -> Int {
    
    var buf = 0
    var minIndexLoop = 0
    var min = 0
    
    //инициализируем минимум
    if iLoop == arrayPoint.count-1 {
        min = abs(arrayPoint[arrayPoint.count-1].x - arrayPoint[iLoop-1].x) + abs(arrayPoint[arrayPoint.count-1].y - arrayPoint[iLoop-1].y)
        minIndexLoop = iLoop
    } else {
        min = abs(arrayPoint[arrayPoint.count-1].x - arrayPoint[iLoop].x) + abs(arrayPoint[arrayPoint.count-1].y - arrayPoint[iLoop].y)
        minIndexLoop = iLoop
    }
    
    
    for j in 0..<arrayPoint.count {
        if (j != iLoop) && (j != lastMin[iLoop]) {
            buf = abs(arrayPoint[j].x - arrayPoint[iLoop].x) + abs(arrayPoint[j].y - arrayPoint[iLoop].y)
            if (buf <= min)  {
                min = buf
                minIndexLoop = j
                
            }
        }
    }
    lastMin[iLoop] = minIndexLoop
    return minIndexLoop
}

func chaekEnd(){
    let el = arrayPoint[0].number
    var cc = 1
    for i in 1..<arrayPoint.count {
        if arrayPoint[i].number == el {
            cc += 1
        }
    }
    if cc == arrayPoint.count {
        flag = true
    }
}

func prnt(){
    for i in stride(from: 6, to: -1, by: -1)  {
        for j in (0..<5) {
            let q = getElement(xF: j, yF: i)
            if j == 0 {
                print ("\n")
            }
            print(q.number,terminator: " ")
        }
    }
    print("\n")
}

func paint(){
    var q:point
    for i in stride(from: (n-1)*2, to: -1, by: -1)  {
        
        for j in (0...(m-1)*2) {
            q = getElement(xF: j, yF: i)
            if j == 0 {
            }
            print(q.character!,terminator: "")
        }
        print ("")
    }
    print("\n")
}



func filePath() -> URL {
    let documentsDirectory = URL(string:"file:///Users/semen/Desktop/SteinerTree/")!
    let filename = documentsDirectory.appendingPathComponent("input2.txt")
    return filename
}

func readingFromFile() {
    var text2 = ""
    do {
        text2 = try String(contentsOf: filePath(), encoding: String.Encoding.utf8)
        let element = text2.components(separatedBy: "\n")
        for i in element {
            arrayPoint.append(point(x:Int(i.components(separatedBy: " ")[0])!,y:Int(i.components(separatedBy: " ")[1])!,priznak:99,number:99,character:"x"))
        }
    } catch {
        print("Egor")
    }
}

func writengFromFile() {
    var text2 = ""
    
//    do {
//        text2 = try String(contentsOf: URL(string:"file:///Users/semen/Desktop/SteinerTree/")!.appendingPathComponent("output.txt"), encoding: String.Encoding.utf8)
//        let element = text2.components(separatedBy: "\n")
//        for i in element {
//            arrayPoint.append(point(x:Int(i.components(separatedBy: " ")[0])!,y:Int(i.components(separatedBy: " ")[1])!,priznak:99,number:99,character:"x"))
//        }
//    } catch {
//        print("Egor")
//    }
    
  //  if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        
        let path = URL(string:"file:///Users/semen/Desktop/SteinerTree/output.txt")!
        
        //writing
        do {
            var q:point
            for i in stride(from: (n-1)*2, to: -1, by: -1)  {
                
                for j in (0...(m-1)*2) {
                    q = getElement(xF: j, yF: i)
                    if j == 0 {
                    }
                    //print(q.character!,terminator: "")
                    text2.append(q.character!)
                }
                //print ("")
                text2.append("\n")
            }
            //print("\n")
            text2.append("\n")
            
            
            
            //try text2.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            try text2.write(to: path, atomically: false, encoding: String.Encoding.utf8)
        }
        catch {print("qqqqqq")}
    //}
}

func chekNextLineY(y: Int, xStart: Int, xFinish:Int) -> Bool {
    var flag = false
    for i in (xStart...xFinish){
        if getIndexInputData(xF: i,yF: y) != nil {
            flag = true
        }
    }
    return flag
}

func chekNextLineX(x: Int, yStart: Int, yFinish:Int) -> Bool {
    var flagX = false
    for i in (yStart...yFinish){
        if getIndexInputData(xF: x,yF: i) != nil {
            flagX = true
        }
    }
    return flagX
}

func chekEndRead() -> Bool {
    var end = false
    if arrayPoint.last?.number == arrayPoint.count {
        end = true
    }
    return end
}

func initializationOfSigns(){
    var k = 0
    var initializationNumber = 1
    var lastSigns = 0
    var KOSTIL_Y = 0
    var KOSTIL_X = 0
    var elem = 0
    var change = false
    while (arrayPoint.last?.number != arrayPoint.count) {
        k += 1;
        
        if chekEndRead() != true {
            if chekNextLineX(x: k-1, yStart: k-1, yFinish: n-k) == false {
                KOSTIL_X = 1
            }
            for j in (k-1...n-k-KOSTIL_Y){
                //ЕСЛИ ЧО ТО ТУТ ДРОПНУТЬ KOSTIL_Y
                print("[",k-1+KOSTIL_X,"] [",j,"] ")
                if getIndexInputData(xF: k-1+KOSTIL_X, yF: j) != nil {
                    elem = getIndexInputData(xF: k-1+KOSTIL_X, yF: j)!
                    arrayPoint[elem].number = initializationNumber
                    initializationNumber += 1
                    arrayPoint[elem].priznak = lastSigns
                    change = true
                }
            }   /* --//-- по левому вертикальному столбцу*/
            print("\n")
            if change == true {
                if lastSigns == 0 {
                    lastSigns = 1
                } else {lastSigns = 0}
                change = false
            }
        }
        
        if chekEndRead() != true {
            if chekNextLineY(y: n-k, xStart: k, xFinish: m-k) == false {
                KOSTIL_Y = 1
            }
            if (k+KOSTIL_X <= m-k - 1){
            for j in (k+KOSTIL_X...m-k - 1) {
                //если чо, вернуть на for j in (k+KOSTIL_X...m-k) {
                print("[",j,"] [",n-k-KOSTIL_Y,"] иниц признака по строке верхней")
                if getIndexInputData(xF: j, yF: n-k-KOSTIL_Y) != nil {
                    elem = getIndexInputData(xF: j, yF: n-k-KOSTIL_Y)!
                    arrayPoint[elem].number = initializationNumber
                    initializationNumber += 1
                    arrayPoint[elem].priznak = lastSigns
                    change = true
                }
            }   /*Определение значений верхнего гор столбца*/
            }
            print("\n")
            if change == true {
                if lastSigns == 0 {
                    lastSigns = 1
                } else {lastSigns = 0}
                change = false
            }
        }
        
        if chekEndRead() != true {
            for j in stride(from: n-k-KOSTIL_Y, to: k-1-1, by: -1) {
                //если чо вернуть на for j in stride(from: n-k-1-KOSTIL_Y, to: k-1-1, by: -1) {
                print("[",m-k,"] [",j,"] ")
                if getIndexInputData(xF: m-k, yF: j) != nil {
                    elem = getIndexInputData(xF: m-k, yF: j)!
                    arrayPoint[elem].number = initializationNumber
                    initializationNumber += 1
                    arrayPoint[elem].priznak = lastSigns
                    change = true
                }
            }   /* --//-- По правому вертикальному столбцу*/
            print("\n")
            if change == true {
                if lastSigns == 0 {
                    lastSigns = 1
                } else {lastSigns = 0}
                change = false
            }
        }
        
        if chekEndRead() != true {
            for j in stride(from: m-k-1, to: k-1+KOSTIL_X, by: -1) {
                print("[",j,"] [",k-1,"] иниц признака по строке нижней")
                
                if getIndexInputData(xF: j, yF: k-1) != nil {
                    elem = getIndexInputData(xF: j, yF: k-1)!
                    arrayPoint[elem].number = initializationNumber
                    initializationNumber += 1
                    arrayPoint[elem].priznak = lastSigns
                    change = true
                }
                
            }   /* --//-- по нижнему горизонтальному столбцу*/
            print("\n")
            if change == true {
                if lastSigns == 0 {
                    lastSigns = 1
                } else {lastSigns = 0}
                change = false
            }
        }
    }
}

var min = 0
var buf = 0
var k = 0
var minIndex = 0
var menshiNumber = 999
var bolshiyNumber2 = 0

var i = 0
readingFromFile()
initializeMatrixSize()
initializationOfSigns()
initializationArrayPointEmpty()
paint()

while (flag == false) {
    
    minIndex = FindSecondMinimum(loopNumber: k, iLoop:i)
    print("-------Точки \(minIndex) и \(i)")
    
    if arrayPoint[minIndex].x == arrayPoint[i].x {
        var bol = arrayPoint[i].y
        var men = arrayPoint[minIndex].y
        if (arrayPoint[minIndex].y > arrayPoint[i].y) {
            bol = arrayPoint[minIndex].y
            men = arrayPoint[i].y
        }
        menshiNumber = lessNumberFunc(start: minIndex, end: i)
        
        
        if arrayPoint[minIndex].number == menshiNumber {
            bolshiyNumber2 = arrayPoint[i].number
        } else {
            bolshiyNumber2 = arrayPoint[minIndex].number
        }
        
        var k = men*2
        while (k <= bol*2) {
            setDataInArrayEmpty(x: arrayPoint[i].x*2, y: k, number: menshiNumber, picCharacter: "‖")
            k += 1
        }
        arrayPoint[minIndex].number = menshiNumber
        arrayPoint[i].number = menshiNumber
        repaintAll(lessNumber: menshiNumber, greaterNumber: bolshiyNumber2)
        
        chaekEnd()
        prnt()
        
    } else {
        if arrayPoint[minIndex].y == arrayPoint[i].y {
            var bol = arrayPoint[i].x
            var men = arrayPoint[minIndex].x
            menshiNumber = lessNumberFunc(start: minIndex, end: i)
            
            if arrayPoint[minIndex].number == menshiNumber {
                bolshiyNumber2 = arrayPoint[i].number
            } else {
                bolshiyNumber2 = arrayPoint[minIndex].number
            }
            
            if (arrayPoint[minIndex].x > arrayPoint[i].x) {
                bol = arrayPoint[minIndex].x
                men = arrayPoint[i].x
                
                var menNumber = arrayPoint[minIndex].number
                var menIndex = minIndex
                if (arrayPoint[minIndex].number > arrayPoint[i].number){
                    menNumber = arrayPoint[i].number
                    menIndex = i
                }
                
                var k = men*2
                while (k <= bol*2) {
                    setDataInArrayEmpty(x: k, y: arrayPoint[i].y*2, number: menshiNumber, picCharacter: "=")
                    k += 1
                }
                
                arrayPoint[minIndex].number = menshiNumber
                arrayPoint[i].number = menshiNumber
                repaintAll(lessNumber: menshiNumber, greaterNumber: bolshiyNumber2)
                chaekEnd()
                prnt()
            }
            
        } else {
            if (arrayPoint[i].priznak == 0) {
                makeWay0(start: i, end: minIndex)
                prnt()
            } else {
                makeWay1(start: i, end: minIndex)
                prnt()
            }
        }
    }
    if (i == arrayPoint.count-1){i = 0
        k = k+1
    } else {i = i + 1}
    paint()
    writengFromFile()
}
