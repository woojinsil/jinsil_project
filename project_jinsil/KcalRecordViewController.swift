//
//  KcalRecordViewController.swift
//  project_jinsil
//
//  Created by SWUCOMPUTER on 2020/07/05.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class KcalRecordViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet var textfood: UITextField!
    @IBOutlet var textkcal: UITextField!

    @IBOutlet var textStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        
        
    
    if textField == self.textfood {
            textField.resignFirstResponder()
            self.textkcal.becomeFirstResponder()
        }
       
    textField.resignFirstResponder()
    return true }
    
    
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
          
          
          
          if textfood.text == "" {
              textStatus.text = "음식을 입력하세요";return;
          }
          if textkcal.text == "" {
              textStatus.text = "칼로리를 입력하세요";return;
          }
         
          
          let context = self.getContext()
          let entity = NSEntityDescription.entity(forEntityName: "Kcal", in: context)
          // Kcal record를 새로 생성함
          let object = NSManagedObject(entity: entity!, insertInto: context)
          object.setValue(textfood.text, forKey: "food")
          object.setValue(textkcal.text, forKey: "kcal")
          object.setValue(Date(), forKey: "date")
        
          do {
              try context.save()
              print("saved!")
          }
          catch let error as NSError {
              print("Could not save \(error), \(error.userInfo)") }
          
          // 현재의 View를 없애고 이전 화면으로 복귀
          self.navigationController?.popViewController(animated: true)
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
