//
//  DetailexViewController.swift
//  project_jinsil
//
//  Created by SWUCOMPUTER on 2020/07/05.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class DetailexViewController: UIViewController {
    
    
    @IBOutlet var textPart: UITextField!
    @IBOutlet var textSort: UITextField!
    @IBOutlet var textHour: UITextField!
    @IBOutlet var textDate: UITextField!


    var detailEx: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let exercise = detailEx {
            textPart.text = exercise.value(forKey: "exPart") as? String
            textSort.text = exercise.value(forKey: "exSort") as? String
            textHour.text = exercise.value(forKey: "exHour") as? String


            let dbDate: Date? = exercise.value(forKey: "exDate") as? Date
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd h:mm a"
            if let unwrapDate = dbDate {
                textDate.text = formatter.string(from: unwrapDate as Date)
                
                }
        }
        
        
        
        

        // Do any additional setup after loading the view.
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
