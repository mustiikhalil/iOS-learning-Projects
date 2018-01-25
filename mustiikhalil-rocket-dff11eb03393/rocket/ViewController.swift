//
//  ViewController.swift
//  rocket
//
//  Created by Mustafa Khalil on 1/14/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    private var boo = false
    private var ImageName = ""
    private var button: UIButton?
    private var cloud = "cloudsAndOrangeOval"
    private var rocketView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton()
        changeBackGround()
        
    }

    @objc func buttonAction(sender: UIButton!) {
        if let viewTag = self.view.viewWithTag(101){
            viewTag.removeFromSuperview()
            button?.removeFromSuperview()
        }
        changeBackGround()
        createRocket()
        showFront()
        animateRocket()
        addResetButton()
    }
    
    func addResetButton(){
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.frame = CGRect(x: 45, y: 500, width: 100, height: 100)
        button.addTarget(self, action: #selector("reset"), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    @objc func reset(){
        deleteViews()
        addButton()
        changeBackGround()
    }
    func deleteViews(){
        
        rocketView.removeFromSuperview()
        button.removeFromSuperview()
        
    }
    
    func animateRocket(){
        UIView.animate(withDuration: 0.9, animations: {
            self.rocketView.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: (700))
            self.view.layoutIfNeeded()
        })
    }
    
    func createRocket(){
        
        let image = UIImage(named: "rocketAndStream")
        rocketView = UIImageView(image: image)
        rocketView.tag = 101
        rocketView.frame = CGRect(x: 0, y: 450, width: self.view.frame.width, height: (700))
        self.view.addSubview(rocketView)
        
    }
    
    func changeBackGround(){
        ImageName = (boo ? "skyBG":"darkBlueBG")
        let Image = UIImage(named: ImageName)
        let backgroundImage = UIImageView(image: Image!)
        backgroundImage.tag = 101
        self.view.addSubview(backgroundImage)
        self.view.bringSubview(toFront: button!)
        boo = (boo ? false : true)
    }
    
    func showFront(){
        let image = UIImage(named: cloud)
        let frontImage = UIImageView(image: image!)
        frontImage.tag = 200
        frontImage.frame = CGRect(x: 0, y: 300, width: self.view.frame.width, height: (450))
        self.view.addSubview(frontImage)
        self.view.bringSubview(toFront: frontImage)
    }
    
    func addButton(){
        let buttonImage = UIImage(named: "powerButton")
        button = UIButton(type: .custom)
        button!.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button!.setImage(buttonImage, for: .normal)
        button!.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button!.tag = 100
        self.view.addSubview(button!)
    }
    
}

