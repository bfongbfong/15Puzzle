////
////  Solvability.swift
////  15Puzzle
////
////  Created by Brandon Fong on 1/6/21.
////
//
//import Foundation
//
//class Solvability {
//    var gridDimensions = 4
//    var puzzle: [[Int]]
//    init(_ puzzle: [[Int]]) {
//        self.puzzle = puzzle
//    }
//
//    // A utility function to count inversions in given
//    // array 'arr[]'. Note that this function can be
//    // optimized to work in O(n Log n) time. The idea
//    // here is to keep code small and simple.
//    func getInvCount(_ arr: [Int]) -> Int {
//        let n = gridDimensions
//        var inversionCount = 0
//        for j in 0..<(n * n - 1) {
//            for i in j..<(n * n - 1) {
//                // count pairs(i, j) such that i appears
//                // before j, but i > j.
//                if arr[i] > arr[j] {
//                    inversionCount += 1
//                }
//            }
//        }
//        return inversionCount
//    }
//
//    // find Position of blank from bottom
//    func findXPosition(int puzzle[N][N]) -> Int {
//        // start from bottom-right corner of matrix
//        for (int i = N - 1; i >= 0; i--)
//            for (int j = N - 1; j >= 0; j--)
//                if (puzzle[i][j] == 0)
//                    return N - i;
//    }
//
//    // This function returns true if given
//    // instance of N*N - 1 puzzle is solvable
//    bool isSolvable(int puzzle[N][N])
//    {
//        // Count inversions in given puzzle
//        int invCount = getInvCount((int*)puzzle);
//
//        // If grid is odd, return true if inversion
//        // count is even.
//        if (N & 1)
//            return !(invCount & 1);
//
//        else     // grid is even
//        {
//            int pos = findXPosition(puzzle);
//            if (pos & 1)
//                return !(invCount & 1);
//            else
//                return invCount & 1;
//        }
//    }
//
//}
