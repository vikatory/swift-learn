//
//  FaceView.swift
//  FaceIt
//
//  Created by hejia on 16/5/30.
//  Copyright © 2016年 hejia. All rights reserved.
//

import UIKit

class FaceView: UIView {

    override func drawRect(rect: CGRect) {
        let skullRadius = min(bounds.size.width, bounds.size.height) / 2
        let skullCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        
        let skull = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0.0, endAngle: CGFloat(2 * M_PI), clockwise: false)
        skull.lineWidth = 5.0
        UIColor.blueColor().set()
        skull.stroke()
    }

}
