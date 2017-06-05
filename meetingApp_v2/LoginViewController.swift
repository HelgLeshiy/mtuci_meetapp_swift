//
//  LoginViewController.swift
//  meetingApp_v2
//
//  Created by Alexander Melekhin on 31.05.17.
//  Copyright © 2017 Alexander Melekhin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var ipTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginAction(_ sender: UIButton) {
        let parameters = ["email": emailTextField.text!, "password": passwordTextField.text!] as Dictionary<String,String>
        
        // создаем URL
        let url = URL(string: "http://" + ipTextField.text! + ":8000/login/") // ip берем из текстового поля, дабы не пересобирать постоянно
        
        // создаем объект сессии
        let session = URLSession.shared
        
        // создаем URLRequest
        var request = URLRequest(url: url!)
        request.httpMethod = "POST" // устанавливает метод http на POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // передает словарь в nsdata объект и что-то еще делает
            
        } catch let error {
            print(error.localizedDescription)
            return
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var serverResponse: String = "default (not changed)"
        // создает dataTask используя объект session чтобы отправить данные на сервер
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let data = data else {
                print(error!.localizedDescription)
                return
            }
            
            serverResponse = String(data: data, encoding: String.Encoding.utf8)!
            print("Server response: " + serverResponse)
            //if (serverResponse == "ok") {
            //self.present(self.alertSuccess, animated: true, completion: nil)
            //}
        })
        task.resume()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
