//
//  ViewController.swift
//  quizzApp
//
//  Created by Mustafa Khalil on 1/23/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import SnapKit
import ProgressHUD

class MainVC: UIViewController {
    
    var questionLabel: UILabel?
    var trueButton: UIButton?
    var falseButton: UIButton?
    var progressBar: UIView?
    var scoreHolder: UILabel?
    var questions: QuestionBank = QuestionBank()
    var currentQuestion: Question?
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hexNumber: 0x5C84F1)
        setUI()
        setConstraints()
        startGame()
    }
    
    func startGame(){
        score = 0
        scoreHolder?.text = "score: \(score)"
        questions.start()
        updateProgressBar()
        viewQuestion()
    }
    
    
    func viewQuestion(){
        
        if let question = questions.getQuestion(){
            self.currentQuestion = question
            questionLabel?.text = question.question
        }
    }
    
    @objc func correctAnswer(_ sender: UIButton){
        if self.currentQuestion == nil{
            
            return
        }
        
        if sender.tag == 1{
            questionChecker(type: true)
        }
        else{
            questionChecker(type: false)
        }
        
        if questions.number == questions.count{
            quizDone()
        }
    }
    
    
    func quizDone(){
        
        let alert = UIAlertController(title: "Quiz Done", message: "You have a score of \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "restart", style: .default, handler: {_ in self.startGame()}))
        self.present(alert, animated: true)
        
    }
    
    func questionChecker(type: Bool){
        
        updateProgressBar()
        if self.currentQuestion?.answer == type {
            veiwHUD(true)
            score += 1
            scoreHolder?.text = "score: \(score)"
            viewQuestion()
        }
        else{
            veiwHUD(false)
            viewQuestion()
        }
    }
    
    func veiwHUD(_ test: Bool){
        if test{
            ProgressHUD.showSuccess("Correct")
        }
        else{
            ProgressHUD.showError("Wrong")
        }
    }
    
    
    // set UI
    
    func setUI(){
        setUITrueButton()
        setUIFalseButton()
        setUIQuestionLabel()
        setUIScoreLabel()
        setUIProgressBar()
        
    }
    
    func setUIScoreLabel(){
        scoreHolder = UILabel()
        scoreHolder?.text = "score: \(score)"
        scoreHolder?.font = UIFont(name: "Cochin-BoldItalic", size: 50)!
        scoreHolder?.textAlignment = .center
        self.view.addSubview(scoreHolder!)
    }
    
    func setUIQuestionLabel(){
        
        questionLabel = UILabel()
        questionLabel?.textAlignment = .center
        questionLabel?.numberOfLines = 3
        questionLabel?.font = UIFont(name: "Cochin-BoldItalic", size: 36)!
        self.view.addSubview(questionLabel!)
    }
    
    func setUITrueButton(){
        trueButton = UIButton()
        trueButton?.tag = 1
        trueButton?.addTarget(self, action: #selector(correctAnswer), for: .touchUpInside)
        trueButton?.setTitle("True", for: .normal)
        trueButton?.backgroundColor = UIColor(hexNumber: 0xBE453B)
        self.view.addSubview(trueButton!)
    }
    
    func setUIFalseButton(){
        falseButton = UIButton()
        falseButton?.tag = 2
        falseButton?.addTarget(self, action: #selector(correctAnswer), for: .touchUpInside)
        falseButton?.setTitle("False", for: .normal)
        falseButton?.backgroundColor = UIColor(hexNumber: 0xBE453B)
        self.view.addSubview(falseButton!)
    }
    
    func setUIProgressBar(){
        progressBar = UIView()
        progressBar?.backgroundColor = UIColor(hexNumber: 0xE9A827)
        self.view.addSubview(progressBar!)
    }
    
    
    func setConstraints(){
        setConstraintScoreHolder()
        setConstraintQuestionLabel()
        setConstraintTrueButton()
        setConstraintFalseButton()
        setConstraintProgressBar()
    }
    
    func setConstraintScoreHolder(){
        scoreHolder?.snp.makeConstraints{
            (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(60)
        }
    }
    
    func setConstraintQuestionLabel(){
        questionLabel?.snp.makeConstraints{
            (make) in
            make.centerX.equalTo(view)
            make.top.equalTo((scoreHolder?.snp.bottom)!).offset(50)
            make.right.equalTo(-20)
            make.left.equalTo(20)
        }
    }
    
    func setConstraintTrueButton(){
        trueButton?.snp.makeConstraints{
            (make) in
            make.height.width.equalTo(90)
            make.centerY.equalTo(view)
            make.left.equalTo(50)
        }
    }
    
    func setConstraintFalseButton(){
        falseButton?.snp.makeConstraints{
            (make) in
            make.height.width.equalTo(90)
            make.centerY.equalTo(view)
            make.right.equalTo(-50)
        }
    }
    
    func setConstraintProgressBar(){
        progressBar?.snp.makeConstraints{
            (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.height.equalTo(30)
            make.width.equalTo(0)
        }
        
    }
    
    func updateProgressBar(){
        let width = (view.frame.width/13) * CGFloat(questions.number+1)
        progressBar?.snp.updateConstraints{
            (make) in
            make.width.equalTo(width)
        }
    }
    
    
    
}

