//
//  ViewController.swift
//  MTECHLetters
//
//  Created by Justin Snider on 11/29/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {
    @IBOutlet weak var letterM: UILabel!
    @IBOutlet weak var letterT: UILabel!
    @IBOutlet weak var letterE: UILabel!
    @IBOutlet weak var letterC: UILabel!
    @IBOutlet weak var letterH: UILabel!
    @IBOutlet weak var animationButton: UIButton!
    
    var animationButtonTapped: Bool = false
    let myMediaPlayer = MPMusicPlayerApplicationController.applicationQueuePlayer
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myMediaPlayer.setQueue(with: MPMediaQuery.songs())
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func animationButtonTapped(_ sender: UIButton) {
        myMediaPlayer.play()
        if animationButtonTapped == false {
            animationButton.setTitle("Reset", for: .normal)
            UIView.animate(withDuration: 1.5, animations: {
                self.letterM.transform = CGAffineTransform(translationX: 0, y: 150)
                self.letterT.transform = CGAffineTransform(translationX: -80, y: 0)
                self.letterH.transform = CGAffineTransform(translationX: 0, y: 150)
                self.letterC.transform = CGAffineTransform(translationX: 75, y: 0)
            }) { (_) in
                if self.animationButtonTapped == true {
                    UIView.animate(withDuration: 1.5, animations: {
                        self.letterE.transform = CGAffineTransform(scaleX: 2, y: 2)
                    })
                }
            }
            animationButtonTapped = true
        } else {
            animationButton.setTitle("Play", for: .normal)
            UIView.animate(withDuration: 1.5, animations: {
                self.letterE.transform = CGAffineTransform(scaleX: 1, y: 1)
            }) { (_) in
                UIView.animate(withDuration: 1.5, animations: {
                    self.letterM.transform = CGAffineTransform(translationX: 0, y: 0)
                    self.letterT.transform = CGAffineTransform(translationX: 0, y: 0)
                    self.letterH.transform = CGAffineTransform(translationX: 0, y: 0)
                    self.letterC.transform = CGAffineTransform(translationX: 0, y: 0)
                })
            }
            animationButtonTapped = false
        }
    }
}

