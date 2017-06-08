//
//  UIColor+Extensions.swift
//  Breakfast
//
//  This file is from a dynamic framework I created called Breakfast. I included the
//  files here so you didn't have to install another Cocoapod to use and test out
//  this library. As such, this file may not be maintained as well, so use it at
//  your own risk.
//
//  SwiftSVG is one of the many great tools that are a part of Breakfast. If you're
//  looking for a great start to your next Swift project, check out Breakfast.
//  It contains classes and helper functions that will get you started off right.
//  https://github.com/mchoe/Breakfast
//
//
//  Copyright (c) 2015 Michael Choe
//  http://www.straussmade.com/
//  http://www.twitter.com/_mchoe
//  http://www.github.com/mchoe
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif


let namedColors: [String : CGColor] = [
    "none": UIColor.clear.cgColor
]

public extension UIColor {
    
    convenience init?(svgString: String) {
        if svgString.hasPrefix("#") {
            self.init(hexString: svgString)
            return
        }
        
        if svgString.hasPrefix("rgb") {
            self.init(rgbString: svgString)
            return
        }
        
        self.init(named: svgString)
    }
    
    convenience init(hexString: String) {
        
        var workingString = hexString
        if workingString.hasPrefix("#") {
            workingString = String(workingString.characters.dropFirst())
        }
        
        var hexRed = "00"
        var hexGreen = "00"
        var hexBlue = "00"
        
        if workingString.characters.count == 6 {
            hexRed = workingString[0...1]
            hexGreen = workingString[2...3]
            hexBlue = workingString[4...5]
        } else if workingString.characters.count == 3 {
            let redValue = workingString[0]
            let greenValue = workingString[1]
            let blueValue = workingString[2]
            hexRed = "\(redValue)\(redValue)"
            hexGreen = "\(greenValue)\(greenValue)"
            hexBlue = "\(blueValue)\(blueValue)"
        }
        
        let red = CGFloat(hexString: hexRed)
        let green = CGFloat(hexString: hexGreen)
        let blue = CGFloat(hexString: hexBlue)
        
        self.init(red: CGFloat(red / 255.0), green: CGFloat(green / 255.0), blue: CGFloat(blue / 255.0), alpha: 1.0)
    }
    
    convenience init(rgbString: String) {
        let valuesString = rgbString.characters.dropFirst(4).dropLast()
        let colorsArray = valuesString.split(separator: ",").map { (numberString) -> CGFloat in
            return CGFloat(String(numberString).trimmingCharacters(in: CharacterSet.whitespaces))!
        }
        self.init(red: colorsArray[0] / 255.0, green: colorsArray[1] / 255.0, blue: colorsArray[2] / 255.0, alpha: (colorsArray.count > 3 ? colorsArray[3] / 1.0 : 1.0))
    }
    
    convenience init?(named: String) {
        guard let namedColor = namedColors[named] else {
            return nil
        }
        self.init(cgColor: namedColor)
    }
    
    
}


