//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController{
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()

    }
    
    func setUI(){
        for i in 0..<7{
            let button = UIButton()
            let y = CGFloat((i+1)*90)
            button.tag = i+1
            button.frame = CGRect(x: 25, y: y, width: 350, height: 80)
            button.backgroundColor = getColor(color: color.random())
            button.addTarget(self, action: #selector(musicPlayer), for: .touchUpInside)
            self.view.addSubview(button)
            
        }
    }
    
    func getColor(color: color) -> UIColor{
        
            switch color {
            case .red:
                print("r")
                return UIColor.red
            case .blue:
                print("b")
                return UIColor.blue
            case .black:
                print("bl")
                return UIColor.black
            case .cyan:
                print("c")
                return UIColor.cyan
            case .purple:
                print("p")
                return UIColor.purple
            default:
                print("y")
                return UIColor.yellow
            }
    }
    
    @objc func musicPlayer(sender: UIButton){
        music(play: sender.tag)
    }
    
    func music(play: Int){
        let coinSound = URL(fileURLWithPath: Bundle.main.path(forResource: "note\(play)", ofType: "wav")!)
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: coinSound)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
        catch{
            print("error")
        }
        
    }
    
}


let numberOfColors: UInt32 = 7
enum color: Int,CustomStringConvertible{
    var description: String{
        switch self {
        default:
            return ""
        }
    }
    
    case red = 0, blue, black, yellow, purple, green, cyan
    
    static func random() -> color {
        return color(rawValue: Int(arc4random_uniform(numberOfColors)))!
    }
}

