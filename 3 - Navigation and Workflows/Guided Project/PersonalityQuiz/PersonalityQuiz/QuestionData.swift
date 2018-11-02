//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Created by Justin Snider on 10/16/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import Foundation


struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}



struct Answer {
    var text: String
    var type: ThingType
}
var answersChosen: [Answer] = []

var questions: [Question] = [Question(text: "It's christmas time, how will you celebrate?",
                                      type: .single,
                                      answers: [
                                        Answer(text: "Hook up my homies", type: .plug),
                                        Answer(text: "Decorate and make sure it is exactly how you want.", type: .levelSlider),
                                        Answer(text: "You borrow money from your friends.", type: .creditCard),
                                        Answer(text: "You like to steal all your friends presents.", type: .cancerStick)]),
                             Question(text: "What activities do you enjoy?",
                                      type: .multiple,
                                      answers: [
                                        Answer(text: "Hanging out", type: .plug),
                                        Answer(text: "Organizing", type: .levelSlider),
                                        Answer(text: "Shopping", type: .creditCard),
                                        Answer(text: "Spitting", type: .cancerStick)]),
                             Question(text: "How much do you like people.",
                                      type: .ranged,
                                      answers: [
                                        Answer(text: "I hate them", type: .cancerStick),
                                        Answer(text: "I deal with them", type: .creditCard),
                                        Answer(text: "I like them", type: .levelSlider),
                                        Answer(text: "I love them", type: .plug)])
]

enum ThingType: Character {
    case plug = "🔌", levelSlider = "🎚", creditCard = "💳", cancerStick = "🚬"
    
    var definition: String {
        switch self {
        case .plug:
            return "You are the truest of homies and always have the stuff everyone needs."
        case .levelSlider:
            return "You are always so particular about things and have to be exact when it comes to everything."
        case .creditCard:
            return "You are always getting something using somebody elses resources to get it but you tend to always pay people back."
        case .cancerStick:
            return "You like to spend your time alone and add take value away from everyone elses lives."
        }
    }
}

enum ResponseType {
    case single, multiple, ranged
}
