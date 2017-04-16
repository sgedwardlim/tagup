//
//  Extensions.swift
//  tagup
//
//  Created by Edward on 4/16/17.
//  Copyright © 2017 Edward. All rights reserved.
//

import UIKit

extension UIColor {
    
    /*
     Helper function for easy initalization of color by hexcode
    */
    convenience init(hex: Int) {
        let red = hex >> 16                 // shift hex code by 16 bits to the right
        let green = (hex >> 8) & 0x0000FF   // shift hex code by 8 bits to the right and clear all except first 8 bits
        let blue = hex & 0x0000FF           // clear all bits except first 8 bits
        
        // Check the values of red, green and blue, should be >= 0 && <= 255
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    }
}

