//
//  Solvability.swift
//  15Puzzle
//
//  Created by Brandon Fong on 1/6/21.
//

import Foundation

class Solvability {
    var gridDimensions = 4
    
    init(_ gridDimensions: Int) {
        self.gridDimensions = gridDimensions
    }
    
    // A utility function to count inversions in given
    // array 'arr[]'. Note that this function can be
    // optimized to work in O(n Log n) time. The idea
    // here is to keep code small and simple.
    private func getInvCount(_ arr: [Int]) -> Int {
        let n = gridDimensions
        var inversionCount = 0
        for i in 0..<(n * n - 1) {
            for j in i + 1..<(n * n) {
                // count pairs(i, j) such that i appears
                // before j, but i > j.
                if arr[i] != 100, arr[j] != 100, arr[i] > arr[j] {
//                    print("\(arr[i]) is greater than \(arr[j])")
                    inversionCount += 1
                }
            }
        }
        print("inversion count: \(inversionCount)")
        return inversionCount
    }
     
//    // find Position of blank from bottom
    /// Returns -1 if there is no blank
    private func findXPositionOfBlank(_ puzzle: [[Int]]) -> Int {
        let n = gridDimensions
        // start from bottom-right corner of matrix
        for i in stride(from: n - 1, through: 0, by: -1) {
            for j in stride(from: n - 1, through: 0, by: -1) {
                if puzzle[i][j] == 100 {
                    print("blank is on row \(n - i) from the bottom")
                    return n - i
                }
            }
        }
        // if no blank spot is found
        return -1
    }

    // This function returns true if given
    // instance of N*N - 1 puzzle is solvable
    func isSolvable(_ puzzle: [[Int]]) -> Bool {
        let n = gridDimensions
        // Count inversions in given puzzle
        let invCount = getInvCount(Array(puzzle.joined()))

        // If grid is odd, return true if inversion
        // count is even.
        if (n % 2 != 0) {
            return invCount % 2 == 0
        }
        
        else { // grid is even
            let pos = findXPositionOfBlank(puzzle)
            if pos % 2 == 0 {
                return invCount % 2 == 1
            }
            else {
                return invCount % 2 == 0
            }
        }
    }
}
