//
//  ViewController.swift
//  15Puzzle
//
//  Created by Brandon Fong on 1/4/21.
//

import UIKit

class ViewController: UIViewController {
    
    let grid = UIView()
    let firstSpace = UIView()
    let secondSpace = UIView()
    let thirdSpace = UIView()
    let fourthSpace = UIView()
    let fifthSpace = UIView()
    let sixthSpace = UIView()
    let seventhSpace = UIView()
    let eigthSpace = UIView()
    let ninthSpace = UIView()
    let tenthSpace = UIView()
    let eleventhSpace = UIView()
    let twelfthSpace = UIView()
    let thirteenthSpace = UIView()
    let fourteenthSpace = UIView()
    let fifteenthSpace = UIView()
    let sixteenthSpace = UIView()
    
    let firstBox = UIView()
    let secondBox = UIView()
    let thirdBox = UIView()
    let fourthBox = UIView()
    let fifthBox = UIView()
    let sixthBox = UIView()
    let seventhBox = UIView()
    let eigthBox = UIView()
    let ninthBox = UIView()
    let tenthBox = UIView()
    let eleventhBox = UIView()
    let twelfthBox = UIView()
    let thirteenthBox = UIView()
    let fourteenthBox = UIView()
    let fifteenthBox = UIView()
    let sixteenthBox = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        setupUI()
    }
    
    func setupSpace(_ space: UIView) {
        let emptyGridColor: UIColor = .white
        let divider: CGFloat = 0.24
        space.translatesAutoresizingMaskIntoConstraints = false
        grid.addSubview(space)
        space.widthAnchor.constraint(equalTo: grid.widthAnchor, multiplier: divider).isActive = true
        space.heightAnchor.constraint(equalTo: grid.heightAnchor, multiplier: divider).isActive = true
        space.backgroundColor = emptyGridColor
    }
    
    func setupTopRow(_ space: UIView) {
        space.topAnchor.constraint(equalTo: grid.topAnchor, constant: 0).isActive = true
    }
    
    func setupMidTopRow(_ space: UIView) {
        NSLayoutConstraint(item: space, attribute: .centerY, relatedBy: .equal, toItem: grid, attribute: .centerY, multiplier: 0.745, constant: 0.0).isActive = true
    }
    
    func setupMidBottomRow(_ space: UIView) {
        NSLayoutConstraint(item: space, attribute: .centerY, relatedBy: .equal, toItem: grid, attribute: .centerY, multiplier: 1.255, constant: 0.0).isActive = true
    }
    
    func setupBottomRow(_ space: UIView) {
        space.bottomAnchor.constraint(equalTo: grid.bottomAnchor, constant: 0).isActive = true
    }
    
    func setupFarLeftCol(_ space: UIView) {
        space.leadingAnchor.constraint(equalTo: grid.leadingAnchor, constant: 0).isActive = true
    }
    
    func setupMidLeftCol(_ space: UIView) {
        NSLayoutConstraint(item: space, attribute: .centerX, relatedBy: .equal, toItem: grid, attribute: .centerX, multiplier: 0.745, constant: 0.0).isActive = true
    }
    
    func setupMidRightCol(_ space: UIView) {
        NSLayoutConstraint(item: space, attribute: .centerX, relatedBy: .equal, toItem: grid, attribute: .centerX, multiplier: 1.255, constant: 0.0).isActive = true
    }
    
    func setupFarRightCol(_ space: UIView) {
        space.trailingAnchor.constraint(equalTo: grid.trailingAnchor, constant: 0).isActive = true
    }
    
    func setupUI() {
        
        grid.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(grid)
        
        grid.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        grid.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        grid.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        grid.heightAnchor.constraint(equalTo: grid.widthAnchor).isActive = true
        grid.backgroundColor = .white
        
        
        let boxes = [
            (firstBox, firstSpace),
            (secondBox, secondSpace),
            (thirdBox, thirdSpace),
            (fourthBox, fourthSpace),
            (fifthBox, fifthSpace),
            (sixthBox, sixthSpace),
            (seventhBox, seventhSpace),
            (eigthBox, eigthSpace),
            (ninthBox, ninthSpace),
            (tenthBox, tenthSpace),
            (eleventhBox, eleventhSpace),
            (twelfthBox, twelfthSpace),
            (thirteenthBox, thirteenthSpace),
            (fourteenthBox, fourteenthSpace),
            (fifteenthBox, fifteenthSpace),
            (sixteenthBox, sixteenthSpace),
        ]
        
        
        // left, top
        setupSpace(firstSpace)
        setupTopRow(firstSpace)
        setupFarLeftCol(firstSpace)
        
        // mid left, top
        setupSpace(secondSpace)
        setupTopRow(secondSpace)
        setupMidLeftCol(secondSpace)
        
        // mid right, top
        setupSpace(thirdSpace)
        setupTopRow(thirdSpace)
        setupMidRightCol(thirdSpace)
        
        // right, top
        setupSpace(fourthSpace)
        setupTopRow(fourthSpace)
        setupFarRightCol(fourthSpace)
        
        
        
        // left, mid top
        setupSpace(fifthSpace)
        setupMidTopRow(fifthSpace)
        setupFarLeftCol(fifthSpace)
        
        setupSpace(sixthSpace)
        setupMidTopRow(sixthSpace)
        setupMidLeftCol(sixthSpace)

        setupSpace(seventhSpace)
        setupMidTopRow(seventhSpace)
        setupMidRightCol(seventhSpace)

        setupSpace(eigthSpace)
        setupMidTopRow(eigthSpace)
        setupFarRightCol(eigthSpace)

        
        
        // left, mid bottom
        setupSpace(ninthSpace)
        setupMidBottomRow(ninthSpace)
        setupFarLeftCol(ninthSpace)

        setupSpace(tenthSpace)
        setupMidBottomRow(tenthSpace)
        setupMidLeftCol(tenthSpace)

        setupSpace(eleventhSpace)
        setupMidBottomRow(eleventhSpace)
        setupMidRightCol(eleventhSpace)

        setupSpace(twelfthSpace)
        setupMidBottomRow(twelfthSpace)
        setupFarRightCol(twelfthSpace)

        
        
        // left, bottom
        setupSpace(thirteenthSpace)
        setupBottomRow(thirteenthSpace)
        setupFarLeftCol(thirteenthSpace)

        setupSpace(fourteenthSpace)
        setupBottomRow(fourteenthSpace)
        setupMidLeftCol(fourteenthSpace)

        setupSpace(fifteenthSpace)
        setupBottomRow(fifteenthSpace)
        setupMidRightCol(fifteenthSpace)

        setupSpace(sixteenthSpace)
        setupBottomRow(sixteenthSpace)
        setupFarRightCol(sixteenthSpace)

        
        
        self.view.layoutIfNeeded()
        
        let boxColor: UIColor = .blue
        
        
        
        let skipIndex = Int.random(in: 0...15)
        var numbers = Array(1...15)
        var numbersIndex = 0
        numbers.shuffle()
        for i in 0..<boxes.count {
            if skipIndex == i { continue }
            let (box, space) = boxes[i]
            box.frame = space.bounds
            box.backgroundColor = boxColor
            space.addSubview(box)
            
            let numberLabel = UILabel()
            numberLabel.translatesAutoresizingMaskIntoConstraints = false
            box.addSubview(numberLabel)
            
            numberLabel.centerXAnchor.constraint(equalTo: box.centerXAnchor).isActive = true
            numberLabel.centerYAnchor.constraint(equalTo: box.centerYAnchor).isActive = true
            numberLabel.text = "\(numbers[numbersIndex])"
            numbersIndex += 1
        }
    }


}

