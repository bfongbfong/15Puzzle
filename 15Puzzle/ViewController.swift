//
//  ViewController.swift
//  15Puzzle
//
//  Created by Brandon Fong on 1/4/21.
//

import UIKit

class ViewController: UIViewController {
    
    let grid = UIView()
    let space0_0 = UIView()
    let space1_0 = UIView()
    let space2_0 = UIView()
    let space3_0 = UIView()
    let space0_1 = UIView()
    let space1_1 = UIView()
    let space2_1 = UIView()
    let space3_1 = UIView()
    let space0_2 = UIView()
    let space1_2 = UIView()
    let space2_2 = UIView()
    let space3_2 = UIView()
    let space0_3 = UIView()
    let space1_3 = UIView()
    let space2_3 = UIView()
    let space3_3 = UIView()
    
    let box0_0 = UIView()
    let box1_0 = UIView()
    let box2_0 = UIView()
    let box3_0 = UIView()
    let box0_1 = UIView()
    let box1_1 = UIView()
    let box2_1 = UIView()
    let box3_1 = UIView()
    let box0_2 = UIView()
    let box1_2 = UIView()
    let box2_2 = UIView()
    let box3_2 = UIView()
    let box0_3 = UIView()
    let box1_3 = UIView()
    let box2_3 = UIView()
    let box3_3 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        setupUI()
    }
    
    
    func addPanGesture(view: UIView) {
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    // Refactor
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        
        let box = sender.view!
        self.view.bringSubviewToFront(box)
        
        switch sender.state {
            
        case .began, .changed:
            moveViewWithPan(view: box, sender: sender)
        case .ended:
            print("pan ended")
        default:
            break
        }
    }
    
    
    func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    func setupUI() {
        setupGrid()
        setupAllSpaces()
        
        self.view.layoutIfNeeded()
        
        let boxColor: UIColor = .blue
        
        let boxes = [
            (box0_0, space0_0),
            (box1_0, space1_0),
            (box2_0, space2_0),
            (box3_0, space3_0),
            (box0_1, space0_1),
            (box1_1, space1_1),
            (box2_1, space2_1),
            (box3_1, space3_1),
            (box0_2, space0_2),
            (box1_2, space1_2),
            (box2_2, space2_2),
            (box3_2, space3_2),
            (box0_3, space0_3),
            (box1_3, space1_3),
            (box2_3, space2_3),
            (box3_3, space3_3),
        ]
        
        // label each box, and pick a random space to remove
        let skipIndex = Int.random(in: 0...15)
        var numbers = Array(1...15)
        var numbersIndex = 0
        numbers.shuffle()
        for i in 0..<boxes.count {
            if skipIndex == i {
                // specify this as the empty box
                continue
            }
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
            
            addPanGesture(view: box)
        }
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
        // left, top
        setupSpace(space0_0)
        setupTopRow(space0_0)
        setupFarLeftCol(space0_0)
        
        // mid left, top
        setupSpace(space1_0)
        setupTopRow(space1_0)
        setupMidLeftCol(space1_0)
        
        // mid right, top
        setupSpace(space2_0)
        setupTopRow(space2_0)
        setupMidRightCol(space2_0)
        
        // right, top
        setupSpace(space3_0)
        setupTopRow(space3_0)
        setupFarRightCol(space3_0)
        
        
        // left, mid top
        setupSpace(space0_1)
        setupMidTopRow(space0_1)
        setupFarLeftCol(space0_1)
        
        // mid left, mid top
        setupSpace(space1_1)
        setupMidTopRow(space1_1)
        setupMidLeftCol(space1_1)
        
        // mid right, mid top
        setupSpace(space2_1)
        setupMidTopRow(space2_1)
        setupMidRightCol(space2_1)
        
        // right, mid top
        setupSpace(space3_1)
        setupMidTopRow(space3_1)
        setupFarRightCol(space3_1)
        
        
        // left, mid bottom
        setupSpace(space0_2)
        setupMidBottomRow(space0_2)
        setupFarLeftCol(space0_2)
        
        // mid left, mid bottom
        setupSpace(space1_2)
        setupMidBottomRow(space1_2)
        setupMidLeftCol(space1_2)
        
        // mid right, mid bottom
        setupSpace(space2_2)
        setupMidBottomRow(space2_2)
        setupMidRightCol(space2_2)
        
        // right, mid bottom
        setupSpace(space3_2)
        setupMidBottomRow(space3_2)
        setupFarRightCol(space3_2)
        
        
        // left, bottom
        setupSpace(space0_3)
        setupBottomRow(space0_3)
        setupFarLeftCol(space0_3)
        
        // mid left, bottom
        setupSpace(space1_3)
        setupBottomRow(space1_3)
        setupMidLeftCol(space1_3)
        
        // mid right, bottom
        setupSpace(space2_3)
        setupBottomRow(space2_3)
        setupMidRightCol(space2_3)
        
        // right, bottom
        setupSpace(space3_3)
        setupBottomRow(space3_3)
        setupFarRightCol(space3_3)
    }
    
    
    private func setupSpace(_ space: UIView) {
        let emptyGridColor: UIColor = .white
        let divider: CGFloat = 0.24
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
