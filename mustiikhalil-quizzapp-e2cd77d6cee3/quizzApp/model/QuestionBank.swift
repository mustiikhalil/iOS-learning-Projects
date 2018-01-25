//
//  QuestionBank.swift
//  quizzApp
//
//  Created by Mustafa Khalil on 1/23/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import Foundation

class QuestionBank {
    
    private var _list = [Question]()
    private var _number = 0
    var number: Int {get{return _number}}
    var count: Int {get{return _list.count}}
    var list: [Question]{ get {return _list }}
    
    
    init() {
        // Creating a quiz item and appending it to the list
        let item = Question(question: "Valentine\'s day is banned in Saudi Arabia.", answer: true)
        
        // Add the Question to the list of questions
        _list.append(item)
        
        // skipping one step and just creating the quiz item inside the append function
        _list.append(Question(question: "A slug\'s blood is green.", answer: true))
        
        _list.append(Question(question: "Approximately one quarter of human bones are in the feet.", answer: true))
        
        _list.append(Question(question: "The total surface area of two human lungs is approximately 70 square metres.", answer: true))
        
        _list.append(Question(question: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", answer: true))
        
        _list.append(Question(question: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", answer: false))
        
        _list.append(Question(question: "It is illegal to pee in the Ocean in Portugal.", answer: true))
        
        _list.append(Question(question: "You can lead a cow down stairs but not up stairs.", answer: false))
        
        _list.append(Question(question: "Google was originally called \"Backrub\".", answer: true))
        
        _list.append(Question(question: "Buzz Aldrin\'s mother\'s maiden name was \"Moon\".", answer: true))
        
        _list.append(Question(question: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", answer: false))
        
        _list.append(Question(question: "No piece of square dry paper can be folded in half more than 7 times.", answer: false))
        
        _list.append(Question(question: "Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.", answer: true))
    
    }
    
    func getQuestion() -> Question?{
        if _number == _list.count{
            return nil
        }
        let q = _list[number]
        _number += 1
        return q
    }
    
    func start(){
        _number = 0
    }
}
