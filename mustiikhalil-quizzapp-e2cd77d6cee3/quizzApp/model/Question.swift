//
//  Question.swift
//  quizzApp
//
//  Created by Mustafa Khalil on 1/23/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import Foundation


class Question{
    
    private let _question: String
    private let _answer: Bool
    var question: String{ get { return _question }}
    var answer: Bool{ get { return _answer }}
    
    init(question: String, answer: Bool) {
        self._question = question
        self._answer = answer
    }
    
}
