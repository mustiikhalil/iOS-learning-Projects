//
//  ViewController.swift
//  magic8
//
//  Created by Mustafa Khalil on 1/23/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import SnapKit

class MainVC: UIViewController {

    var button: UIButton?
    var label: UILabel?
    var image: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setConstraints()
        updateImage()
        self.view.backgroundColor = .cyan
    }
    
    func setUI(){
        button = UIButton()
        label = UILabel()
        image = UIImageView()
        image?.contentMode = .scaleAspectFit
        button?.setTitle("ask me", for: .normal)
        button?.backgroundColor = .blue
        button?.setTitleColor(UIColor.white, for: .normal)
        button?.addTarget(self, action: #selector(answerRandomizor), for: .touchUpInside)
        
        label?.text = "Ask me anything"
        label?.font = UIFont (name: "HelveticaNeue-Bold", size: 19)

        self.view.addSubview(button!)
        self.view.addSubview(label!)
        self.view.addSubview(image!)
        
    }
    @objc func answerRandomizor(){
        updateImage()
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        updateImage()
    }
    
    func updateImage(){
        image?.image = UIImage(named: answer.random().description)
    }
    
    
    func setConstraints(){
        button?.snp.makeConstraints{
            (make) in
            make.centerX.equalTo(view)
            make.width.equalTo(300)
            make.height.equalTo(70)
            make.left.equalTo(40)
            make.bottom.equalTo(-50)
        }
        image?.snp.makeConstraints{
            (make) in
            make.bottom.equalTo((button?.snp.top)!).offset(-70)
            make.centerX.equalTo(view)
            make.width.height.equalTo(350)
        }
        label?.snp.makeConstraints{
            (make) in
            make.centerX.equalTo(view)
            make.bottom.equalTo((image?.snp.top)!).offset(-50)
        }
    }
    
}


let numberOfAns: UInt32 = 5
enum answer: Int, CustomStringConvertible {
    
    case ans1 = 0, ans2, ans3, ans4, ans5
    
    var description: String{
        switch self {
        case .ans1:
            return "ball1"
        case .ans2:
            return "ball2"
        case .ans3:
            return "ball3"
        case .ans4:
            return "ball4"
        default:
            return "ball5"
        }
    }
    
    static func random() -> answer{
        return answer(rawValue: Int(arc4random_uniform(numberOfAns)))!
    }
}

