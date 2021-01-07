//
//  ViewController.swift
//  15Puzzle
//
//  Created by Brandon Fong on 1/4/21.
//

import UIKit

class ViewController: UIViewController {
    
    let grid = UIView()
    let gridDimensions = 4
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let restartButton = UIButton()
    var numbers: [Int] {
        get {
            if let numbers = UserDefaults.standard.numberOrder {
                return numbers
            } else {
                self.generateBoardData()
                return UserDefaults.standard.numberOrder!
            }
        }
        set {
            UserDefaults.standard.numberOrder = newValue
        }
    }
    /// This is used to signitiy in the data array of numbers that this box is the empty one. Making the array compatible with nil values would be too complicated.
    let numberToSignifyEmpty = 100
        
    // the spaces actually look the way i've organized them
    let space0_0 = UIView(), space1_0 = UIView(), space2_0 = UIView(), space3_0 = UIView(),
        space0_1 = UIView(), space1_1 = UIView(), space2_1 = UIView(), space3_1 = UIView(),
        space0_2 = UIView(), space1_2 = UIView(), space2_2 = UIView(), space3_2 = UIView(),
        space0_3 = UIView(), space1_3 = UIView(), space2_3 = UIView(), space3_3 = UIView()

    let box0_0 = Box(), box1_0 = Box(), box2_0 = Box(), box3_0 = Box(),
        box0_1 = Box(), box1_1 = Box(), box2_1 = Box(), box3_1 = Box(),
        box0_2 = Box(), box1_2 = Box(), box2_2 = Box(), box3_2 = Box(),
        box0_3 = Box(), box1_3 = Box(), box2_3 = Box(), box3_3 = Box()
    
    // space, box
    var spaces_boxes: [[(UIView, Box)]]!
    
    var missingBoxCoords: (Int, Int)!
    
    let divider: CGFloat = 0.25
    var totalGridMargin: CGFloat = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spaces_boxes = [
            [(space0_0, box0_0), (space1_0, box1_0), (space2_0, box2_0), (space3_0, box3_0)],
            [(space0_1, box0_1), (space1_1, box1_1), (space2_1, box2_1), (space3_1, box3_1)],
            [(space0_2, box0_2), (space1_2, box1_2), (space2_2, box2_2), (space3_2, box3_2)],
            [(space0_3, box0_3), (space1_3, box1_3), (space2_3, box2_3), (space3_3, box3_3)]
        ]
        
