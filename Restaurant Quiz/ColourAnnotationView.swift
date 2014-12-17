//
//  ColourAnnotationView.swift
//  Restaurant Quiz
//
//  Created by Dominic Kuang on 12/16/14.
//  Copyright (c) 2014 Dominic Kuang. All rights reserved.
//

import UIKit
import MapKit

class ColourAnnotationView: MKAnnotationView {
    
    // Hue, in radians, between -pi and pi
    var hue: Float = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        self.centerOffset = CGPoint(x: 2, y: -15)
        self.calloutOffset = CGPoint(x: -8, y: 0)

    }
    
    override init!(annotation: MKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        let beginImage = CIImage(image: UIImage(named: "Pin"))
        
        let filter = CIFilter(name: "CIHueAdjust")
        filter.setValue(beginImage, forKey: kCIInputImageKey)
        filter.setValue(hue, forKey: kCIInputAngleKey)
        
        let newImage = UIImage(CIImage: filter.outputImage)
        newImage?.drawInRect(CGRect(x: 0, y: 0, width: 64, height: 64))
    }
}
