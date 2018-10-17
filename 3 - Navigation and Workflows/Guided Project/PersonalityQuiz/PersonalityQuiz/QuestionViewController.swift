//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Justin Snider on 10/16/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var rangedStackView: UIStackView!
    
    var questionIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        
        let currentQuestion = questions[questionIndex]
        
        switch currentQuestion.type {
        case .single:
            singleStackView.isHidden = false
        case .multiple:
            multipleStackView.isHidden = false
        case .ranged:
            rangedStackView.isHidden = false
        }
    }

}
