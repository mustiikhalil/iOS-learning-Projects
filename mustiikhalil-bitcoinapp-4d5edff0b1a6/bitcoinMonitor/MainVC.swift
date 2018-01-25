//
//  ViewController.swift
//  bitcoinMonitor
//
//  Created by Mustafa Khalil on 1/25/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    var final_URL = ""
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    var currentCurr: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        picker.delegate = self
        picker.dataSource = self
    }

    
    // MARK: picker delegates
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayOfCurrencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayOfCurrencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentCurr = row
        getBitcoinData(currency: arrayOfCurrencies[row])
        
    }
    
    // MARK: UI update
    
    func updateUI(conversion currency: Int) {
        
        priceLabel.text = "\(arrayOfCurrenciesSigns[currentCurr!])\(currency)"
        
    }
    
    // MARK: Networking
    
    func getBitcoinData(currency type: String){
        final_URL = API_URL + type
        Alamofire.request(final_URL).responseJSON{
            response in
            if response.result.isSuccess{
                if let responseValue = response.value{
                    self.parse(json: JSON(responseValue))
                }

            } else {
                print(response.error)
            }
        }
    }
    
    // MARK: parsing JSON
    
    func parse(json: JSON){
        updateUI(conversion: json["ask"].int!)
    }
}

