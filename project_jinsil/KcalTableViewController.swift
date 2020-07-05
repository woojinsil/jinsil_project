//
//  KcalTableViewController.swift
//  project_jinsil
//
//  Created by SWUCOMPUTER on 2020/07/05.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class KcalTableViewController: UITableViewController {
    
    @IBAction func buttonhome(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
              let naviViewController = storyboard.instantiateViewController(withIdentifier: "naviView")
              naviViewController.modalPresentationStyle = .fullScreen
              self.present(naviViewController, animated: true, completion: nil)
    }
    
    var meal : [NSManagedObject] = []

    func getContext () -> NSManagedObjectContext {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    // View가 보여질 때 자료를 DB에서 가져오도록 한다
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Kcal")
        do {
            meal = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)") }
        self.tableView.reloadData()
    }
    
    
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
        if segue.identifier == "toKCalView" {
        if let destination = segue.destination as? DetailkcalViewController {
        if let selectedIndex = self.tableView.indexPathsForSelectedRows?.first?.row {
        destination.detailkcal = meal[selectedIndex] }
        } }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meal.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kcal Cell", for: indexPath)
        
        let me = meal[indexPath.row]
               
               let dbDate: Date? = me.value(forKey: "date") as? Date
               let formatter: DateFormatter = DateFormatter()
               formatter.dateFormat = "yyyy-MM-dd h:mm a"
               if let unwrapDate = dbDate {
                   cell.textLabel?.text = formatter.string(from: unwrapDate as Date)
                  }
               cell.detailTextLabel?.text = me.value(forKey: "kcal") as? String

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
          // Return false if you do not want the specified item to be editable.
          return true
      }
    

    
      // Override to support editing the table view.
      override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == .delete {
              
              // Core Data 내의 해당 자료 삭제
              let context = getContext()
              context.delete(meal[indexPath.row])
              do {
                  try context.save()
                  print("deleted!")
              } catch let error as NSError {
              print("Could not delete \(error), \(error.userInfo)") }
              // 배열에서 해당 자료 삭제
             meal.remove(at: indexPath.row)
          
              tableView.deleteRows(at: [indexPath], with: .fade)
          }
      }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
