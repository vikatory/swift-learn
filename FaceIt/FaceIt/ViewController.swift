//
//  ViewController.swift
//  FaceIt
//
//  Created by hejia on 16/5/30.
//  Copyright © 2016年 hejia. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    // model
    var expression = FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile) {
        didSet {
            updateUI()
        }
    }
    
    // view
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.changeScale(_:))))
            
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(FaceViewController.increaseHappiness))
            happierSwipeGestureRecognizer.direction = .Up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(FaceViewController.decreaseHappiness))
            sadderSwipeGestureRecognizer.direction = .Down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            
            updateUI()  //疑问，会不会覆盖该对象在其他地方被设置的didSet
        }
    }
    
    @IBAction func toggleEyes(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .Ended {
            switch expression.eyes {
            case .Open:
                expression.eyes = .Closed
            case .Closed:
                expression.eyes = .Open
            case.Squinting:
                break
            }
        }
    }
    
    func increaseHappiness() {
        expression.mouth = expression.mouth.happierMouth()
    }
    
    func decreaseHappiness() {
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    private var mouthCurvature = [FacialExpression.Mouth.Frown: -1.0, .Grin: 0.5, .Smile: 1.0, .Smirk: -0.5, .Neutral: 0.0]
    private var eyeBrowTiles = [FacialExpression.EyeBrows.Relaxed: 0.5, .Furrowed: -0.5, .Normal: 0.0]
    
    private func updateUI() {
        if faceView != nil {
            switch expression.eyes {
            case .Open: faceView.eyeOpen = true
            case .Closed: faceView.eyeOpen = false
            case .Squinting: faceView.eyeOpen = false
            }
            faceView.mouthCurvature = mouthCurvature[expression.mouth] ?? 0.0
            faceView.eyeBrowTilt = eyeBrowTiles[expression.eyeBrows] ?? 0.0
        }
    }
    
}

