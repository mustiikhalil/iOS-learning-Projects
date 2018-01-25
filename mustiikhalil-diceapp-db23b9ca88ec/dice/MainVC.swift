//
//  ViewController.swift
//  dice
//
//  Created by Mustafa Khalil on 1/23/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import SnapKit


let numberOfDice: UInt32 = 6
enum dice: Int, CustomStringConvertible{
    
    case dice1 = 0,dice2,dice3,dice4,dice5,dice6

    var description: String{
        switch self {
        case .dice1:
            return "dice1"
        case .dice2:
            return "dice2"
        case .dice3:
            return "dice3"
        case .dice4:
            return "dice4"
        case .dice5:
            return "dice5"
        default:
            return "dice6"
        }
    }
    static func random() -> dice{
        return dice(rawValue: Int(arc4random_uniform(numberOfDice)))!
    }
}

class MainVC: UIViewController {

    var mainImage: UIImageView?
    var dieImage1: UIImageView?
    var dieImage2: UIImageView?
    var button: UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = .blue
        setUI()
        setConstraints()
        updateImage()
    }

    func setUI(){
        let main = UIImage(named: "diceeLogo")
        
        mainImage = UIImageView(image: main)
        dieImage1 = UIImageView()
        dieImage2 = UIImageView()
        button = UIButton()
        
        mainImage?.contentMode = .scaleAspectFit
        dieImage1?.contentMode = .scaleAspectFill
        dieImage2?.contentMode = .scaleAspectFill

        button?.setTitle("Roll", for: .normal)
        button?.setTitleColor(UIColor.black, for: .normal)
        button?.addTarget(self, action: #selector(roll), for: .touchUpInside)
        button?.backgroundColor = .red
        
        self.view.addSubview(button!)
        self.view.addSubview(mainImage!)
        self.view.addSubview(dieImage1!)
        self.view.addSubview(dieImage2!)
    }
    
    @objc func roll(){
        updateImage()
    }
    
    func updateImage(){
        dieImage1?.image = UIImage(named: dice.random().description)
        dieImage2?.image = UIImage(named: dice.random().description)
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        updateImage()
    }
    
    func setConstraints(){
        mainImage?.snp.makeConstraints{
            (make) in
            make.top.equalTo(30)
            
            make.centerX.equalTo(view)
            make.width.height.equalTo(190)
        }
        dieImage1?.snp.makeConstraints{
            (make) in
            make.left.equalTo(29)
            make.top.equalTo(273)
            make.height.width.equalTo(120)
        }
        dieImage2?.snp.makeConstraints{
            (make) in
            make.left.equalTo(215)
            make.top.equalTo(273)
            make.height.width.equalTo(120)
        }
        button?.snp.makeConstraints{
            (make) in
            make.width.height.equalTo(90)
            make.centerX.equalTo(view)
            make.bottom.equalTo(-50)
        }
        
    }
}

