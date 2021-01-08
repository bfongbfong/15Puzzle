//
//  UserDefaults+Extensions.swift
//  15Puzzle
//
//  Created by Brandon Fong on 1/7/21.
//

import Foundation

extension UserDefaults {
    var numberOrder: [Int]? {
        get {
            return array(forKey: "number_order") as? [Int]
        }
        
        set {
            setValue(newValue, forKey: "number_order")
        }
    }
    
    var emptyBoxXCoord: Int {
        get {
            return integer(forKey: "empty_box_x_coordinate")
        }
        
        set {
            setValue(newValue, forKey: "empty_box_x_coordinate")
        }
    }
    
    var emptyBoxYCoord: Int {
        get {
            return integer(forKey: "empty_box_y_coordinate")
        }
        
        set {
            setValue(newValue, forKey: "empty_box_y_coordinate")
        }
    }
}
