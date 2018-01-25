//
//  ViewController.swift
//  WishList
//
//  Created by Mustafa Khalil on 2/10/17.
//  Copyright © 2017 Mustafa Khalil. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    var controller: NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
        //generatetestdata()
        

        attemptfetch()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections{
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! WishListCell
        configerCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        return cell
    }
    
    func configerCell(cell: WishListCell, indexPath: NSIndexPath){
        let item = controller.object(at: indexPath as IndexPath)
        cell.UIupdate(item: item)
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections{
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 141
    }
    
    func attemptfetch(){
        let fetchrequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        let dateSort = NSSortDescriptor(key: "created", ascending: true)
        let priceSort = NSSortDescriptor(key: "price", ascending: true)
        let titleSort = NSSortDescriptor(key: "title", ascending: true)
        
        let seg = segment.selectedSegmentIndex
        
        switch seg{
        case 0:
            fetchrequest.sortDescriptors = [dateSort]
        case 1:
            fetchrequest.sortDescriptors = [priceSort]
        default:
            fetchrequest.sortDescriptors = [titleSort]
            
        }
          
        let controller = NSFetchedResultsController(fetchRequest: fetchrequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        
        self.controller = controller
        
        do{
         try self.controller.performFetch()
        }
        catch {
            let error = error as NSError
            print(error)
        }
        
    }
    
    
    
    @IBAction func segmetChange(_ sender: Any) {
        attemptfetch()
        tableView.reloadData()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let indexPath = newIndexPath{
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case .update:
            if let indexPath = indexPath{
                let cell = tableView.cellForRow(at: indexPath) as! WishListCell
                configerCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case .move:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath{
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
    
    func generatetestdata(){
        let item = Item(context: context)
        item.title = "MacBook Pro"
        item.price = 2200.0
        item.details = "waiting for the new MBP"
        let item2 = Item(context: context)
        item2.title = "MacBook"
        item2.price = 1500.0
        item2.details = "waiting for the new MBP"
        let item3 = Item(context: context)
        item3.title = "MacBook Air"
        item3.price = 900.0
        item3.details = "waiting for the new MBP"
        
        AppDele.saveContext()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let object = controller.fetchedObjects, object.count >= 1{
            let editItem = object[indexPath.row]
            
            performSegue(withIdentifier: "ItemsAddVC", sender: editItem)
        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemsAddVC"{
            if let path = segue.destination as? ItemsAddVC{
                if let item = sender as? Item{
                    path.itemToEdit = item
                }
            }
        }
    
    }


}







