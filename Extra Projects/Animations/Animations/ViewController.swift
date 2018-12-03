//
//  ViewController.swift
//  Animations
//
//  Created by Justin Snider on 11/30/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var barButtonItem: UIBarButtonItem!
    
    var blueView: UIView = UIView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
    var isPlaying: Bool = false
    var pauseButton: UIBarButtonItem?
    var playButton: UIBarButtonItem?
    var count: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pauseButton = UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(Play(_:)))
        playButton = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(Play(_:)))
        navigationItem.rightBarButtonItem = playButton
        
        blueView.backgroundColor = .blue
        view.addSubview(blueView)
    }

    @IBAction func Play(_ sender: UIBarButtonItem) {
        if isPlaying == false {
            isPlaying = true
            
            
            navigationItem.rightBarButtonItem = pauseButton
//        UIView.animate(withDuration: 5) {
//            self.blueView.backgroundColor = .green
//        }
        
//        UIView.animate(withDuration: 5) {
//            self.blueView.center.y += 200
//            self.blueView.frame.size.height = 300
//        }
        
//        UIView.animateKeyframes(withDuration: 6, delay: 0, options: .calculationModeLinear, animations: {
//
//            //RelativeStartTime and RelativeDuration represent a percentage of the duration of the enire animation        (6 seconds)
//
//            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
//                self.blueView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 1.3)
//            })
//
//            //Starts a quarter through the animation and lasts for 1/4 of the duration
//            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
//                self.blueView.alpha = 0
//            })
//
//            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
//                self.blueView.transform = .identity
//            })
//
//            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
//                self.blueView.alpha = 1
//            })
//        }) { (success) in
//
//        }
            
            
            CATransaction.begin()
            
            CATransaction.setCompletionBlock {
                self.blueView.transform = .identity
            }
            
            let animation = CAKeyframeAnimation(keyPath: "backgroundColor")
            
            animation.values = [UIColor.red.cgColor, UIColor.yellow.cgColor, UIColor.orange.cgColor, UIColor.purple.cgColor]
            animation.duration = 6
            animation.repeatCount = .infinity
            blueView.layer.add(animation, forKey: "backgroundColorAnimation")
            
            CATransaction.commit()
            
            let pausedTime = blueView.layer.timeOffset
            blueView.layer.speed = 1.0
            blueView.layer.timeOffset = 0.0
            let timeSincePause = blueView.layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
            blueView.layer.beginTime = timeSincePause
            
        } else {
            isPlaying = false
            navigationItem.rightBarButtonItem = playButton
            
            let pausedTime = blueView.layer.convertTime(CACurrentMediaTime(), from: nil)
            blueView.layer.speed = 0.0
            blueView.layer.timeOffset = pausedTime
        }
        
    }
    
}
