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

/*
    Queue
*/
struct Queue<T> {

    /// Generic array type
    private var items = [T]()

    var isEmpty: Bool {
        return items.count == 0 ? true : false
    }

    /// Adding item to queue
    mutating func enqueue(item: T) {
        items.append(item)
    }

    /// Adding more than 1 item
    mutating func enqueue(arrayOfItem: [T]) {
        items += arrayOfItem
    }

    mutating func dequeue() -> T? {
        guard items.count > 0 else {
            return nil
        }

        let tempElement = items.first
        items.remove(at: 0)
        return tempElement
    }

}

var sampleQueue = Queue<Int>()
sampleQueue.enqueue(item: 10)
sampleQueue.enqueue(item: 20)

print(sampleQueue.dequeue()!)

/*
    Graph
*/
var graph = [String: [String]]()
graph["you"] = ["alice", "bob", "claire"]
graph["bob"] = ["anuj", "peggy"]
graph["alice"] = ["peggy"]
graph["claire"] = ["thom", "jonny"]
graph["anuj"] = []
graph["peggy"] = []
graph["thom"] = []
graph["jonny"] = []

func findMongoSeller(name: String) {
    var searchedPerson = [String]()
    var searchQueue = Queue<String>()
    searchQueue.enqueue(arrayOfItem: graph[name]!)

    while !searchQueue.isEmpty {
        guard let person = searchQueue.dequeue() else {
            return
        }

        if !searchedPerson.contains(person) {
            if person.last == "m" {
                print("Found mongo seller: \(person)")
                break
            } else {
                if let persons = graph[person] {
                    searchQueue.enqueue(arrayOfItem: persons)
                    searchedPerson.append(person)
                }
            }
        }
    }

}

findMongoSeller(name: "you")

/*
    Dijkstra Algorithm
*/

extension Dictionary where Value: Equatable {
    func getKey(forValue: Value) -> Key? {
        return first { $1 == forValue }?.key
    }
}

let startNode = "Start"
let finishNode = "Finish"

/// Defining all nodes and weight
var dijkstraGraph = [String: [String: Double]]()
dijkstraGraph[startNode] = ["A": 6, "B": 2]
dijkstraGraph["A"] = [finishNode: 1]
dijkstraGraph["B"] = ["A": 3, finishNode: 5]
dijkstraGraph[finishNode] = [:]

/// Defining costs dictionary
var costs = [String: Double]()
dijkstraGraph.forEach { key, value in
    value.forEach { innerKey, weight in
        costs[innerKey] = weight
    }
}

costs[finishNode] = Double.infinity

/// Defining parents dictionary
var parents = [String: String]()
dijkstraGraph.forEach { key, value in
    if key == startNode {
        value.forEach { innerKey, weight in
            parents[innerKey] = startNode
        }
    }
}

parents[finishNode] = "-"

/// An Array for processed node
var processedNode = [String]()

// Finding cheapest node
func findTheCheapestNode() -> String? {
    let filteredDict = costs.filter { !processedNode.contains($0.key) }
    let getMaxValue = Array(filteredDict.values).min()
    
    guard let wrappedMaxValue = getMaxValue, let foundedKey = costs.getKey(forValue: wrappedMaxValue) else {
        return nil
    }
    
    return foundedKey
}

print("Graph Before: \(graph)")
print("Cost Before: \(costs)")
print("Parents Before: \(parents)")

// Finding shortest path from `Start` to `Finish`
func findShortestPath() {
    var node = findTheCheapestNode()
    
    while node != nil {
        guard let wrappedNode = node, let cost = costs[wrappedNode], let neighbors = dijkstraGraph[wrappedNode] else {
            return
        }
        
        let neighborsKeys = neighbors.keys
        
        for n in neighborsKeys {
            guard let neighborsCost = neighbors[n], let currentCost = costs[n] else {
                return
            }
            
            let newCost = cost + neighborsCost
            if currentCost > newCost {
                costs[n] = newCost
                parents[n] = node
            }
        }
        
        processedNode.append(wrappedNode)
        node = findTheCheapestNode()
    }
    
}

findShortestPath()

print("//////////////////////////////////////////")
print("Graph After: \(graph)")
print("Cost After: \(costs)")
print("Parents After: \(parents)")
print("Processed Nodes: \(processedNode)")

/*
    Greedy Algorithm
*/

var stateNeeded: Set = ["mt", "wa", "or", "id", "nv", "ut", "ca", "az"]

var stations = [String: Set<String>]()
stations["kone"] = ["id", "nv", "ut"]
stations["ktwo"] = ["wa", "id", "mt"]
stations["kthree"] = ["or", "nv", "ca"]
stations["kfour"] = ["nv", "ut"]
stations["kfive"] = ["ca", "az"]

var finalStation = Set<String>()

func findBestStation() {
    while stateNeeded.count != 0 {
        var stateCoverd = Set<String>()
        var bestStation: String!
        
        for (station, stateForStation) in stations {
            let covered = stateNeeded.intersection(stateForStation)
            if covered.count > stateCoverd.count {
                bestStation = station
                stateCoverd = covered
            }
        }
        
        stateNeeded = stateNeeded.subtracting(stateCoverd)
        finalStation.insert(bestStation)
    }
    
    print("Final Stations: \(finalStation)")
}

findBestStation()
