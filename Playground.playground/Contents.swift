import Foundation
import UIKit

// MARK: - Generate random integer array
func generateRandom(size: Int) -> [Int] {
    guard size > 0 else {
        return [Int]()
    }
    return Array(0..<size).shuffled()
}

let numbers = generateRandom(size: 10)


// MARK: - Chapter 2

/*
    Selection sort
*/
func selectionSort(list: [Int]) -> [Int] {
    var originalList = list

    for index in 0..<originalList.count - 1 {
        for swapIndex in (index + 1)..<originalList.count {
            if originalList[index] > originalList[swapIndex] {
                originalList.swapAt(index, swapIndex)
            }
        }
    }

    return originalList
}

print("Sorted Item: \(selectionSort(list: numbers))")

/*
    Stack Implementation
*/
class Stack<T> {
    private var array = [T]()

    func push(item: T) {
        array.append(item)
    }

    func pop() -> T? {
        guard let lastItem = array.last else {
            return nil
        }

        array.removeLast()
        return lastItem
    }
}

extension Stack: CustomStringConvertible {
    var description: String {
        "---------Stack---------\n \(array) \n-----------------------"
    }
}

let navStack = Stack<String>()
navStack.push(item: "Hi")
navStack.push(item: "Mahdi")

navStack.pop()

print(navStack.description)

/*
    Recursive Function
*/
func printNumberUntil(number: Int) {
    print(number)

    if number == 1 {
        return
    }

    printNumberUntil(number: number - 1)
}

print(printNumberUntil(number: 10))

func factorial(number: Int) -> Int {
    if number == 1 {
        return number
    } else {
        return number * factorial(number: number - 1)
    }
}

print("\(factorial(number: 5))")

func recursiveFibonachi(number: Int) -> Int {
    guard number > 0 else {
        return number
    }
    return recursiveFibonachi(number: number - 1) + recursiveFibonachi(number: number - 2)
}

print(abs(recursiveFibonachi(number: 6)))

func fibonachi(number: Int) {
    var a1 = 0
    var a2 = 1
    var calculatedNumber = 0

    for _ in 1..<number {
        calculatedNumber = a1 + a2

        print("First: \(a1), Second: \(a2) NextNumber: \(calculatedNumber)")

        a1 = a2
        a2 = calculatedNumber
    }
}

fibonachi(number: 12)

/*
    Quick Sort
*/

func quickSort(list: [Int]) -> [Int] {
    if list.count < 2 {
        return list
    } else {
        let middle = list.count / 2
        let pivot  = list[middle]

        let leftSide  = list.filter { $0 < pivot }
        let rightSide = list.filter { $0 > pivot}

        return quickSort(list: leftSide) + [pivot] + quickSort(list: rightSide)
    }
}

quickSort(list: numbers)

/*
  Multiple array number to each other
*/

let sampleArray = [5, 10, 7, 3]

func calculateMultipleNumber(list: [Int]) -> [Int] {
    var changeArray = list

    list.forEach { num in
        changeArray = changeArray.map { $0 * num }
    }

    return changeArray
}

calculateMultipleNumber(list: sampleArray)

func recursiveMultipleNumber(originalList: [Int], changeList: [Int]) -> [Int] {
    if originalList.count < 1 {
        return changeList
    } else {
        let changeOriginalList = Array(originalList[1..<originalList.count])
        print(changeOriginalList)
        return recursiveMultipleNumber(originalList: changeOriginalList, changeList: changeList.map {$0 * originalList[0]})
    }
}

recursiveMultipleNumber(originalList: sampleArray, changeList: sampleArray)
