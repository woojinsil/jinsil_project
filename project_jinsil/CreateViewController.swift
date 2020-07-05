//
//  CreateViewController.swift
//  project_jinsil
//
//  Created by SWUCOMPUTER on 2020/07/05.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController,UITextFieldDelegate {
    
       @IBOutlet var textName: UITextField!
       @IBOutlet var textsex: UITextField!
       @IBOutlet var textheight: UITextField!
       @IBOutlet var textweight: UITextField!
       @IBOutlet var textID: UITextField!
       @IBOutlet var textPassword: UITextField!
       @IBOutlet var labelStatus: UILabel!
       
       
       func textFieldShouldReturn (_ textField: UITextField) -> Bool {  //텍스트 입력 하면 다음 textfield 로 넘어감
           if textField == self.textName {
               textField.resignFirstResponder()
               self.textsex.becomeFirstResponder()
           }
           else if textField == self.textsex {
               textField.resignFirstResponder()
               self.textheight.becomeFirstResponder()
           }
           else if textField == self.textheight {
               textField.resignFirstResponder()
               self.textweight.becomeFirstResponder()
           }
           else if textField == self.textweight {
               textField.resignFirstResponder()
               self.textID.becomeFirstResponder()
           }
           else if textField == self.textID {
               textField.resignFirstResponder()
               self.textPassword.becomeFirstResponder()
           }
           textField.resignFirstResponder()
           return true
       }
       
       @IBAction func buttonSave() {
        
       
        
           // 필요한 자료가 모두 입력 되었는지 확인
           if textName.text == "" {
               labelStatus.text = "이름를 입력하세요";return;
           }
           if textsex.text == "" {
               labelStatus.text = "성별을 입력하세요";return;
           }
           if textheight.text == "" {
               labelStatus.text = "키(cm) 를 입력하세요"; return;
           }
           if textweight.text == "" {
               labelStatus.text = "몸무게(kg) 를 입력하세요"; return;
           }
           if textID.text == "" {
               labelStatus.text = "아이디를 입력하세요"; return;
           }
           if textPassword.text == "" {
               labelStatus.text = "비밀번호를 입력하세요"; return;
           }
           let urlString: String = "http://condi.swu.ac.kr/student/M06/login/insertUser_last.php"
           guard let requestURL = URL(string: urlString) else {
           return }
           var request = URLRequest(url: requestURL)
           request.httpMethod = "POST"
           let restString: String = "name=" + textName.text! + "&sex=" + textsex.text! + "&height=" + textheight.text! + "&weight=" + textweight.text! + "&userid=" + textID.text! + "&password=" + textPassword.text!
           
           request.httpBody = restString.data(using: .utf8)
           self.executeRequest(request: request)
        
    
           
           
       }
       @IBAction func buttonBack() {
       self.dismiss(animated: true, completion: nil)
       }
       
       func executeRequest (request: URLRequest) -> Void {
       let session = URLSession.shared
       let task = session.dataTask(with: request) { (responseData, response, responseError) in
       guard responseError == nil else { print("Error: calling POST")
       return }
       guard let receivedData = responseData else { print("Error: not receiving Data")
       return }
       if let utf8Data = String(data: receivedData, encoding: .utf8) { DispatchQueue.main.async { // for Main Thread Checker
       self.labelStatus.text = utf8Data
       print(utf8Data) // php에서 출력한 echo data가 debug 창에 표시됨
           
           }
       } }
       task.resume() }

    override func viewDidLoad() {
        super.viewDidLoad()

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
