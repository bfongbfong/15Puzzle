//
//  Box.swift
//  15Puzzle
//
//  Created by Brandon Fong on 1/6/21.
//

import UIKit

class Box: UIView {
    
    let numberLabel = UILabel()

    var number: Int! {
        didSet {
            if let number = number {
                numberLabel.text = "\(number)"
            } else {
                numberLabel.text = ""
            }
        }
    }
    
    func setup() {
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(numberLabel)

        numberLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        numberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
