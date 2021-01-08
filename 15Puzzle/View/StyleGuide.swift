//
//  StyleGuide.swift
//  15Puzzle
//
//  Created by Brandon Fong on 1/6/21.
//

import UIKit

extension UIFont {
    class var largeHeader: UIFont {
        return UIFont(name: "AvenirNext-Bold", size: 40)! // force unwrap because I know these exist in xcode
    }
    
    class var mediumHeader: UIFont {
        return UIFont(name: "AvenirNext-Bold", size: 30)! // force unwrap because I know these exist in xcode
    }
    
    
    class var subtitle: UIFont {
        UIFont(name: "AvenirNext-Regular", size: 17)!
    }
}

extension UIColor {
    class var boxColor: UIColor {
        return UIColor(red: 32/255, green: 115/255, blue: 152/255, alpha: 1.0)
    }
    
    class var appGray: UIColor {
        return UIColor(red: 202/255, green: 213/255, blue: 226/255, alpha: 1.0)
    }
    
    class var darkBlue: UIColor {
        return UIColor(red: 3/255, green: 32/255, blue: 60/255, alpha: 1.0)
    }
}
