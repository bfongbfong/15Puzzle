//
//  VC+UISetup.swift
//  15Puzzle
//
//  Created by Brandon Fong on 1/6/21.
//

import UIKit

extension ViewController {
    func setupUI() {
        self.view.backgroundColor = .gray
        setupGrid()
        setupAllSpaces()
        setupLabels()
    }
    
    private func setupGrid() {
        grid.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(grid)
        
        grid.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        grid.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        grid.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        grid.heightAnchor.constraint(equalTo: grid.widthAnchor).isActive = true
        grid.backgroundColor = .white
    }
    
    private func setupAllSpaces() {
        for i in 0..<spaces_boxes.count {
            for j in 0..<spaces_boxes[i].count {
                let (currentSpace, currentBox) = spaces_boxes[j][i]
                setupSpace(currentSpace)
                currentBox.setup()
                
                switch i {
                case 0:
                    setupTopRow(currentSpace)
                case 1:
                    setupMidTopRow(currentSpace)
                case 2:
                    setupMidBottomRow(currentSpace)
                case 3:
                    setupBottomRow(currentSpace)
                default:
                    break
                }
                
                switch j {
                case 0:
                    setupFarLeftCol(currentSpace)
                case 1:
                    setupMidLeftCol(currentSpace)
                case 2:
                    setupMidRightCol(currentSpace)
                case 3:
                    setupFarRightCol(currentSpace)
                default:
                    break
                }
                
                self.view.layoutIfNeeded()
                currentBox.frame = currentSpace.bounds
                currentSpace.addSubview(currentBox)
            }
        }
    }
    
    func setupLabels() {
        let boxColor: UIColor = .blue
        // label each box, and pick a random space to remove
        let skipIndexI = Int.random(in: 0...3)
        let skipIndexJ = Int.random(in: 0...3)
        var numbers = Array(1...15)
        var numbersIndex = 0
        numbers.shuffle()
        for j in 0..<spaces_boxes.count {
            for i in 0..<spaces_boxes[j].count {
                let (_, box) = spaces_boxes[i][j]
                box.backgroundColor = boxColor

                if skipIndexI == i && skipIndexJ == j {
                    // specify this as the empty box
                    box.backgroundColor = .clear
                    missingBoxCoords = (i, j)
                    box.number = nil
                    continue
                }

                box.number = numbers[numbersIndex]
                numbersIndex += 1
            }
        }
    }
    
    
    private func setupSpace(_ space: UIView) {
        let emptyGridColor: UIColor = .clear
        space.translatesAutoresizingMaskIntoConstraints = false
        grid.addSubview(space)
        space.widthAnchor.constraint(equalTo: grid.widthAnchor, multiplier: divider).isActive = true
        space.heightAnchor.constraint(equalTo: grid.heightAnchor, multiplier: divider).isActive = true
        space.backgroundColor = emptyGridColor
    }
    
    private func setupTopRow(_ space: UIView) {
        space.topAnchor.constraint(equalTo: grid.topAnchor, constant: 0).isActive = true
    }
    
    private func setupMidTopRow(_ space: UIView) {
        NSLayoutConstraint(item: space, attribute: .centerY, relatedBy: .equal, toItem: grid, attribute: .centerY, multiplier: 0.745, constant: 0.0).isActive = true
    }
    
    private func setupMidBottomRow(_ space: UIView) {
        NSLayoutConstraint(item: space, attribute: .centerY, relatedBy: .equal, toItem: grid, attribute: .centerY, multiplier: 1.255, constant: 0.0).isActive = true
    }
    
    private func setupBottomRow(_ space: UIView) {
        space.bottomAnchor.constraint(equalTo: grid.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setupFarLeftCol(_ space: UIView) {
        space.leadingAnchor.constraint(equalTo: grid.leadingAnchor, constant: 0).isActive = true
    }
    
    private func setupMidLeftCol(_ space: UIView) {
        NSLayoutConstraint(item: space, attribute: .centerX, relatedBy: .equal, toItem: grid, attribute: .centerX, multiplier: 0.745, constant: 0.0).isActive = true
    }
    
    private func setupMidRightCol(_ space: UIView) {
        NSLayoutConstraint(item: space, attribute: .centerX, relatedBy: .equal, toItem: grid, attribute: .centerX, multiplier: 1.255, constant: 0.0).isActive = true
    }
    
    private func setupFarRightCol(_ space: UIView) {
        space.trailingAnchor.constraint(equalTo: grid.trailingAnchor, constant: 0).isActive = true
    }
}
