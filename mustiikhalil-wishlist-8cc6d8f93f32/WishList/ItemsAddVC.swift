//
//  ItemsAddVC.swift
//  WishList
//
//  Created by Mustafa Khalil on 2/12/17.
//  Copyright © 2017 Mustafa Khalil. All rights reserved.
//

import UIKit
import CoreData

class ItemsAddVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var addItem: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    
    @IBOutlet weak var detialsField: UITextField!
    @IBOutlet weak var storePicker: UIPickerView!
    
    @IBOutlet weak var wishImage: RoundedImages!
    
    
    var stores = [Store]()
    
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let topitem = self.navigationController?.navigationBar.topItem{
            topitem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        storePicker.dataSource = self
        storePicker.delegate = self
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
//        let store1 = Store(context: context)
//        let store2 = Store(context: context)
//        let store3 = Store(context: context)
//        let store4 = Store(context: context)
//        store1.name = "bestBuy"
//        store2.name = "amazon"
//        store3.name = "ebay"
//        store4.name = "apple"
//        
//        AppDele.saveContext()
        
        attemtpFetch()
        if itemToEdit != nil{
            loadItemData()
        }
    }

    @IBAction func selectStorePressed(_ sender: Any) {
        
        addItem.isHidden = true
        storePicker.isHidden = false

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        storePicker.isHidden = true
        addItem.isHidden = false
    }
    
    
    func attemtpFetch(){
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        do{
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        }
        catch{
            let error = error as NSError
            print(error)
        }
    }
    @IBAction func savePressed(_ sender: Any) {
        let wish: Item!
        let picture = Image(context: context)
        
        picture.image = wishImage.image
        
        if itemToEdit == nil{
            wish = Item(context: context)
        }
        else{
            wish = itemToEdit
        }
        
        wish.toImage = picture
        
        if let title = titleTextField.text{
            wish.title = title
        }
        if let price = priceField.text{
            wish.price = (price as NSString).doubleValue
        }
        if let detail = detialsField.text{
            wish.details = detail
        }
        wish.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        AppDele.saveContext()
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    func loadItemData(){
        
        if let item = itemToEdit{
            titleTextField.text = item.title
            priceField.text = String(item.price)
            detialsField.text = item.details
            
            wishImage.image = itemToEdit?.toImage?.image as? UIImage
            
            if let itemStore = item.toStore{
                var index = 0
                repeat{
                    let s = stores[index]
                    if s.name == itemStore.name{
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                }while(index < stores.count)
            }
        }
    }
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        if itemToEdit != nil{
            context.delete(itemToEdit!)
            AppDele.saveContext()
        }
        _ = navigationController?.popViewController(animated: true)
    }

    
    @IBAction func addImage(_ sender: Any) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            wishImage.image = image
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}
