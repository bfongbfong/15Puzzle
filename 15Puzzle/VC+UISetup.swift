//
//  VC+UISetup.swift
//  15Puzzle
//
//  Created by Brandon Fong on 1/6/21.
//

import UIKit
import Spruce

extension ViewController {
    func setupUI() {
        self.view.backgroundColor = .white
        setupRestartButton()
        setupTitles()
        setupGrid()
        setupAllSpaces()
        updateBoard()
    }
    
    private func setupRestartButton() {
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(restartButton)
        
        restartButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        restartButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        restartButton.widthAnchor.constraint(equalTo: restartButton.heightAnchor).isActive = true
        restartButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        restartButton.backgroundColor = .clear
        restartButton.setImage(UIImage(named: "refresh"), for: .normal)
        restartButton.addTarget(self, action: #selector(refreshAction), for: .touchUpInside)
    }
    
    private func setupTitles() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleLabel)
        
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        NSLayoutConstraint(item: self.titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 0.4, constant: 0.0).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        titleLabel.font = .largeHeader
        titleLabel.textColor = .boxColor
        titleLabel.textAlignment = .center
        titleLabel.text = "15 Puzzle Game"
        

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(subtitleLabel)
        
        subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        subtitleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        subtitleLabel.font = .subtitle
        subtitleLabel.textColor = .darkBlue
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = "Slide in a direction to move the tiles."
    }
    
    private func setupGrid() {
        grid.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(grid)
        
        grid.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        grid.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: 50).isActive = true
        grid.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        grid.heightAnchor.constraint(equalTo: grid.widthAnchor).isActive = true
        grid.backgroundColor = .appGray
        grid.layer.cornerRadius = 10
        grid.clipsToBounds = true
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
                currentBox.frame = currentSpace.frame
                self.grid.addSubview(currentBox)
                currentBox.layer.cornerRadius = 10
            }
        }
    }
    
    /// Labels each box with a random number between 1...15, and picks a random box to remove.
    func setupLabels(_ numbers: [Int], _ emptyBoxXCoord: Int, _ emptyBoxYCoord: Int) {
        // label each box, and pick a random space to remove
        var numbersIndex = 0
        for j in 0..<spaces_boxes.count {
            for i in 0..<spaces_boxes[j].count {
                let (_, box) = spaces_boxes[i][j]
                box.backgroundColor = .boxColor

                if i == emptyBoxXCoord, j == emptyBoxYCoord {
                    // specify this as the empty box
                    box.backgroundColor = .clear
                    missingBoxCoords = (i, j)
                    box.number = nil
                    numbersIndex += 1
                    continue
                }

                box.number = numbers[numbersIndex]
                numbersIndex += 1
            }
        }
    }
    
    
    private func setupSpace(_ space: UIView) {
        let emptyGridColor: UIColor = .white
        space.translatesAutoresizingMaskIntoConstraints = false
        grid.addSubview(space)
        space.widthAnchor.constraint(equalTo: grid.widthAnchor, multiplier: divider, constant: -(totalGridMargin / 4)).isActive = true
        space.heightAnchor.constraint(equalTo: grid.heightAnchor, multiplier: divider, constant: -(totalGridMargin / 4)).isActive = true
        space.backgroundColor = emptyGridColor
        space.layer.cornerRadius = 10
    }
    
    private func setupTopRow(_ space: UIView) {
        space.topAnchor.constraint(equalTo: grid.topAnchor, constant: (totalGridMargin / 4 / 2)).isActive = true
    }
    
    private func setupMidTopRow(_ space: UIView) {
        NSLayoutConstraint(item: space, attribute: .centerY, relatedBy: .equal, toItem: grid, attribute: .centerY, multiplier: 0.75, constant: 0.0).isActive = true
    }
    
    private func setupMidBottomRow(_ space: UIView) {
        NSLayoutConstraint(item: space, attribute: .centerY, relatedBy: .equal, toItem: grid, attribute: .centerY, multiplier: 1.25, constant: 0.0).isActive = true
    }
    
    private func setupBottomRow(_ space: UIView) {
        space.bottomAnchor.constraint(equalTo: grid.bottomAnchor, constant: -(totalGridMargin / 4 / 2)).isActive = true
    }
    
    private func setupFarLeftCol(_ space: UIView) {
        space.leadingAnchor.constraint(equalTo: grid.leadingAnchor, constant: (totalGridMargin / 4 / 2)).isActive = true
    }
    
    private func setupMidLeftCol(_ space: UIView) {
        NSLayoutConstraint(item: space, attribute: .centerX, relatedBy: .equal, toItem: grid, attribute: .centerX, multiplier: 0.75, constant: 0).isActive = true
    }
    
    private func setupMidRightCol(_ space: UIView) {
        NSLayoutConstraint(item: space, attribute: .centerX, relatedBy: .equal, toItem: grid, attribute: .centerX, multiplier: 1.25, constant: 0).isActive = true
    }
    
    private func setupFarRightCol(_ space: UIView) {
        space.trailingAnchor.constraint(equalTo: grid.trailingAnchor, constant: -(totalGridMargin / 4 / 2)).isActive = true
    }
}
