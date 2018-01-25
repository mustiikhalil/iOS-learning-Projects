//
//  ViewController.swift
//  retrocal
//
//  Created by Mustafa Khalil on 1/28/17.
//  Copyright © 2017 Mustafa Khalil. All rights reserved.
//

import UIKit
import AVFoundation

class RetroCal: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    
    var buttonSound: AVAudioPlayer!
    
    var runningNumber = ""
    
    enum Operations: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case empty = "Empty"
        
    }
    var leftValueStr = ""
    var rightValueStr = ""
    var result = ""
    var currentOperation = Operations.empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        
        do{
            try buttonSound = AVAudioPlayer(contentsOf: soundUrl)
            buttonSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }

    var flag = 1
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        if outputLabel.text == "0.0"{
        
        }
        else{
            if flag == 2{
                currentOperation = Operations.empty
                runningNumber = ""
                leftValueStr = ""
                rightValueStr = ""
                outputLabel.text = "0.0"
                flag = 0
            }
            else{
                runningNumber = ""
                rightValueStr = ""
                outputLabel.text = "0"
                flag += 1
            }
        }
        
    }
    
    @IBAction func operatorButtonPressed(btn: UIButton){
        playSound()
        switch btn.tag {
        case 1:
            processOperations(Operation: .Add)
        case 2:
            processOperations(Operation: .Subtract)
        case 3:
            processOperations(Operation: .Divide)
        case 4:
            processOperations(Operation: .Multiply)
        
        default:
            processOperations(Operation: currentOperation)
            
        }
    }
    
    
    @IBAction func buttonPressed(btn: UIButton){
        playSound()
        runningNumber += "\(btn.tag)"
        outputLabel.text = runningNumber
    }
    
    func playSound(){
        if buttonSound.isPlaying{
            buttonSound.stop()
        }
        buttonSound.play()
    }
    
    func processOperations(Operation: Operations){
        if currentOperation != Operations.empty{
            if runningNumber != ""{
                rightValueStr = runningNumber
                runningNumber = ""
                switch Operation {
                case Operations.Add :
                    result = "\(Double(leftValueStr)! + Double(rightValueStr)!)"
                    
                case Operations.Multiply :
                    result = "\(Double(leftValueStr)! * Double(rightValueStr)!)"
                    
                case Operations.Divide :
                    result = "\(Double(leftValueStr)! / Double(rightValueStr)!)"
                    
                default:
                    result = "\(Double(leftValueStr)! - Double(rightValueStr)!)"
                }
                
                leftValueStr = result
                outputLabel.text = result
            }
            
            currentOperation = Operation
            
        }else{
            leftValueStr = runningNumber
            runningNumber = ""
            currentOperation = Operation
            
        }
    }
    
}
