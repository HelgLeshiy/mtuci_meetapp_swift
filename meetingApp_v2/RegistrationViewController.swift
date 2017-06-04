//
//  RegistrationViewController.swift
//  meetingApp_v2
//
//  Created by Alexander Melekhin on 31.05.17.
//  Copyright © 2017 Alexander Melekhin. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var surnameTextField: UITextField!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBAction func registerAction(_ sender: Any) {
        // создаем переменную со словарем из вводимых данных "ключ-данные", подразумевается, что все введено верно
        let parameters = ["email": emailTextField.text!, "password": passwordTextField.text!, "name": nameTextField.text!, "surname": surnameTextField.text!, "city": cityTextField.text!] as Dictionary<String,String>
       
        // создаем URL
        let url = URL(string: "http://172.20.10.4:8000/register/")
        
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
            
            do {
                // создает json объект из данных, полученных в ответ от сервера
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
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
