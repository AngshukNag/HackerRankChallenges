//
//  MatrixLayerRotation.swift
//  HackerRankChallenges
//
//  Created by Angshuk Nag on 14/08/20.
//  Copyright © 2020 DreamWorks. All rights reserved.
//

import Foundation

func matrixRotation(matrix: [[Int]], r: Int) -> Void {
    var inputMatrix = matrix
        var rowCount = matrix.count
        var columnCount = matrix[0].count
        var loopCounter = 0
        repeat {
            inputMatrix = rotate(by: r, rowCount: rowCount, columnCount: columnCount, startIndex: (row: loopCounter, column: loopCounter), matrix: inputMatrix)
            loopCounter += 1
            rowCount -= 2
            columnCount -= 2
        } while (rowCount > 0 && columnCount > 0)
        printMatrix(matrix: inputMatrix)
}

private func findIndex(of elementNumber: Int, rowMax: Int, columnMax: Int, startIndex: (row: Int, column: Int)) -> (row: Int, column: Int) {
        var tempElementNumber = elementNumber
        var isRow = true
        var multiplierDecider = 1
        let index: (row: Int, column: Int) = startIndex
        for _ in 0..<4 {
            if tempElementNumber < (isRow ? rowMax : columnMax) {
                switch multiplierDecider {
                    case 1: return (row: (startIndex.row + tempElementNumber), column: startIndex.column)
                    case 2: return (row: (startIndex.row + rowMax), column: (startIndex.column + tempElementNumber))
                    case 3: return (row: (startIndex.row + (rowMax - tempElementNumber)), column: (startIndex.column + columnMax))
                    case 4: return (row: startIndex.row, column: (startIndex.column + (columnMax - tempElementNumber)))
                    default: break
                }
            } else {
                tempElementNumber -= (isRow ? rowMax : columnMax)
            }
            isRow = !isRow
            multiplierDecider += 1
        }
        return index
    }

private func rotate(by rotations: Int, rowCount: Int, columnCount: Int, startIndex: (row: Int, column: Int), matrix: [[Int]]) -> [[Int]] {
        var inputMatrix = matrix
        var tempElement = inputMatrix[startIndex.row][startIndex.column]
        var swapCount = 0
        let maxElements = (2 * (rowCount + columnCount)) - 4
        let rotations = rotations % maxElements
        var innerLoopCounter = 0
        let hcf = hcfOf(element1: maxElements, element2: rotations)
        var hcfCounter = 0
        repeat {
            repeat {
                innerLoopCounter += rotations
                innerLoopCounter %= maxElements
                let swapIndex = findIndex(of: innerLoopCounter, rowMax: rowCount - 1, columnMax: columnCount - 1, startIndex: startIndex)
                let interMediateElement = inputMatrix[swapIndex.row][swapIndex.column]
                inputMatrix[swapIndex.row][swapIndex.column] = tempElement
                tempElement = interMediateElement
                swapCount += 1
            } while (innerLoopCounter != hcfCounter && swapCount < maxElements)
            hcfCounter += 1
            innerLoopCounter = hcfCounter
            let index = findIndex(of: innerLoopCounter, rowMax: rowCount - 1, columnMax: columnCount - 1, startIndex: startIndex)
            tempElement = inputMatrix[index.row][index.column]
        } while(swapCount < maxElements && hcfCounter < hcf)
        return inputMatrix
    }

    func hcfOf(element1: Int, element2: Int) -> Int
    {
        if element1 < element2 {
            if element1 % element2 == 0 {
                return element1
            } else {
                return hcfOf(element1: (element1 % element2), element2: element1)
            }
        } else {
            if element2 % element1 == 0 {
                return element2
            } else {
                return hcfOf(element1: (element2 % element1), element2: element2)
            }
        }
    }
        
func printMatrix(matrix: [[Int]])
{
    var outputString = ""
    for element in matrix.enumerated() {
        var tempString = ""
        for index in 0..<element.element.count {
            tempString += "\(matrix[element.offset][index])"
            if index != element.element.count - 1 {
                tempString += " "
            }
        }
        outputString += tempString
        if element.offset != (matrix.count - 1) {
            outputString += "\n"
        }
    }
    print(outputString)
}