        setupUI()
        addGestureRecognizers()
    }
    
    private func addGestureRecognizers() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    // move these two to a utilies file
    func convertCoordToIndex(_ x: Int, _ y: Int, _ width: Int) -> Int {
        print("converting coordinate \(x), \(y)")
        let answer = (y * width) + x
        print("to \(answer)")
        return answer
    }
    
    func swapElements(in array: inout [Int], _ firstIndex: Int, _ secondIndex: Int) {
        let temp = array[firstIndex]
//        array.remove(at: firstIndex)
        array[firstIndex] = array[secondIndex]
//        array.insert(temp, at: secondIndex)
        array[secondIndex] = temp
    }
    
    func swapPositions(_ first: (Int, Int), _ second: (Int, Int)) {
        print(self.numbers)
        let firstIndex = convertCoordToIndex(first.0, first.1, gridDimensions)
        let secondIndex = convertCoordToIndex(second.0, second.1, gridDimensions)
        print("swapping index \(firstIndex) (\(self.numbers[firstIndex])) and \(secondIndex) (\(self.numbers[secondIndex]))")
        swapElements(in: &self.numbers, firstIndex, secondIndex)
        print(self.numbers)
    }
    
    
    // MARK: - User Interactions
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        let swipeDuration = 0.1
        let translationAmount = self.grid.frame.width * 0.255
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            self.view.isUserInteractionEnabled = false

            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
                // check for index out of bounds
                if missingBoxCoords.0 - 1 < 0 {
                    print("prevented index out of bounds on right")
                    self.view.isUserInteractionEnabled = true
                    return
                }
                let movingBoxCoords = (missingBoxCoords.0 - 1, missingBoxCoords.1)
                let movingBox = spaces_boxes[missingBoxCoords.0 - 1][missingBoxCoords.1].1
                let missingBox = self.spaces_boxes[self.missingBoxCoords.0][self.missingBoxCoords.1].1
                
                let missingSpace = self.spaces_boxes[self.missingBoxCoords.0][self.missingBoxCoords.1].0
                self.grid.bringSubviewToFront(movingBox)
                self.grid.sendSubviewToBack(missingSpace)

                UIView.animate(withDuration: swipeDuration) {
                    movingBox.transform = CGAffineTransform(translationX: translationAmount, y: 0)
                } completion: { (_) in
                    // replace missing box coords
                    self.swapPositions(movingBoxCoords, self.missingBoxCoords)
                    self.missingBoxCoords.0 = self.missingBoxCoords.0 - 1
                    self.postAnimateAction(missingBox, movingBox)
                }
            case .down:
                print("Swiped down")
                // check for index out of bounds
                if missingBoxCoords.1 - 1 < 0 {
                    print("prevented index out of bounds on down")
                    self.view.isUserInteractionEnabled = true
                    return
                }
                let movingBoxCoords = (missingBoxCoords.0, missingBoxCoords.1 - 1)
                let movingBox = spaces_boxes[missingBoxCoords.0][missingBoxCoords.1 - 1].1
                let missingBox = self.spaces_boxes[self.missingBoxCoords.0][self.missingBoxCoords.1].1
                let missingSpace = self.spaces_boxes[self.missingBoxCoords.0][self.missingBoxCoords.1].0

                
                self.grid.bringSubviewToFront(movingBox)
                self.grid.sendSubviewToBack(missingSpace)

                UIView.animate(withDuration: swipeDuration) {
                    movingBox.transform = CGAffineTransform(translationX: 0, y: translationAmount)
                } completion: { (_) in
                    self.swapPositions(movingBoxCoords, self.missingBoxCoords)
                    self.missingBoxCoords.1 = self.missingBoxCoords.1 - 1
                    self.postAnimateAction(missingBox, movingBox)
                }
            case .left:
                print("Swiped left")
                // check for index out of bounds
                if missingBoxCoords.0 + 1 >= spaces_boxes.count {
                    print("prevented index out of bounds on left")
                    self.view.isUserInteractionEnabled = true
                    return
                }
                let movingBoxCoords = (missingBoxCoords.0 + 1, missingBoxCoords.1)
                let movingBox = spaces_boxes[missingBoxCoords.0 + 1][missingBoxCoords.1].1
                let missingBox = self.spaces_boxes[self.missingBoxCoords.0][self.missingBoxCoords.1].1
                
                let missingSpace = self.spaces_boxes[self.missingBoxCoords.0][self.missingBoxCoords.1].0
                
                self.grid.bringSubviewToFront(movingBox)
                self.grid.sendSubviewToBack(missingSpace)

                UIView.animate(withDuration: swipeDuration) {
                    movingBox.transform = CGAffineTransform(translationX: -translationAmount, y: 0)
                } completion: { (_) in
                    // replace missing box coords
                    self.swapPositions(movingBoxCoords, self.missingBoxCoords)
                    self.missingBoxCoords.0 = self.missingBoxCoords.0 + 1
                    self.postAnimateAction(missingBox, movingBox)
                }
            case .up:
                print("Swiped up")
                // check for index out of bounds
                if missingBoxCoords.1 + 1 >= spaces_boxes[0].count {
                    print("prevented index out of bounds on up")
                    self.view.isUserInteractionEnabled = true
                    return
                }
                let movingBoxCoords = (missingBoxCoords.0, missingBoxCoords.1 + 1)
                let movingBox = spaces_boxes[missingBoxCoords.0][missingBoxCoords.1 + 1].1
                let missingBox = self.spaces_boxes[self.missingBoxCoords.0][self.missingBoxCoords.1].1
                let missingSpace = self.spaces_boxes[self.missingBoxCoords.0][self.missingBoxCoords.1].0

                
                self.grid.bringSubviewToFront(movingBox)
                self.grid.sendSubviewToBack(missingSpace)

                UIView.animate(withDuration: swipeDuration) {
                    movingBox.transform = CGAffineTransform(translationX: 0, y: -translationAmount)
                } completion: { (_) in
                    // replace missing box coords
                    self.swapPositions(movingBoxCoords, self.missingBoxCoords)
                    self.missingBoxCoords.1 = self.missingBoxCoords.1 + 1
                    self.postAnimateAction(missingBox, movingBox)
                }
            default:
                break
            }
        }
    }
    
    @objc func refreshAction() {
        let alert = UIAlertController(title: "Rescramble game?", message: "Are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
            self.generateBoardData()
            self.updateBoard()
        })
        self.present(alert, animated: true)
    }
    
    private func postAnimateAction(_ missingBox: Box, _ movingBox: Box) {
        self.view.isUserInteractionEnabled = true
        movingBox.transform = .identity
        missingBox.number = movingBox.number
        movingBox.number = nil
        movingBox.backgroundColor = .clear
        missingBox.backgroundColor = .boxColor
        // need to pass in the new numbers
        updateBoardData(self.numbers, self.missingBoxCoords.0, self.missingBoxCoords.1)
        if checkWin() {
            let alert = UIAlertController(title: "YOU WIN!", message: "Congratulations!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Play Again?", style: .default) { _ in
                self.generateBoardData()
                self.updateBoard()
            })
            self.present(alert, animated: true)
        }
    }

    
    // MARK: - Logic
    
    // returns true if it's a win
    func checkWin() -> Bool {
        var counter = 1
        for num in numbers {
            if num == numberToSignifyEmpty { continue }
            if counter != num {
                return false
            }
            counter += 1
        }
        return true
    }
    
    func generateBoardData() {
        let emptyBoxXCoord = Int.random(in: 0...3)
        let emptyBoxYCoord = Int.random(in: 0...3)
        let emptyIndex = convertCoordToIndex(emptyBoxXCoord, emptyBoxYCoord, 4)
        var numbers = Array(1...15) // 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
        numbers.shuffle()
        numbers.insert(numberToSignifyEmpty, at: emptyIndex)
        UserDefaults.standard.emptyBoxXCoord = emptyBoxXCoord
        UserDefaults.standard.emptyBoxYCoord = emptyBoxYCoord
        UserDefaults.standard.numberOrder = numbers
    }
    
    func updateBoard() {
        // there were numbers previously (the user has played before)
        // this is also a second layer safety net. the first check for this is in the getter for the numbers property
        guard let numbers = UserDefaults.standard.numberOrder else {
            generateBoardData()
            setupLabels(self.numbers, UserDefaults.standard.emptyBoxXCoord, UserDefaults.standard.emptyBoxYCoord)
            return
        }
        
        setupLabels(numbers, UserDefaults.standard.emptyBoxXCoord, UserDefaults.standard.emptyBoxYCoord)
    }
    
    func updateBoardData(_ numbers: [Int], _ emptyBoxXCoord: Int, _ emptyBoxYCoord: Int) {
        UserDefaults.standard.numberOrder = numbers
        UserDefaults.standard.emptyBoxXCoord = emptyBoxXCoord
        UserDefaults.standard.emptyBoxYCoord = emptyBoxYCoord
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
