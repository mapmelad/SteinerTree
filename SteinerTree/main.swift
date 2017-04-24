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

//Получить элемент структуры
func getElement(xF:Int,yF:Int) -> point {
    var bufFunc = point(x: 99,y:99, priznak: 99, number: 99)
    for i in 0..<arrayPointEmpty.count {
        if (xF == arrayPointEmpty[i].x) && (yF==arrayPointEmpty[i].y) {
            bufFunc = arrayPointEmpty[i]
        }
    }
    return bufFunc
}


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

//Прокладываем путь и присваимваем номера между двумя точка для признака 0
func makeWay0(start: Int, end: Int) {
    
    var k = 0
    let menshiNumber = lessNumber(start: start, end: end)
    
    var bolshiyNumber = 0
    if arrayPoint[start].number == menshiNumber {
        bolshiyNumber = arrayPoint[end].number
    } else {
        bolshiyNumber = arrayPoint[start].number
    }
    
    if arrayPoint[start].x > arrayPoint[end].x {
        k = arrayPoint[end].x
        while (k <= arrayPoint[start].x) {
            setDataInArrayEmpty(x: k, y: arrayPoint[start].y, number: menshiNumber)
            k += 1
        }
    } else {
        k = arrayPoint[start].x
        while (k <= arrayPoint[end].x) {
            setDataInArrayEmpty(x: k, y: arrayPoint[start].y, number: menshiNumber)
            k += 1
        }
    }
    
    if (arrayPoint[start].y > arrayPoint[end].y){
        k = arrayPoint[end].y
        while (k<=arrayPoint[start].y){
            setDataInArrayEmpty(x: arrayPoint[end].x, y: k, number: menshiNumber)
            k += 1
        }
    } else {
        k = arrayPoint[start].y
        while (k<=arrayPoint[end].y){
            setDataInArrayEmpty(x: arrayPoint[end].x, y: k, number: menshiNumber)
            k += 1
        }
    }
    
    
    arrayPoint[start].number = menshiNumber
    arrayPoint[end].number = menshiNumber
    repaintAll(lessNumber: menshiNumber, greaterNumber: bolshiyNumber)
}

//Прокладываем путь и присваимваем номера между двумя точка для признака 1
func makeWay1(start: Int, end: Int) {
    var k = 0
    let menshiNumber = lessNumber(start: start, end: end)
    var bolshiyNumber = 0
    if arrayPoint[start].number == menshiNumber {
        bolshiyNumber = arrayPoint[end].number
    } else {
        bolshiyNumber = arrayPoint[start].number
    }
    
    if (arrayPoint[start].y > arrayPoint[end].y){
        k = arrayPoint[end].y
        while (k<=arrayPoint[start].y){
            setDataInArrayEmpty(x: arrayPoint[start].x, y: k, number: menshiNumber)
            k += 1
        }
    } else {
        k = arrayPoint[start].y
        while (k<=arrayPoint[end].y){
            setDataInArrayEmpty(x: arrayPoint[start].x, y: k, number: menshiNumber)
            k += 1
        }
    }
    
    if arrayPoint[start].x > arrayPoint[end].x {
        k = arrayPoint[end].x
        while (k <= arrayPoint[start].x) {
            setDataInArrayEmpty(x: k, y: arrayPoint[end].y, number: menshiNumber)
            k += 1
        }
    } else {
        k = arrayPoint[start].x
        while (k <= arrayPoint[end].x) {
            setDataInArrayEmpty(x: k, y: arrayPoint[end].y, number: menshiNumber)
            k += 1
        }
    }
    
    arrayPoint[start].number = menshiNumber
    arrayPoint[end].number = menshiNumber
    repaintAll(lessNumber: menshiNumber, greaterNumber: bolshiyNumber)
}

func repaintAll(lessNumber: Int, greaterNumber: Int) {
    for i in (0..<arrayPointEmpty.count) {
        if arrayPointEmpty[i].number == greaterNumber{
            arrayPointEmpty[i].number = lessNumber
        }
    }
}

func lessNumber (start:Int, end: Int) -> Int{
    var men = 0
    if (arrayPoint[start].number > arrayPoint[end].number){
        men = arrayPoint[end].number
    } else {
        men = arrayPoint[start].number
    }
    return men
}

var min = 0
var buf = 0
var minIndex = 0
var menshiNumber = 999

var test: Int
for i in 0..<arrayPoint.count {
    
    //инициализируем минимум
    if i == arrayPoint.count-1 {
        min = abs(arrayPoint[arrayPoint.count-1].x - arrayPoint[i-1].x) + abs(arrayPoint[arrayPoint.count-1].y - arrayPoint[i-1].y)
        minIndex = i
    } else {
        min = abs(arrayPoint[arrayPoint.count-1].x - arrayPoint[i].x) + abs(arrayPoint[arrayPoint.count-1].y - arrayPoint[i].y)
        minIndex = i
    }
    
    for j in 0..<arrayPoint.count {
        if j != i {
            buf = abs(arrayPoint[j].x - arrayPoint[i].x) + abs(arrayPoint[j].y - arrayPoint[i].y)
            if (buf <= min)  {
                //&& (arrayPoint[j].number != arrayPoint[i].number)
                min = buf
                minIndex = j
            }
        }
    }
    
    if arrayPoint[minIndex].x == arrayPoint[i].x {
        
        var bol = arrayPoint[i].y
        var men = arrayPoint[minIndex].y
        if (arrayPoint[minIndex].y > arrayPoint[i].y) {
            bol = arrayPoint[minIndex].y
            men = arrayPoint[i].y
        }
        menshiNumber = lessNumber(start: minIndex, end: i)
        
        var k = men
        while (k <= bol) {
            setDataInArrayEmpty(x: arrayPoint[i].x, y: k, number: menshiNumber)
            k += 1
        }
        arrayPoint[minIndex].number = menshiNumber
        arrayPoint[i].number = menshiNumber
        
    } else {
        if arrayPoint[minIndex].y == arrayPoint[i].y {
            var bol = arrayPoint[i].x
            var men = arrayPoint[minIndex].x
            menshiNumber = lessNumber(start: minIndex, end: i)
            
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
            }
            
        } else {
            if (arrayPoint[i].priznak == 0) {
                makeWay0(start: i, end: minIndex)
            } else {
                makeWay1(start: i, end: minIndex)
            }
        }
    }
}


for i in stride(from: 6, to: -1, by: -1)  {
    for j in (0..<5) {
        var q = getElement(xF: j, yF: i)
        if j == 0 {
            print ("\n")
        }
        print(q.number,terminator: " ")
    }
}
print("\n")

//for i in (0..<arrayPointEmpty.count) {
//    if arrayPointEmpty[i].x == 0 {
//        print ("\n")
//    }
//    print (arrayPointEmpty[i].number,terminator: " ")
//
//}
