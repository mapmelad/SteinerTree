//
//  main.swift
//  AKIT
//
//  Created by Semyon on 16.04.17.
//  Copyright © 2017 Semyon. All rights reserved.
//

import Foundation

struct point {
    let x: Int
    let y: Int
    var priznak: Int
    var number: Int
}
var lastMin = [0,1,2,3,4,5,6,7]
var arrayPoint = [
    point(x:0,y:1,priznak:0,number:1),
    point(x:0,y:3,priznak:0,number:2),
    point(x:1,y:6,priznak:1,number:3),
    point(x:4,y:5,priznak:0,number:4),
    point(x:3,y:0,priznak:1,number:5),
    point(x:2,y:2,priznak:0,number:6),
    point(x:2,y:4,priznak:0,number:7),
    point(x:3,y:3,priznak:1,number:8)
]

var arrayPointEmpty = [
    point(x:0,y:0,priznak:9,number:0),
    point(x:1,y:0,priznak:9,number:0),
    point(x:2,y:0,priznak:9,number:0),
    point(x:3,y:0,priznak:9,number:0),
    point(x:4,y:0,priznak:9,number:0),
    point(x:0,y:1,priznak:9,number:0),
    point(x:1,y:1,priznak:9,number:0),
    point(x:2,y:1,priznak:9,number:0),
    point(x:3,y:1,priznak:9,number:0),
    point(x:4,y:1,priznak:9,number:0),
    point(x:0,y:2,priznak:9,number:0),
    point(x:1,y:2,priznak:9,number:0),
    point(x:2,y:2,priznak:9,number:0),
    point(x:3,y:2,priznak:9,number:0),
    point(x:4,y:2,priznak:9,number:0),
    point(x:0,y:3,priznak:9,number:0),
    point(x:1,y:3,priznak:9,number:0),
    point(x:2,y:3,priznak:9,number:0),
    point(x:3,y:3,priznak:9,number:0),
    point(x:4,y:3,priznak:9,number:0),
    point(x:0,y:4,priznak:9,number:0),
    point(x:1,y:4,priznak:9,number:0),
    point(x:2,y:4,priznak:9,number:0),
    point(x:3,y:4,priznak:9,number:0),
    point(x:4,y:4,priznak:9,number:0),
    point(x:0,y:5,priznak:9,number:0),
    point(x:1,y:5,priznak:9,number:0),
    point(x:2,y:5,priznak:9,number:0),
    point(x:3,y:5,priznak:9,number:0),
    point(x:4,y:5,priznak:9,number:0),
    point(x:0,y:6,priznak:9,number:0),
    point(x:1,y:6,priznak:9,number:0),
    point(x:2,y:6,priznak:9,number:0),
    point(x:3,y:6,priznak:9,number:0),
    point(x:4,y:6,priznak:9,number:0)
]

var flag = false

//Получить элемент из матрицы
func getElement(xF:Int,yF:Int) -> point {
    var bufFunc = point(x: 99,y:99, priznak: 99, number: 99)
    for i in 0..<arrayPointEmpty.count {
        if (xF == arrayPointEmpty[i].x) && (yF==arrayPointEmpty[i].y) {
            bufFunc = arrayPointEmpty[i]
        }
    }
    return bufFunc
}

//Присваим ячейке матрицы номер
func setDataInArrayEmpty(x: Int, y: Int, number: Int) {
    var flag = false
    var k = 0
    while (k<=arrayPointEmpty.count) && (flag == false){
        if (x == arrayPointEmpty[k].x) && (y==arrayPointEmpty[k].y) {
            arrayPointEmpty[k].number = number
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
        k = arrayPoint[end].x
        while (k <= arrayPoint[start].x) {
            setDataInArrayEmpty(x: k, y: arrayPoint[yValue].y, number: lessNumber)
            k += 1
        }
    } else {
        k = arrayPoint[start].x
        while (k <= arrayPoint[end].x) {
            setDataInArrayEmpty(x: k, y: arrayPoint[yValue].y, number: lessNumber)
            k += 1
        }
    }
    
    if (arrayPoint[start].y > arrayPoint[end].y){
        k = arrayPoint[end].y
        while (k<=arrayPoint[start].y){
            setDataInArrayEmpty(x: arrayPoint[xValue].x, y: k, number: lessNumber)
            k += 1
        }
    } else {
        k = arrayPoint[start].y
        while (k<=arrayPoint[end].y){
            setDataInArrayEmpty(x: arrayPoint[xValue].x, y: k, number: lessNumber)
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
        k = arrayPoint[end].y
        while (k<=arrayPoint[start].y){
            setDataInArrayEmpty(x: arrayPoint[xValue].x, y: k, number: lessNumber)
            k += 1
        }
    } else {
        k = arrayPoint[start].y
        while (k<=arrayPoint[end].y){
            setDataInArrayEmpty(x: arrayPoint[xValue].x, y: k, number: lessNumber)
            k += 1
        }
    }
    
    if arrayPoint[start].x > arrayPoint[end].x {
        k = arrayPoint[end].x
        while (k <= arrayPoint[start].x) {
            setDataInArrayEmpty(x: k, y: arrayPoint[yValue].y, number: lessNumber)
            k += 1
        }
    } else {
        k = arrayPoint[start].x
        while (k <= arrayPoint[end].x) {
            setDataInArrayEmpty(x: k, y: arrayPoint[yValue].y, number: lessNumber)
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
    var min2 = 0
    var k = 0
    
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
                lastMin[iLoop] = minIndexLoop
            }
        }
    }
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

var min = 0
var buf = 0
var k = 0
var minIndex = 0
var menshiNumber = 999
var bolshiyNumber2 = 0

var i = 0
while (flag == false) {
    
    //for i in 0..<arrayPoint.count {
    
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
        
        var k = men
        while (k <= bol) {
            setDataInArrayEmpty(x: arrayPoint[i].x, y: k, number: menshiNumber)
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
                
                var k = men
                while (k <= bol) {
                    setDataInArrayEmpty(x: arrayPoint[i].x, y: k, number: menshiNumber)
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
    if (i == 7){i = 0
        k = k+1
    } else {i = i + 1}
    // if k == 2 {flag = true}
}


//for i in (0..<arrayPointEmpty.count) {
//    if arrayPointEmpty[i].x == 0 {
//        print ("\n")
//    }
//    print (arrayPointEmpty[i].number,terminator: " ")
//
//}
