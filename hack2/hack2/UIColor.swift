//
//  UIColor.swift
//  hack2
//
//  Created by yojkim on 2017. 3. 4..
//  Copyright © 2017년 MashUp. All rights reserved.
//

import UIKit

extension UIColor {
    
    struct MainColor {
        static let LightGreen = UIColor(red:0.27, green:0.89, blue:0.82, alpha:1.0)
        static let LightBlue = UIColor(red:0.35, green:0.25, blue:0.82, alpha:1.0)
    }
    
    struct SubColor {
        static let DarkBlack = UIColor(red:0.26, green:0.26, blue:0.26, alpha:1.0)
        static let DarkPurple = UIColor(red:0.21, green:0.18, blue:0.38, alpha:1.0)
        static let DarkBlue = UIColor(red:0.30, green:0.44, blue:0.62, alpha:1.0)
    }
    
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)
            
            if hexColor.characters.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
    
}
