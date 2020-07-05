//
//  DetailkcalViewController.swift
//  project_jinsil
//
//  Created by SWUCOMPUTER on 2020/07/05.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class DetailkcalViewController: UIViewController {

    
    @IBOutlet var textfood: UITextField!
    @IBOutlet var textkcal: UITextField!
    @IBOutlet var textdate: UITextField!

    var detailkcal : NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            
        if let meal = detailkcal {
                   textfood.text = meal.value(forKey: "food") as? String
                   textkcal.text = meal.value(forKey: "kcal") as? String

                   let dbDate: Date? = meal.value(forKey: "date") as? Date
                   let formatter: DateFormatter = DateFormatter()
                   formatter.dateFormat = "yyyy-MM-dd h:mm a"
                   if let unwrapDate = dbDate {
                       textdate.text = formatter.string(from: unwrapDate as Date)
                       
                       }

        // Do any additional setup after loading the view.
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
