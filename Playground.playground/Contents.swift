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
