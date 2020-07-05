//
//  ExSaveViewController.swift
//  project_jinsil
//
//  Created by SWUCOMPUTER on 2020/07/05.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class ExSaveViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var textPart: UITextField!
    @IBOutlet var textSort: UITextField!
    @IBOutlet var textTime: UITextField!

    @IBOutlet var textStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        
        
        if textField == self.textPart {
                textField.resignFirstResponder()
                self.textSort.becomeFirstResponder()
            }
            else if textField == self.textSort {
                textField.resignFirstResponder()
                self.textTime.becomeFirstResponder()
            }
            
        
        textField.resignFirstResponder()
        return true }
    

    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        
        
        
        if textPart.text == "" {
            textStatus.text = "운동 부위를 입력하세요";return;
        }
        if textSort.text == "" {
            textStatus.text = "운동 종류를 입력하세요";return;
        }
        if textTime.text == "" {
            textStatus.text = "운동 시간(시)을 입력하세요";return;
        }
        
        let context = self.getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Exercise", in: context)
        // Exercise record를 새로 생성함
        let object = NSManagedObject(entity: entity!, insertInto: context)
        object.setValue(textPart.text, forKey: "exPart")
        object.setValue(textSort.text, forKey: "exSort")
        object.setValue(textTime.text, forKey: "exHour")
        object.setValue(Date(), forKey: "exDate")
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
